//============================================================================
// @(#) $Id: sv2sc2sv_xl_gp_converter_loopback.sv 1972 2021-05-20 10:17:03Z markma $
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

//-----------------------------------------------------------------------------
// Title: UVMC Connection Example - UVMC-based SV to SC to SV
//-----------------------------------------------------------------------------

import uvm_pkg::*; 
import uvmc_pkg::*;

`include "producer_loopback.svh"

module sv_main;

  producer prod = new("prod");

  initial begin

    uvmc_tlm #(uvm_tlm_generic_payload,
        uvm_tlm_phase_e, uvmc_xl_tlm_gp_converter) ::connect(prod.out, "42");
    uvmc_tlm #(uvm_tlm_generic_payload,
        uvm_tlm_phase_e, uvmc_xl_tlm_gp_converter) ::connect(
            prod.out_config, "out_config");

    uvmc_tlm #(uvm_tlm_generic_payload,
        uvm_tlm_phase_e, uvmc_xl_tlm_gp_converter) ::connect(prod.in,  "43");
    uvmc_tlm #(uvm_tlm_generic_payload,
        uvm_tlm_phase_e, uvmc_xl_tlm_gp_converter) ::connect(
            prod.in_config, "in_config");

    run_test();
  end

endmodule
