//============================================================================
// @(#) $Id: producer_loopback.svh 1972 2021-05-20 10:17:03Z markma $
//============================================================================

//-----------------------------------------------------------//
//   Copyright 2021 Siemens EDA                              //
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

import uvm_pkg::*; 
`include "uvm_macros.svh"

`ifndef NUM_TRANSACTIONS
`define NUM_TRANSACTIONS 81920
`endif

`ifndef PAYLOAD_NUM_BYTES
`define PAYLOAD_NUM_BYTES 2048
`endif

//________________                                              ______________
// class producer \____________________________________________/ johnS 7-15-23
//----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Title: SV -> SC -> SV 4-phase loopback example
//
//-------------------
// Topic: Description of SV producer module
//
// This is a generic ~producer~ module that creates ~tlm_generic_payload~
// transactions and sends them out its ~out~ initiator socket in th SV -> SC
// direction. It then receives looped back transactions via its ~in~ target
// socket in the SC -> SV direction.
//
// The SV -> SC direction uses 4-phase semantics as described in the TLM-2.0
// base protocol, namely BEGIN_REQ, END_REQ, BEGIN_RESP, END_RESP. As such it
// is implemented with a ~callin~ to ~nb_transport_fw()~ via its SV initiator
// port feeding the SC target port for the REQ phases, followed by a ~callback~
// to ~nb_transport_bw()~ on the same initiator port for the RESP phases.
//
// In between the REQ and RESP phases described above, for the SC -> SV
// direction the SV initiator port simply uses 2-phase ~b_transport()~
// operation to loop back the transaction.
//
// The original SV -> SC direction RESP phases are only completed after the
// SC -> SV loopback ~b_transport()~ operation completes.
//
// This operation is depicted here,
//
// |   i == initiator('out')                          -> 'callin'
// |   t == target('in')                              :: 'callback'
// |
// |                    SV          language           SC
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
// ~nb_transport_bw()~ callback it is expected that the transaction ref ~t~ is
// the same as that originally passed via the initiator's call to
// ~nb_transport_bw()~. Thus the ~t~ ref is ~preserved~. If the ~loopback~
// module does not follow this rule a WARNING will result as well as potential
// memory leak.
//-----------------------------------------------------------------------------

// (begin inline source)
class producer extends uvm_component;

   uvm_tlm_nb_initiator_socket #(producer) out;
   uvm_tlm_b_target_socket #(producer) in;

   `uvm_component_utils(producer)

   local int unsigned expected_checksum, actual_checksum;
   event resp_was_received;
   
   function new(string name, uvm_component parent=null);
      super.new(name,parent);
      in = new("in", this);
      out = new("out", this);
   endfunction
// (end inline source)

//-------------------
// Topic: How the test works
//
// The above operation is implemented in the ~producer~ module's ~run_phase()~
// method which is set up as an SV UVM phase callback thread.
//
// Notice that the ~producer~ must also furnish the ~nb_transport_bw()~
// callback function for its ~out~ initiator port.
//
// The main ~run_phase()~ test thread function in this case will simply send
// 128 consecutive transactions using 4-phase protocol. This means that each
// REQ phase is initiated by calling the ~nb_transport_fw()~ callin on the
// initiator port.
//
// This is followed by confirmation that the ~nb_transport_bw()~ callback on
// the initiator port has received the same transaction before sending the
// next one.
//
// Meanwhile this producer must also furnish a ~b_transport()~ callback on
// its target socket so that when the ~loopback~ module on the SC side loops
// back back the transaction it will be handled here.
//
// See comments in the SC ~loopback.h~ module for how memory management and
// transaction preservation are enabled and how this modules tests for
// violations of transaction ref passing on the loopback side between the REQ
// and RESP phases.

