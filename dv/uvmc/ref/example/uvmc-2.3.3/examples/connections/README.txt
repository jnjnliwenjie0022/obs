
--------------------------------------------------------------------------------
Title: UVMC Connections
--------------------------------------------------------------------------------

This chapter shows how to make TLM connections between SystemC and
SystemVerilog UVM components. 

--------------------------------------------------------------------------------

Group: Overview

--------------------------------------------------------------------------------

To communicate, verification components must agree on the data they are
exchanging and the interface used to exchange that data. This chapter covers
how to make connections between components using standard TLM interfaces.

This chapter focuses on connections. The code to make the connections look the
same regardless of the types of the TLM interfaces being connected. We do not
need to show the actual types of the ports, exports, or sockets used by the
models we are connecting. The only requirement is that the port types be
compatible. If they are not, the C++ or SystemVerilog compiler or elaborator
will let us know.

All the examples in this section use the TLM2 generic transaction type,
~tlm_generic_payload~ (TLM GP), for which transaction type and converters are
pre-defined for you. Greater reuse and interoperability is possible for
models that use the TLM GP and follow the TLM base protocol, both of which
are defined in IEEE 1666-2011.


--------------------------------------------------------------------------------

Group: The Connect Function

--------------------------------------------------------------------------------

The ~connect~ and ~connect_hier~ functions are used to register any type
of TLM port, export, interface, imp, or socket for connection across the
language boundary.


Topic: Syntax
-------------

The calling syntax for the ~connect~ function.

SV:

|TLM2 
| uvmc_tlm #(T, CVRT)::connect (port, lookup);
| uvmc_tlm #(T, CVRT)::connect_hier (port, lookup);
|
|TLM1:
| uvmc_tlm1 #(T, CVRT)::connect (port, lookup);
| uvmc_tlm1 #(REQ,RSP,CVRT_REQ,CVRT_RSP)::connect (port,lookup);
|
| uvmc_tlm1 #(T, CVRT)::connect_hier (port, lookup); TLM1 uni
| uvmc_tlm1 #(REQ,RSP,CVRT_REQ,CVRT_RSP)::connect_hier (port,lookup);

SC:

|TLM1 & TLM2:
| uvmc_connect (port, lookup);
| uvmc_connect <CVRT> (port, lookup);
|
| uvmc_connect_hier (port, lookup);
| uvmc_connect_hier <CVRT> (port, lookup);



Topic: Parameters
-----------------

A description of the type parameters to ~connect~.

The ~connect~ function is a static function accessed via a class with type
parameters for ~T~, the transaction type, and optional ~CVRT~, a
custom converter type. References to ~port~ in the following descriptions
refer to all port types, i.e. ports, exports, sockets, etc., unless
otherwise noted.

T         - Specifies the transaction type for all TLM2 ports and
            unidirectional TLM1 ports. Required parameter for SV connections.

REQ, RSP  - Specifies the request and response transaction types for
            bidirectional TLM1 ports. The default RSP type is the REQ type,
            so RSP must be specified only if different than REQ.
            Required parameter for SV connections.

