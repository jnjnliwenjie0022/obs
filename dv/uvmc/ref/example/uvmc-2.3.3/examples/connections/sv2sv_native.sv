//
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
// Title: UVMC Connection Example - Native SV to SV
//
// This example reviews how to make a local, native TLM connections between two
// UVM components in pure SystemVerilog testbench. UVMC is not used. The
// <UVMC Connection Example - UVMC-based SV to SV> uses UVMC to make
// the same local SV connection.
//
// (see UVMC_Connections_SV2SV-native.png)
//
// The ~sv_main~ top-level module below creates and starts the SV portion of this
// example. It does the following:
//
// - Creates an instance of a ~producer~ component
//
// - Connects the producer's ~out~ port to the consumer's ~in~ port using
//   the native UVM TLM connection. 
//
// - Calls ~run_test~ to start UVM simulation
//
// TLM connections are normally made in the ~connect_phase~ callback of
// a UVM component. This example does not show that for sake of highlighting
// the connect functionality.
//
//-----------------------------------------------------------------------------

// (begin inline source)
import uvm_pkg::*; 

`include "producer.sv"
`include "consumer.sv"

module sv_main;

  producer prod = new("prod");
  consumer cons = new("cons");

  initial begin
    prod.out.connect(cons.in);
    run_test();
  end

endmodule
// (end inline source)
