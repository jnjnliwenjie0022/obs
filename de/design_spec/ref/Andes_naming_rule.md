# Case

- ALL Upper cases for
    - `define` macros
    - `parameter`
    - `localparam`
- All Lower cases for
    - Module names
    - Port names
    - Signal names
    - Function names

# IP Configuration

- Verilog `parameter` for configurable features
    - e.g. `XLEN`, `CACHE_SIZE`
- Verilog `define` Macros:
    - only for verification or internal purposes (e.g. debug or experiment)
    - common constant among multiple designs `nds_ahb_define.inc`

# Common Abbreviations

- `uop` or `mop`: micro-op
- `ctl`, `ctrl`: control
- `reg`: register
- `in` : input to flop
- `brn`: branch
- `nx` or `nxt`: next
- Numbering
    - `ptr`: pointer
    - `idx`: index
    - `id`: identification
    - `elm`: element
    - `num`: number
    - `cnt`: counter
- Operation
    - `addr`: address
    - `rd`: read
    - `wr`: write
    - `load` /`ld`: load, `lb`/`lh`/`lw`/`ldw`???
    - `store`/`st`: store, `sb`/`sh`/`sw`/`sd`
- Handshake
    - `sel`: select
    - `vld`: valid
    - `rdy`: ready
    - `req`: request
    - `ack`: acknowledge
- Unit
    - `nibble`: nibble
    - `byte`: byte
    - `hw`: half-word (hardware???)
    - `wd`: word
    - `dw`: double-word
- Arith
    - `cin` : carry-in
    - `cout`: carry-out
    - `sum`: sum
    - `cmp`: compare
    - `sat`: saturation
    - `avg`: average
    - `sqr`: square-root
    - `eq` : equal
    - `ne` : not-equal
    - `inc`: increment
    - `dec`: decrement
    - `plus1`/`p1`: plus 1

# Pipeline Abbreviations

## Pipeline, the pipe information is used as a _prefix_

- `ii_`
- `wb_`
- `ii_`, `ex_`, `mm_`, `wb_` and etc.

## Inter-module and Intra-module I/F

- Inter-module signals: `source_destination_[channel]_[stage]_signal...`
    - E.g. Inter-functional-unit (or Inter-module) interface signals `lsu_vpu_wb_rdata` and `vpu_ipipe_exception`
- Intra-module signals: `[stage]_signal...`
    - The signal name inside module could be shorten and reassigned by removing prefix

```verilog
// source_destination_stage_function
input [31:0]    lsu_vpu_wb_rdata;     // signal with stage
output          vpu_ipipe_exception;  // signal without stage

// reassign for module internal usage
wire [31:0]      wb_rdata = lsu_vpu_wb_rdata;
```

## Phase as Pipe Stage

- `ap`: address phase
- `dp`: data phase
- `rp`: response phase

## Hand Shacking

memory-liked device

- `_cs`: chip select
- `_csn` (`_csb`): chip select active-low.
- `_web`: write enable bar
- `_wen`: write enable
- `_ren`: read enable
- `_bwe`: byte write enable

Clock/Reset:

- `_clk`:
- `_rst`:
- `_rstn`:
- `g_xxx_clk`: gated clock
- `g_xxx_clk_en`: enable signal for clock gating

## Bus/Arbiter

Arbiter like

- `_req`: request
- `_ack`: acknowledge
- `_gnt`: grant
- `_vld` or `_valid`
- `_rdy` or `_ready`
    - `_took` or `_issued` to represent `_valid & _ready`

## Logic Signal

Sequence

- `_a1`: ahead 1T
- `_d1`: delay 1T

For FSM state:

- `_cs`: current state for FSM
- `_ns`: next state for FSM

For normal signal:

- `_nx`, `_next`: next data to DFF
    - `standby_state_next` (`standby_state`)
- `_intf`: interface
    - NOTE: `_if` is too short and may cause confusion in some case, e.g. "if" sometimes means "Instruction Fetch"
- `_ctl`, `_cntl` or `_ctrl`: control
    - E.g. `seq_cntl.v`
- `_sel`: select

## Array/FIFO/Counter

- `_idx`, `_index` : index
- `_wptr`, `wr_ptr` : write pointer
- `_rprt`, `rd_pdr` : read pointer
- `_cnt`, `_counter`: for counter
- `_full`: full flag
- `_empty`: empty flag

## Clock Gating

macro defined `NDS_GATED_CLOCK`