CVRT, CVRT_REQ, CVRT_RSP - The converter policy class to use for this
            connection (optional). In SV, you do not need to specify a
            converter for transaction types that extend ~uvm_object~ and
            implement the ~do_pack~ and ~do_unpack~ methods (or use the
            ~`uvm_field~ macros). In SC, you do not need to specify a
            converter for transaction types that implement ~do_pack~ and
            ~do_unpack~ or for which you have defined a template
            specialization of ~uvmc_converter<T>~. 
            See <Converters> for how to define and use 
            converter classes. Default: ~uvmc_converter #(X)~,
            with X = [T, REQ, or RSP]

On the SC-side, you do not typically need to specify any type parameters.
The transaction type is deduced by the C++ compiler based on
the port provided, and converters are almost always a specialization of
the default converter. The compiler choses any specialization over the
default implementation automatically.


Topic: Arguments
----------------

A description of the arguments to ~connect~.

port   - The port, export, imp, interface, or socket instance to be connected.
         The port's hierarchical name will be registered as a lookup string
         for matching against other port registrations within both SV and SC.
         A string match between two registered ports results in those ports
         being connected.

lookup - An optional, additional lookup string to register for this port.
         Every UVMC connection must involve at least one usage of this optional
         string, as all ports have unique hierarchical names. Default: ""


Port Argument:

The connect function's ~port~ argument is a handle to a TLM1 or TLM2
port, export, interface, imp, or socket. During elaboration, the matched
port must agree on interface (e.g. put, get, peek), direction (e.g. port or
export/imp), and transaction type, else the connection will fail.

For example, consider the following SV port

| uvm_tlm_blocking_put_port #(trans)

This port can be connected via ~connect~ to instances of the following
SC port types, assuming the appropriate converters exist.

|   tlm_blocking_put_if<trans>
|   sc_export< tlm_blocking_put_if<trans> >
|
|   tlm_put_if<trans>
|   sc_export< tlm_put_if<trans> >

The same SV port can be connected to the following SC port instances
using the ~connect_hier~ function.

| sc_port< tlm_blocking_put_if<trans> >
| sc_port< tlm_put_if<trans> >

As you can see, the blocking put port in SV has several compatible connection
options in SC. That's because the blocking put port requires a connection
to something that provides a blocking put interface, a requirement
satisfied by all the above SC-side exports and interfaces.

- The ~tlm_blocking_put_if<trans>~ meets this requirement exactly

- The ~tlm_put_if<trans>~ interface provides an implementation of both the
  blocking put and non-blocking put interface, so it meets the blocking
  interface requirement

- Each export is ultimately connected to implementations of the 
  ~tlm_blocking_put_if~ or ~tlm_put_if~ interfaces

Derivatives of the above export and interface types are also valid
connections to our blocking put port.


Lookup Argument:

Lookup strings are global across both SC and SV. A lookup string can be
anything you wish as long as it is unique to other UVMC connections.
Just before UVM's ~end_of_elaboration~ phase, UVM Connect will establish
the actual cross-language connection.

It is recommended that you apply a naming convention that assures the lookup
strings will be unique yet do not embed hierarchical paths.


While most connections will be made by matching ~lookup~ strings, UVMC also
captures each port's hierarchical name in each connect call. This hierarchical
name can be used for matching as well.
 
Connecting by matching an SV port's hierarchical name

    | SV:
    | uvmc_tlm #()::connect(prod.out);
    |
    | SC:
    | uvmc_connect(cons.in, "prod.out");

The connect call in SV omits the 2nd argument. Therefore, UVMC only
registers the hierarchical name, ~"prod.out"~ , to represent the producer's
port. The connect call on the SC side supplies a 2nd argument. Thus, UVMC
registers the names ~"cons.in"~ and ~"prod.out"~ to represent the
consumer's export. During elaboration, UVM Connect will match the string
~"prod.out"~ and make the connection between the SV producer and the SC
consumer.

This approach is not recommended because you end up coupling your code to
component hierarchy.  If one side's hierarchy changes, your UVMC connections
will need to updated.  Using the global, arbitrary lookup string, while not
ideal, provides better protection from hierarchy changes.

If you prefer to use hierarchical names, you will have to specify at least one
hierarchical name as the lookup string.

To avoid affecting the ~connect~ code when paths or lookup strings need to
change, consider storing the paths and lookup strings in a separate
file for reading/parsing rather than hard-coding them in your code.


--------------------------------------------------------------------------------

Group: Usage

--------------------------------------------------------------------------------

The ~connect~ function registers a port for UVMC connection. During
elaboration, the port's hierarchical name and optional lookup name will be
used to match with lookup strings of other registered ports. During operation,
transactions are converted using the default converter, or using the converter
type you specified in the ~connect~ call.

Most ports require they be connected. Registering with UVMC ~connect~ satisfies
this requirement. However, any UVMC connection that does not end up with a match
will produce a fatal error.

While native connections require a single call to ~connect~ (SV) or ~bind~ (SC),
a UVMC connection requires ~two~ connect calls, one each for the initiator and
target, each of which can be in either SC or SV.


Topic: SV Connections
---------------------

For SV, the connect function is a static member function of a class that is
parameterized to the transaction type and optional converter. The transaction
type is a required parameter, whereas the converter is only required if your
transaction does not implement ~do_pack~ and ~do_unpack~ (or use the
~`uvm_field~ macros).

Point-to-point TLM2 or analysis connection:

| uvmc_tlm #(trans)::connect(port_handle, "lookup");

Hierarchical TLM2 connection:

| uvmc_tlm1 #(trans)::connect_hier(port_handle, "lookup");

Point-to-point unidirectional TLM1 connection:

| uvmc_tlm1 #(trans)::connect(port_handle, "lookup");

Point-to-point bidirectional TLM1 connection:

| uvmc_tlm1 #(request, response)::connect(port_handle, "lookup");

Hierarchical TLM1 connection:

| uvmc_tlm1 #(trans)::connect_hier(port_handle, "lookup");


Notes:

- These calls to connect do not specify a converter
  class explicitly. Therefore, the default converter will be used.
  See <Default Converters> for details.

