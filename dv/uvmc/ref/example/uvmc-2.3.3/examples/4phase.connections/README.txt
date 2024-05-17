
--------------------------------------------------------------------------------
Title: 4-phase connections
--------------------------------------------------------------------------------

Topic: Introduction
-------------------

The uvmc-2.3.3 release adds better support for the semantics of the TLM-2.0
base protocol and how it is used in the context of 4-phase transactions.

These changes entail two types of improvements,

- More efficient memory management for allocation and freeing of TLM generic
  payload transactions and ~uvmc_xl_config~ objects

- Preservation of transaction references across all 4 phases (BEGIN_REQ,
  END_REQ, BEGIN_RESP, END_RESP) of the TLM-2.0 base protocol

Normally in any _intra_-language communication between TLM-2.0 for either
SV <-> SV or SC <-> SC connections transaction preservation is implied to be
naturally supported in accordance with the requirements of the TLM-2.0 LRM.

The idea is that ~pointers~ or ~refs~ to transactions are passed through the
connectivity rather than the entire contents of the transactions. For obvious
reasons this results in the most optimal performance since no memory-to-memory
data copy operations are required across calls to the transport functions.

However, when it comes to language boundary crossings, preserving this semantic
brings complications. Because data representations of TLM GP transactions,
associated config objects, and other transaction types are different in the
2 languages (SC and SV) it is not simply a matter of passing a reference to
an object across the connectivity.

Rather when one of these transaction objects crosses from SV -> SC or SC -> SV
a ~proxy representation~ of the transaction has to be created ~on-the-fly~
after the language crossing so it can be properly represented in the language
of the target port of the connection.

What this means is that during the RESP phases of the transaction (BEGIN_RESP,
END_RESP) that are handled by the ~nb_transport_bw()~ function it is difficult
to preserve the original reference to the transaction passed during the REQ
phases (BEGIN_REQ, END_REQ) that are handled by the ~nb_transport_fw()~
function.

To support this semantic special ~transaction preservation~ table maps were
added where the memory references are cached using special keys derived from
the pointer to the original transaction.

This has implications for memory management. If the target of the connection is
not disciplined enough to pass the same transaction reference received in its
~nb_transport_fw()~ function during the REQ phases back to the
~nb_transport_bw()~ function during the RESP phases, memory leaks will result.

Given that legacy UVMC usage does not support transaction preservation, this
feature is only enabled if the application code enables the new memory
management feature.

In legacy UVMC usage transaction preservation is not supported and memory
management is not used. The advantage of this is that there are no memory
leaks and performance is good. Basically single allocated transaction objects
(per connection) are simply reused between REQ and RESP phases and even
across multiple transactions.

While this tends to be more performant for basic 4-phase usage it arguably
suffers from two violations of the TLM-2.0 standard,

- It does not support ~out-of-order~ transaction RESP's to associated REQ's.
- It does not preserve TLM GP references between the RESP and REQ phases.

With the newer modifications the default mode of operation is the legacy
operation defined above. But if it is desired to add the new memory management
and transaction preservation support a simple function call can be made at
initialization time to enable this feature.

This allows for the best of both worlds,

- Backward compatiblity with legacy operation
- Full conformance to the LRM for transaction preservation and out-of-order
  RESP support if that is desired

However, there is a new risk now of memory leaks in the case where the target
does not have the discipline to mirror the incoming transaction reference
(pointer) passed in the ~nb_transaport_fw()~ REQ phases back to the
~nb_transport_bw()~ RESP phases. Fortunately the infrastructure itself will
detect this violation and flag a warning in this case.

So to summarize, if the application enables transaction object memory
management and there is an "undisciplined" target, user will see warnings
about memory leaks.

Topic: Enabling memory management and transaction preservation
---------------------------------

Memory management can be enabled from the SystemC side by calling the function,

|  uvmc_enable_trans_mm();

at initialization time.

You will see that the ~4phase.connections/~ examples below use this function
to enable memory management and thus, by implication, to enable the
transaction preservation feature.

