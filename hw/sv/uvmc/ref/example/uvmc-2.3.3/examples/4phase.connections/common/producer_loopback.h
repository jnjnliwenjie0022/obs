//============================================================================
// @(#) $Id: producer_loopback.h 1972 2021-05-20 10:17:03Z markma $
//============================================================================

//-----------------------------------------------------------//
//   Copyright 2023 Siemens EDA                              //
//                                                           //
//   Licensed under the Apache License, Version 2.0 (the     //
//   "License"); you may not use this file except in         //
//   compliance with the License.  You may obtain a copy of  //
//   the License at                                          //
//                                                           //
//       http://www.apache.org/licenses/LICENSE-2.0          //
//                                                           //
//   Unless required by applicable law or agreed to in       //
//   writing, software distributed under the License is      //
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR  //
//   CONDITIONS OF ANY KIND, either express or implied.      //
//   See the License for the specific language governing     //
//   permissions and limitations under the License.          //
//-----------------------------------------------------------//

#ifndef PRODUCER_LOOPBACK_H
#define PRODUCER_LOOPBACK_H

#include <string>
#include <iomanip>
//#include <stdlib>
using std::string;

#include <systemc.h>
#include <tlm.h>
using namespace sc_core;
using namespace tlm;

#include "simple_initiator_socket.h"
using tlm_utils::simple_initiator_socket;

#include "simple_target_socket.h"
using tlm_utils::simple_target_socket;

#ifndef NUM_TRANSACTIONS
#define NUM_TRANSACTIONS 81920
#endif

#ifndef PAYLOAD_NUM_BYTES
#define PAYLOAD_NUM_BYTES 2048
#endif

//________________                                              ______________
// class producer \____________________________________________/ johnS 7-15-23
//----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Title: SC -> SV -> SC 4-phase loopback example
//
//-------------------
// Topic: Description of SC producer module
//
// This is a generic ~producer~ module that creates ~tlm_generic_payload~
// transactions and sends them out its ~out~ initiator socket in th SC -> SV
// direction. It then receives looped back transactions via its ~in~ target
// socket in the SV -> SC direction.
//
// The SC -> SV direction uses 4-phase semantics as described in the TLM-2.0
// base protocol, namely BEGIN_REQ, END_REQ, BEGIN_RESP, END_RESP. As such it
// is implemented with a ~callin~ to ~nb_transport_fw()~ via its SC initiator
// port feeding the SV target port for the REQ phases, followed by a ~callback~
// to ~nb_transport_bw()~ on the same initiator port for the RESP phases.
//
// In between the REQ and RESP phases described above, for the SV -> SC
// direction the SV initiator port simply uses 2-phase ~b_transport()~
// operation to loop back the transaction.
//
// The original SC -> SV direction RESP phases are only completed after the
// SV -> SC loopback ~b_transport()~ operation completes.
//
// This operation is depicted here,
//
// |   i == initiator('out')                          -> 'callin'
// |   t == target('in')                              :: 'callback'
// |
// |                    SC          language           SV
// |                 producer       boundary        loopback
// |     /                             |
// |    |  i->nb_transport_fw(t) ----> | ----> t::nb_transport_fw(t) - +
// |    |                         REQ  |                               |
// |    |                              |                               |
// |    |                              |                               |
// | 4  |   2                          |                               |
// | -  |   -  /                       |                               |
// | p /    p /  t::b_transport(t) <-- | <-- i->b_transport(t) - - - - +
// | h \    h \        |               |
// | a  |   a  \       + return    --> | --> return  - - - - - - - - - +
// | s  |   s                          |                               |
// | e  |   e                          |                               |
// |    |                              |                               |
// |    |                         RESP |                               |
// |    |  i::nb_transport_bw(t) <---- | <---- t->nb_transport_bw(t) - +
// |     \
//
// For transaction preservation to work correctly in the ~producer~ initiator's
// ~nb_transport_bw()~ callback it is expected that the transaction ref ~t~
// is the same as that originally passed via the initiator's call to
// ~nb_transport_fw()~. Thus the ~t~ ref is ~preserved~. If the ~loopback~
// module does not follow this rule a WARNING will result as well as potential
// memory leak.

// (begin inline source)
class producer : public sc_module {
  public:
  simple_initiator_socket<producer> out; // uses tlm_gp
  simple_target_socket<producer> in; // defaults to tlm_gp

  int num_trans;
  sc_event done;
  sc_event respWasReceived;

  tlm_generic_payload *currentGp;

  unsigned long long expected_checksum, actual_checksum;

  producer(sc_module_name nm) : out("out"), in("in"),
                                num_trans(NUM_TRANSACTIONS),
                                expected_checksum(0LL),
                                actual_checksum(0LL) {
    SC_THREAD(run);
    in.register_b_transport(this, &producer::b_transport);
    out.register_nb_transport_bw(this, &producer::nb_transport_bw);
  }