- Connections to analysis ports and exports is made using 
  ~uvmc_tlm #(trans)::connect~, not ~uvmc_tlm1 #(trans)::connect~.

- For TLM2 connections, if the ~trans~ type is not specified, the default
  ~uvm_tlm_generic_payload~ is used.

- You must specify the ~trans~ type when making TLM1 connections, as there
  is no default transaction type for TLM1. 



Topic: SC Connections
---------------------

UVMC connections in SystemC are made by registering any TLM port, export,
interface, or socket using the ~uvmc_connect~ function. When calling this
function, you pass in a reference to the TLM instance and an optional lookup
string. During elaboration, UVMC will connect the ports whose registered
lookup strings match. An error will occur if the ports are incompatible
or a registered port has no match.

All UVMC TLM connections in SystemC are made with two kinds of connect calls.

Point-to-point connection (TLM2 and TLM1):

| uvmc_connect(port_ref, "lookup");


Hierarchical connection (TLM2 and TLM1):

| uvmc_connect_hier(port_ref, "lookup");


Notes:

- SC-side connects calls typically do not specify a converter type explicitly.
  In most cases, you will have defined a template specialization of the default
  converter, which the compiler choses automatically for you. See
  <Converters> for details on defining transaction converters.

- You are not required to specify the port, interface, or transaction types
  because the C++ compiler will infer them by the port reference you provide
  to ~uvmc_connect~. 


--------------------------------------------------------------------------------

Group: Notes 

--------------------------------------------------------------------------------

Topic: One UVMC Connection per Port
-----------------------------------

A UVMC connect call can be made only once for each port, export, imp, and socket
instance, but this restriction does not limit your connectivity options.
For example, an SV-side ~uvm_tlm_analysis_port<T>~ may drive any number of SC-side
analysis imps or exports. The ~uvmc_connect~ call on the SC side returns a
reference to the proxy port that will drive the specified SC-side analysis
export/interface. You may subsequently bind this proxy port to any number
of other SC-side exports/interfaces. 


Topic: SC connections without sc_main
-------------------------------------

All SC examples in this kit all define the standard ~sc_main~ entry point
to instantiate the SC-side testbench and start SystemC.  Your simulator
may also support exportation of SC model definitions for direct
instantiation in SystemVerilog. 

The following demonstrates how to create a UVMC connection by defining
and exporting a top-level ~sc_module~ to SystemVerilog. The SC module
must be compiled and exported to a library before attempting to compile
and link the SystemVerilog code.

SC side:

In SystemC, you define the sc_module, then invoke the ~SC_EXPORT_MODULE~
macro to export it.

| sc_top.h:
| 
| class sc_top : public sc_module
| {
|    public:
|    target trgt;
|    SC_CTOR(sc_top) : trgt("trgt")
|    {
|      uvmc_connect(trgt.target_socket,"foo");
|    }
| };
|
| sc_top.cpp:
|
| #include "sc_top.h"
| SC_MODULE_EXPORT(sc_top)


SV side:

In SystemVerilog, you define the top-level SV module to instantiate
the SC module as if it were an SV module. The location of the compiled
and exported SC module must be visible to your SV compiler.

| class sv_env extends uvm_env;
|    initiator init;
|    ...
|    function void connect_phase(uvm_phase phase);
|      uvmc_tlm#(payload)::connect(init.socket, "foo");
|    endfunction
| endclass
|
| ...
|
| module sv_top;
|   // Instantiate export SC module
|   sc_top sc_top_inst();  
|   initial begin
|      sv_env env;
|      env = new("env");
|      run_test("test");
|   end
| endmodule

The above example shows the UVMC connection being registered in the
~connect_phase~ of the ~sv_env~ class.



Topic: SystemC Starting before UVM is Ready
-------------------------------------------

SystemC may finish elaboration before SystemVerilog, in which case its models
may start to emit transactions out its UVMC ports connections before UVM is
ready to receive them. UVM Connect blocks all communication from SystemC
until UVM has reached its run_phase. This means that all TLM port
communication in SystemC must occur from an SystemC thread via
~SC_THREAD~ or ~sc_spawn~.

To allow port registration to occur up through UVM's ~connect_phase~,
UVM's ILLCRT check is disabled to allow post-build UVMC port binding.



Topic: Timescales
-----------------

UVM Connect's default time precision for conveying delay times in the
TLM2 interfaces is 1 picosecond. 

Use Questa's ~-t~ argument in vsim to force the time scale in
both SC and SV to be the same. Refer to the documentation for how to do
this in other simulators.