--------------------------------------------------------------------------------
Group: 4-phase connection examples

In a 4-phase operation during which the RESP phases are deployed by the
target's call to ~nb_transport_bw()~ then it is assumed that the passed in
transaction reference will be one matched in the ~nb_transport_fw()~ call.

However, it will only do this if there is a match in the transaction
preservation table to the original transaction passed in via the REQ phases.

If there is a match, the UVMC infrastructure on the SV or SC initiator side
will guarantee that the same transaction that was passed into
~nb_transport_fw()~ during the REQ phases will be reflected back to that
initiator's ~nb_transport_bw()~ callback during the RESP phases. Thus the
original TLM GP reference will be preserved through all 4 phases of the
TLM-2.0 base protocol.

However, WORD OF CAUTION: if the target does not pass the same TLM GP ref to
~nb_transport_bw()~ as was received via ~nb_transport_fw()~ a memory leak will
result. This is because there is otherwise no way to know when it is safe to
return that TLM GP back to the heap.

Fortunately there is a sanity check that is called when -DDEBUG is enabled that
captures heap statistics from the ~uvmc_trans_mm<T>~ memory heap manager on all
alloc and free operations. At the end of the simulation function calls can be
made to print all heap statistics. These statistics will clearly indicate if
any memory leakage has occurred. These calls exist for both ~uvmc_tlm_gp_mm~
and ~uvmc_trans_mm~ heap managers,

| uvmc_tlm_gp_mm_base::printAllStats();
| uvmc_trans_mm_base::printAllStats();

There is also a warning that the infrastructure will automatically put out for
any unmatched transactions if they are detected in the RESP phase as well.

All the 4-phase examples are ~initator -> target~, then loopback of
~initiator -> target~ in the other direction.

So for example,

- SV initator -> SC target -> loopback -> SC initator -> SV target
- SC initator -> SV target -> loopback -> SV initator -> SC target

So the naming of that above would be, respectively,

- sv2sc2sv_loopback # See <SC -> SV -> SC 4-phase loopback example>
- sc2sv2sc_loopback # See <SV -> SC -> SV 4-phase loopback example>

There are additional variations that use optimized TLM GP transaction types
as well,

- sc2sv2sc_gp_converter_loopback
- sv2sc2sv_gp_converter_loopback
- sc2sv2sc_xl_gp_converter_loopback
- sv2sc2sv_xl_gp_converter_loopback

In each case the first ~initator -> target~ is 4-phase and demonstrates the
4-phase operation described above with transaction preservation and memory
management.

And the ~initator -> target~ in the other direction is just 2-phase
~b_transport()~.

In some of the examples the memory management and transaction preservation
support is turned on mid-simulation. So they start out as legacy operation then
switch to the new mode. They also send some of the transactions as
intentionally non-matching (i.e. undisciplined target) to trigger the
resulting warnings that the UVMC infrastructure puts out when this happens.

Best thing to do is examine the source code for the examples and run them to
get a feel for how this happens. Subsequent sections of this doc also explain
more details about how the specific loopback examples work.

--------------------------------------------------------------------------------
Topic: Running the examples

For examples that demonstrate the 4-phase operation see,

|   examples/4phase.connections/Makefile

This directory contains several examples of TLM-2 UVM-Connect'ions that pass
TLM-2 generic payloads (TLM GPs) between SystemC (SC) and SystemVerilog (SV)
andenable the transction preservation feature.

Use ~make help~ to view the menu of available tests,

| make help

To run just one test such as ~sc2sv2sc_loopback~,

| make sc2sv2sc_loopback

This compiles then runs the ~sc2sv2sc_loopback~ test.

To run all tests, check them, and clean up afterwards, i.e. ~sim:~,
~check:~, and ~clean:~ targets, use the ~all:~ target as follows,

| make all

Or you can run individual sub-targets.

The ~sim~ target compiles and runs all the tests.

| make sim

The ~check~ target checks results of all the tests.

| make check

The ~clean~ target deletes all the simulation files produced from
previous runs.

| make clean

You can combine targets in one command line

| make sim check