// (begin inline source)
   task run_phase (uvm_phase phase);

      // Allocate GP once
      uvm_tlm_gp gp = new;
      uvm_tlm_time delay = new("del",1e-9);
      int num_trans = `NUM_TRANSACTIONS;
      uvm_tlm_phase_e nbt_phase;
      uvm_tlm_sync_e result;

      longint unsigned address = 64'h40000000;

      longint unsigned i, j, offset = 0;

      byte unsigned data[];

      // Keep the "run" phase from ending
      phase.raise_objection(this);

      // Get number of transactions desired (default=2)
      uvm_config_db #(uvm_bitstream_t)::get(this,"","num_trans",num_trans);

      expected_checksum = 0;
      actual_checksum = 0;

      gp.set_command( UVM_TLM_WRITE_COMMAND );
      gp.set_data_length( `PAYLOAD_NUM_BYTES );

      data = new[`PAYLOAD_NUM_BYTES];

      `uvm_info( "producer::run_phase()",
        $psprintf( "[PRODUCER/GP/SEND] NUM_TRANSACTIONS=%0d PAYLOAD_NUM_BYTES=%0d ...", `NUM_TRANSACTIONS, `PAYLOAD_NUM_BYTES ), UVM_MEDIUM );

      for( i=0; i < num_trans; i++ ) begin
        gp.set_address( address );
        gp.set_response_status( UVM_TLM_INCOMPLETE_RESPONSE );

        for( j=0; j < `PAYLOAD_NUM_BYTES; j++) begin
          data[j] = (j+offset) & 8'hff;
          expected_checksum += data[j];
        end
        gp.set_data( data );

        delay.set_abstime(10,1e-9);

        nbt_phase = BEGIN_REQ;

        result = out.nb_transport_fw( gp, nbt_phase, delay );
        if( result != UVM_TLM_UPDATED || nbt_phase != END_REQ
                || gp.get_response_status() != UVM_TLM_OK_RESPONSE )
            `uvm_error( "producer::run_phase()",
                "Unexpected response from call to out.nb_transport_fw()" );

        @(resp_was_received);

        address += `PAYLOAD_NUM_BYTES;
        offset++;
      end

      if( actual_checksum > 0 && actual_checksum == expected_checksum ) begin
        `uvm_info( "producer::run_phase()", $psprintf(
          "... done producing transactions, expected_checksum=%0x == actual_checksum=%0x Test PASSED !",
          expected_checksum, actual_checksum ), UVM_MEDIUM );
      end
      else begin
        `uvm_error( "producer::run_phase()", $psprintf(
          "... done producing transactions, expected_checksum=%0x != actual_checksum=%0x Test FAILED !",
          expected_checksum, actual_checksum ) );
      end

      `uvm_info("PRODUCER/END_TEST",
                "Dropping objection to ending the test",UVM_LOW)
      phase.drop_objection(this);
   endtask

   //------------------------------------
   // This one is needed for the 'out' uvm_tlm_nb_initiator_socket channel
   virtual function uvm_tlm_sync_e nb_transport_bw(
        uvm_tlm_gp trans, ref uvm_tlm_phase_e phase, input uvm_tlm_time delay );

      phase = END_RESP;
      trans.set_response_status( UVM_TLM_OK_RESPONSE );

      for( int unsigned i=0; i < trans.get_data_length(); i++ )
         actual_checksum += trans.m_data[i];

      ->resp_was_received;

      return UVM_TLM_COMPLETED;
   endfunction
// (end inline source)

//-------------------
// Topic: 2-phase ::b_transport() loopback target callback
//
// Since the ~in~ port is declared as a ~uvm_tlm_b_target_socket~ to serve the
// 2-phase loopback coming from the SC side we must provide a ~b_transport()~
// callback for this purpose. In this case nothing is done to transform the
// data. But the delay specified by the ~uvm_tlm_time~ argument is used to
// advance time and is then reset to 0 before returning.
//-----------------------------------------------------------------------------
// (begin inline source)
   virtual task b_transport( uvm_tlm_gp t, uvm_tlm_time delay );

//    for( int unsigned i=0; i < t.get_data_length(); i++ )
//       actual_checksum += t.m_data[i];

      #(delay.get_abstime(1e-9));
      delay.reset();
      t.set_response_status( UVM_TLM_OK_RESPONSE );
   endtask
// (end inline source)
endclass