  SC_HAS_PROCESS(producer);
// (end inline source)

//-------------------
// Topic: How the test works
//
// The above operation is implemented in the ~producer~ module's ~run()~
// method which is set up as an ~SC_THREAD~.
//
// Notice that the ~producer~ must also furnish the ~nb_transport_bw()~
// callback function for its ~out~ initiator port.
//
// The main ~run()~ test thread function will work in 2 ways,
//
// - First 32 transactions will be sent without enabling memory management in
//   the UVM-Connect'ion. This means the user will get warnings because
//   allocated transactions in the infrastructure will not match transactions
//   sent by the the ~loopback~ module in the RESP phases which result in calls
//   to ~producer::nb_transport_bw()~.
//
// - Remaining 96 transactions will have memory management enabled and
//   therefore will reflect TLM GPs received in REQ phase (calls to
//   ~nb_transport_fw()~ back to the RESP phase (callbacks to
//   ~nb_transport_bw()~).
//
// When the transaction is received in the ~nb_transport_bw()~ function the
// data payload is accumulated in an overall checksum which is compared at the
// end to an expected checksum to verify the transactions were properly
// received through the loopback paths.
//-----------------------------------------------------------------------------

// (begin inline source)
  void run() {
    tlm_generic_payload gp; 
    tlm_phase phase;
    tlm_sync_enum result;
    unsigned char *data = new unsigned char [PAYLOAD_NUM_BYTES];
    sc_time delay;

    static bool isTransMmEnabled = false;

    currentGp = &gp;

    sc_dt::uint64 address = 0x40000000;

    gp.set_command(TLM_WRITE_COMMAND);
    gp.set_data_length( PAYLOAD_NUM_BYTES );

    cout << sc_time_stamp()
         << " [PRODUCER/GP/SEND]"
         << " cmd: " << gp.get_command()
         << " addr:" << hex << gp.get_address()
         << " PAYLOAD_NUM_BYTES:" << dec << gp.get_data_length()
         << " NUM_TRANSACTIONS:" << dec << NUM_TRANSACTIONS
         << endl;

    unsigned offset = 0;

    wait( 1, SC_NS ); // Give SV side a chance to become UVM-Connect'ed

    for( int i=0; i<num_trans; i++ ){
      if( i >= 32 && isTransMmEnabled == false ){
          uvmc_enable_trans_mm();
          isTransMmEnabled = true;
      }

      gp.set_address( address );
      gp.set_response_status( tlm::TLM_INCOMPLETE_RESPONSE );

      for( unsigned i=0; i<PAYLOAD_NUM_BYTES; i++ ) {
        data[i] = (i+offset) & 0xff;  // Rotating incrementing pattern.
        expected_checksum += data[i];
      }

      gp.set_data_ptr(data);
      delay = sc_time( 10, SC_NS );

      phase = BEGIN_REQ;

//    out->b_transport( gp, delay );
      result = out->nb_transport_fw( gp, phase, delay );
      if( result != TLM_UPDATED || phase != END_REQ
            || gp.get_response_status() != TLM_OK_RESPONSE )
        fprintf( stdout,
            "ERROR: %s Unexpected "
            "response from call to out->nb_transport_fw() "
            "[line #%d of '%s']\n", "producer::run()", __LINE__, __FILE__ );

      wait( respWasReceived );

      address += PAYLOAD_NUM_BYTES;
      offset++;
    }

    cout << endl
         << sc_time_stamp()
         << " [PRODUCER/ENDING] " << endl;;

    if( actual_checksum > 0 && actual_checksum == expected_checksum )
      fprintf( stdout,
        "expected_checksum=%llx == actual_checksum=%llx test PASSED !\n",
        expected_checksum, actual_checksum );
    else
      fprintf( stdout,
        "expected_checksum=%llx != actual_checksum=%llx test FAILED !\n",
        expected_checksum, actual_checksum );

    uvmc_tlm_gp_mm_base::printAllStats();
    uvmc_trans_mm_base::printAllStats();

    fflush( stdout );

    delete [] data;

    done.notify();
  }

    virtual tlm_sync_enum nb_transport_bw(
        tlm_generic_payload &gp, tlm_phase &phase, sc_time &t)
    {
        char unsigned *data = gp.get_data_ptr();

        phase = END_RESP;
        gp.set_response_status( TLM_OK_RESPONSE );

        if( &gp != currentGp )
            fprintf( stdout,
                "WARNING: %s Received non-matching trans object. "
                "Try calling uvmc_enable_trans_mm(). "
                "[line #%d of '%s']\n", "producer::nb_transport_bw()",
                __LINE__, __FILE__ );

        for( unsigned long long i=0; i<gp.get_data_length(); i++ )
            actual_checksum += data[i];

        respWasReceived.notify();
        return TLM_COMPLETED;
    }
// (end inline source)

//-------------------
// Topic: 2-phase ::b_transport() loopback target callback
//
// Since the ~in~ port is declared as a ~simple_target_socket~ to serve the
// 2-phase loopback coming from the SV side we must provide a ~b_transport()~
// callback for this purpose. In this case nothing is done to transform the
// data. But the delay specified by the ~sc_time~ argument is used to advance
// time and is then reset to 0 before returning.
//-----------------------------------------------------------------------------

// (begin inline source)
    virtual void b_transport(tlm_generic_payload &gp, sc_time &t) {
        char unsigned *data = gp.get_data_ptr();

//      for( unsigned long long i=0; i<gp.get_data_length(); i++ )
//          actual_checksum += data[i];

        wait(t);
        t = SC_ZERO_TIME;
        gp.set_response_status( tlm::TLM_OK_RESPONSE );
    }
};
// (end inline source)

#endif // PRODUCER_LOOPBACK_H
