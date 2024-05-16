//============================================================================
// @(#) $Id: loopback.h 1972 2021-05-20 10:17:03Z markma $
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

#ifndef LOOPBACK_H
#define LOOPBACK_H

#include <string>
#include <iomanip>

#include <systemc.h>
#include <tlm.h>

#include "simple_initiator_socket.h"
using tlm_utils::simple_initiator_socket;

#include "simple_target_socket.h"
using tlm_utils::simple_target_socket;

#include "uvmc.h"

//________________                                              ______________
// class loopback \____________________________________________/ johnS 7-15-23
//----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Title: Description of SC loopback module
//-----------------------------------------------------------------------------
//
// This module implements the ~SC loopback~ side of the diagram you saw in
// ~producer_loopback.svh~.
//
// Its job is to play a 4-phase protocol on its ~in~ target socket and to play
// a 2-phase protocol on its ~out~ initiator socket as described in
// ~producer_loopback.svh~.
//
// The ~in~ socket exports the ~simple_target_socket~ interface implemented by
// this loopback.
//
// The ~out~ socket exports the ~simple_initiator_socket~ interface
// used by this loopback.
//
// The ~handleRequestsThread()~ method is the workhorse SC_THREAD that handles
// the incoming requests.
//
// The ~nb_transport_fw()~ callback works in 3 ways.
//
// - 1st 32 transactions will clone the transaction without relying on memory
//   management in the UVM-Connect'ion to do this automatically.
// - 2nd 32 transactions will also clone the transaction without relying on
//   memory management in the UVM-Connect'ion to do this but here the memory
//   management capability is enabled. This means user will get warnings
//   because allocated transactions in the infrastructure will not match
//   transactions sent by this module in the RESP phases (calls to
//   ~nb_transport_bw()~). This will also result in memory leaks.
// - Remaining 64 transactions will reflect TLM GP received in REQ phase
//   (i.e. this call to ~nb_transport_fw()~) back to the RESP phase without
//   cloning. This will remove the warnings and result in no further leaks
//   since the infrastructure will know to free these transactions and also
//   how to preserve them so that back on the SV side the same transaction ~t~
//   will be seen on the RESP phases as were sent on the REQ phases.
//
// When leak stats are printed at the end you should only see leaks for
// the 2nd set of 32 transactions.
//-----------------------------------------------------------------------------

// (begin inline source)
class loopback : public sc_module {
    SC_HAS_PROCESS(loopback);

  private:
    tlm_fifo<tlm_generic_payload *> dRequestQueue;

    uvmc_tlm_gp_mm dTlmGpMemoryManager;

  public:
    simple_target_socket<loopback> in; // defaults to tlm_gp
    simple_initiator_socket<loopback> out; // uses tlm_gp

    loopback( sc_module_name nm )
      : dRequestQueue(-1),
        dTlmGpMemoryManager("loopback::dTlmGpMemoryManager"),
        in("in"), out("out")
    {
        SC_THREAD( handleRequestsThread );
        in.register_nb_transport_fw( this, &loopback::nb_transport_fw );
    }
    ~loopback(){
        uvmc_tlm_gp_mm_base::printAllStats();
        uvmc_trans_mm_base::printAllStats();
    }

    tlm_sync_enum nb_transport_fw(
        tlm::tlm_generic_payload &gp,
        tlm::tlm_phase &phase,
        sc_core::sc_time &trans )
    {
        tlm_sync_enum ret = TLM_UPDATED;
        static bool isTransMmEnabled = false;

        static unsigned transCount = 0;

        if( transCount >= 32 && isTransMmEnabled == false ){
            uvmc_enable_trans_mm();
            isTransMmEnabled = true;
        }
        if( transCount < 64 ){
            tlm_generic_payload *clonedTrans = dTlmGpMemoryManager.alloc();
            clonedTrans->set_mm( &dTlmGpMemoryManager );
            clonedTrans->acquire();

            unsigned char *data = new unsigned char [gp.get_data_length()];
            clonedTrans->set_data_ptr( data );

            // TLM GP's ::deep_copy_from() is pretty smart - it copies the
            // config extensions as well as the TLM GP members. What it does
            // not do however is allocate payloads and byte enables. It assumes
            // those are there with sufficient space.
            clonedTrans->deep_copy_from( gp );

            // Innocent until proven guilty.
            gp.set_response_status( TLM_OK_RESPONSE );
            phase = END_REQ;

            dRequestQueue.nb_put( clonedTrans );
        }
        else {
            // Innocent until proven guilty.
            gp.set_response_status( TLM_OK_RESPONSE );
            phase = END_REQ;

            dRequestQueue.nb_put( &gp );
        }
        transCount++;
        return ret;
    }

  private:

    void handleRequestsThread() {
        tlm_generic_payload *trans;
        sc_time delay = SC_ZERO_TIME;
        tlm_sync_enum ret;
        tlm_phase phase = BEGIN_RESP;

        while( 1 ) {
            trans = dRequestQueue.get();

            // Simply relay to b_transport() ...
            out->b_transport( *trans, delay );

            // Throw in some time advance ...
            wait( 10, SC_NS );

            // Handle RESP phases by calling nb_transport_bw() ...
            ret = in->nb_transport_bw( *trans, phase, delay );
            if( ret != TLM_COMPLETED || phase != END_RESP
                    || trans->get_response_status() != TLM_OK_RESPONSE ){
                fprintf( stdout,
                    "ERROR: %s  Unexpected "
                    "response from call to in->nb_transport_bw() "
                    "[line #%d of '%s']\n",
                    "loopback::handleRequestsThread()", __LINE__, __FILE__ );
                fflush( stdout );
            }
            if( trans->has_mm() )
                trans->release(); // Release back to heap.
        }
    }
};
// (end inline source)

#endif