--------------------------------------------------------------------------------

Group: Connection Examples

--------------------------------------------------------------------------------

This section describes how to prepare and run the connection examples including
in this kit.


Topic: Setup
------------

See <Quickstart 1-2-3 to running examples> for setup requirements before
running the examples.

Specifically, you will need to have precompiled the UVM and UVMC
libraries and set environment variables pointing to them.


Topic: Running
--------------

Use ~make help~ to view the menu of available examples:

|> make help

You'll get a menu similar to the following

|  -----------------------------------------------------------------
| |                 UVMC EXAMPLES - CONNECTIONS                     |
|  -----------------------------------------------------------------
| |                                                                 |
| | Usage:                                                          |
| |                                                                 |
| |   make [UVM_HOME=path] [UVMC_HOME=path] <example>               |
| |                                                                 |
| | where <example> is one or more of:                              |
| |                                                                 |
| |   sv2sc        : SV producer --> SC consumer                    |
| |                  Connection is made via UVMC                    |
| |                                                                 |
| |   sc2sv        : SC producer --> SV consumer                    |
| |                  Connection is made via UVMC                    |
| |                                                                 |
| |   sv2sc2sv     : SV producer --> SC consumer                    |
| |                  Producer and consumer send transactions to     |
| |                  scoreboard for comparison                      |
| |                  Connections are made via UVMC                  |
| |                                                                 |
| |   sc_wraps_sv  : SC producer --> SC consumer                    |
| |                  Defines SC wrapper around SV model, uses       |
| |                  UVMC connections inside the the wrapper to     |
| |                  integrate the SV component. The wrapper        |
| |                  appears as a native SC component.              |
| |                  Consider integration of RTL models in SC.      |
| |                                                                 |
| |   sv2sv_native : SV producer --> SV consumer                    |
| |                  Connection is made via standard UVM in SV      |
| |                                                                 |
| |   sc2sc_native : SC producer --> SC consumer                    |
| |                  Connection is made via standard IEEE TLM in SC |
| |                                                                 |
| |   sv2sv_uvmc   : SV producer --> SV consumer                    |
| |                  Connection is made via UVMC. Semantically      |
| |                  equivalent to sv2sv_native                     |
| |                                                                 |
| | UVM_HOME and UVMC_HOME specify the location of the source       |
| | headers and macro definitions needed by the examples. You must  |
| | specify their locations via UVM_HOME and UVMC_HOME environment  |
| | variables or make command line options. Command line options    |
| | override any envrionment variable settings.                     |
| |                                                                 |
| | The UVM and UVMC libraries must be compiled prior to running    |
| | any example. If the libraries are not at their default location |
| | (UVMC_HOME/lib) then you must specify their location via the    |
| | UVM_LIB and/or UVMC_LIB environment variables or make command   |
| | line options. Make command line options take precedence.        |
| |                                                                 |
| | Other options:                                                  |
| |                                                                 |
| |   all   : Run all examples                                      |
| |   clean : Remove simulation files and directories               |
| |   help  : Print this help information                           |
| |                                                                 |
| |                                                                 |
|  -----------------------------------------------------------------

To run just one example

|> make sv2sc

This compiles and runs the ~sv2sc~ example, which demonstrates an SV
producer sending TLM generic payload transactions to an SC consumer
via TLM sockets.

The UVM source
location is defined by the ~UVM_HOME~ environment variable, and the
UVM and UVMC compiled libraries are searched at their default
location, ~../../lib/uvmc_lib~.

To run all examples

  |> make all

The ~clean~ target deletes all the simulation files produced from
previous runs.

  |> make clean

You can combine targets in one command line

  |> make clean sc_wraps_sv

The following runs the 'sc2sv' example, providing the path to the
UVM source and compiled library on the ~make~ command line.

  |> make UVM_HOME=<path> UVM_LIB=<path> sc2sv


| //-----------------------------------------------------------//
| //   Copyright 2021 Siemens EDA                              //
| //                                                           //
| //   Licensed under the Apache License, Version 2.0 (the     //
| //   "License"); you may not use this file except in         //
| //   compliance with the License.  You may obtain a copy of  //
| //   the License at                                          //
| //                                                           //
| //       http://www.apache.org/licenses/LICENSE-2.0          //
| //                                                           //
| //   Unless required by applicable law or agreed to in       //
| //   writing, software distributed under the License is      //
| //   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR  //
| //   CONDITIONS OF ANY KIND, either express or implied.      //
| //   See the License for the specific language governing     //
| //   permissions and limitations under the License.          //
| //-----------------------------------------------------------//
