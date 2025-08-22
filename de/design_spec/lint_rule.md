
| Rule                    | Description                                                                                                                                     |     |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| W240                    | Input ports that are never read                                                                                                                 | V   |
| W528                    | A signal or variable is set but never read                                                                                                      | V   |
| W226                    | Case select expression is constant                                                                                                              | V   |
| W362                    | Reports an arithmetic comparison operator with unequal length                                                                                   | V   |
| W164b                   | Identifies assignments in which the LHS width is greater than the RHS width                                                                     | V   |
| W336                    | Blocking assignment should not be used in a sequential block (may lead to shoot through)                                                        | C   |
| W164a                   | Identifies assignments in which the LHS width is less than the RHS width                                                                        |     |
| W215                    | Reports inappropriate bit-selects of integer or time variables                                                                                  |     |
| W216                    | Reports inappropriate range select for integer or time variable                                                                                 |     |
| W415a                   | Signal may be multiply assigned (beside initialization) in the same scope                                                                       |     |
| W287a                   | Some inputs to instance are not driven or unconnected                                                                                           |     |
| W287b                   | Output port to an instance is not connected                                                                                                     |     |
| W123                    | Identifies the signals and variables that are read but not set                                                                                  |     |
| WRN_69                  | If a timescale directive is specified, it should be available to all the modules in the design.                                                 |     |
| UndrivenInTerm-ML       | Detects undriven but loaded input terminal of an instance                                                                                       |     |
| CMD_define02            | Macro specification \'\<define\>+\<macro-name\>\' not used in current run                                                                       | C   |
| checkCMD_unused_param01 | Parameter '\<parameter\>' has been ignored as none of the dependent rules are enabled                                                           | C   |
| SGDC_waive27            | Regular expression '\<expression\>' specified in '\<field\>' field either did not match any source file names or matches precompiled file names | C   |
| DisallowCaseZ-ML        | Do not use casez constructs in the design                                                                                                       |     |
| InferLatch              | Latch inferred                                                                                                                                  | C   |
| CheckDelayTimescale-ML  | Delay used without timescale compiler directive                                                                                                 | C   |
| ErrorAnalyzeBBox        | Reports black boxes in the design with Error severity.                                                                                          | V   |
| ELAB_3518               | Double type values are used for overriding a parameter or port in instance, which may not be supported by some other tools                      | V   |
| FlopEConst              | Reports permanently disabled or enabled flip-flop enable pins                                                                                   | V   |
| NoAssignX-ML            | Ensure RHS of the assignment does not contains 'X'                                                                                              | V   |
| SignedUnsignedExpr-ML   | Do not mix signed & unsigned variables/constants in expressions                                                                                 | V   |
| STARC-1.3.1.2           | Do not use synchronous reset in the design                                                                                                      | C   |
| STARC05-1.1.4.8         | Parameters with numeric value more than nine must have base type specification.                                                                 | V   |
| STARC05-1.2.1.1a        | Design should use only one edge of a clock                                                                                                      | V   |
| STARC05-2.10.3.1        | Bit-widths of operands of a relational operator should match                                                                                    | V   |
| STARC05-3.2.3.1         | Port connections in instantiations must be made by named association rather than positional association.                                        |     |
| VarName                 | Variable does not follow recommended naming convention                                                                                          |     |
| ReEntrantOutput-ML      | The re-entrant outputs should be avoided                                                                                                        | V   |
| FLAT_504                | Macro logic evaluation done partially as its size crosses the threshold limit                                                                   |     |
| SYNTH_5281              | Width greater than '4000000' is not supported for declaration.                                                                                  |     |
| SYNTH_5273              | Number of bits for net/variable exceeds the mthresh value                                                                                       |     |



- constant 一定要宣告 bit width
- module input/output 不能 floating，且一定要有 wire 宣告，即便是常數，或是 floating
	- 如果 output 的行爲真的是 floating，則用 unused_wire_xxx 去對接，並在 waive rule 去 waive unused_wire_xxx
	- ![[Pasted image 20250821132202.png]]

![[Pasted image 20250804133458.png]]
![[Pasted image 20250822152347.png]]