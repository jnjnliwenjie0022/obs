//============================================================================
// @(#) $Id: loopback.svh 1972 2021-05-20 10:17:03Z markma $
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

//________________                                              ______________
// class loopback \____________________________________________/ johnS 7-15-23
//----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Title: Description of SV loopback module
//-----------------------------------------------------------------------------
//
// This module implements the ~SV loopback~ side of the diagram you saw in
// ~producer_loopback.h~.
//
// Its job is to play a 4-phase protocol on its ~in~ target socket and to play
// a 2-phase protocol on its ~out~ initiator socket as described in
// ~producer_loopback.h~.
//
// The ~in~ socket exports the ~uvm_tlm_nb_target_socket~ interface
// implemented by this loopback.
//
// The ~out~ socket exports the ~uvm_tlm_b_initiator_socket~ interface used by
// this loopback.
//
// The ~run_phase()~ method is the workhorse thread that performs the loopback
// operation itself.
//
// It waits until it is notified that it got a transaction from the
// ~nb_transport_fw()~ callback for the ~in~ target. This completes the
// REQ phase of the 4-phase protocol.
//
// It then mirrors that ~savedTrans~ transaction ref back to the initiator port
// by calling its ~b_transport()~ callin. When this function returns it finally
// sends the transaction back over the backward path of the target port by
// calling its ~nb_transport_bw()~ to complete the RESP phase.
//
// Again it is expected that the same ~savedTrans~ ref is passed via the
// backward path during this phase in order to ensure transaction preservation
// back on the producer side.
//-----------------------------------------------------------------------------

// (begin inline source)
import uvm_pkg::*; 
`include "uvm_macros.svh"

class loopback extends uvm_component;

   uvm_tlm_nb_target_socket #(loopback) in;
   uvm_tlm_b_initiator_socket #() out;

   `uvm_component_utils(loopback)

    local uvm_tlm_gp savedTrans;
    event gotTransEvent;
   
   function new(string name, uvm_component parent=null);
      super.new(name,parent);
      in = new("in",  this);
      out = new("out",  this);
   endfunction

    // task called via 'in' socket
    virtual function uvm_tlm_sync_e nb_transport_fw(
        uvm_tlm_gp trans, ref uvm_tlm_phase_e phase, input uvm_tlm_time delay );

        phase = END_REQ;
        trans.set_response_status( UVM_TLM_OK_RESPONSE );
        savedTrans = trans;
        ->gotTransEvent;

        return UVM_TLM_UPDATED;
    endfunction

    task run_phase( uvm_phase phase );
        uvm_tlm_sync_e result;
        uvm_tlm_phase_e nbt_phase = BEGIN_RESP;
        uvm_tlm_time delay = new("del",1e-9);

        forever begin
            @gotTransEvent;

            out.b_transport( savedTrans, delay );

            #10ns;

            result = in.nb_transport_bw( savedTrans, nbt_phase, delay );
            if( result != UVM_TLM_COMPLETED || nbt_phase != END_RESP
                    || savedTrans.get_response_status() != UVM_TLM_OK_RESPONSE )
                `uvm_error( "loopback::run_phase()",
                    "Unexpected response from call to out.nb_transport_bw()" );
        end
    endtask
endclass
// (end inline source)
