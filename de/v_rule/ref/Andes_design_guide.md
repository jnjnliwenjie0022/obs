# Principle

Design Quality Index:

- PPA performance
    - High Speed
- Coding
    - Readability
    - Reusability/Portability/Compatibility
    - Simplicity
    - Auxiliary (quality/coverage/lint/debug and etc.)
- one-hot design principle
- FSM principle
    - no mix of two FSM together
    - explicit listing of case statement is allowed. (with example)
    - the states within 8 is manageable. Otherwise, the code should be reviewed.
- CDC principle
    - use macro in `design_macro.mdl`

# High Speed

## Using Valid and Ready

- request/ready/grant
    - Has longer path, because grant should be qualified with request
- valid/ready
    - ready should NOT be qualified with valid
    - valid should NOT be qualified with ready

## Using Sum of Product

- Using sum of product when control signals are `one-hot`
- Changing control signals to `one-hot` and using sum of product

Original coding:

```
// infer Priority Encoder
assign ex_src1 =  ex_src1_bypass[0] ? wb_wdata :
                  ex_src1_bypass[1] ? mm_wdata :
                  ex_src1_bypass[2] ? lsu_ipipe_wb_bypass_data :
                                      ex_reg_src1;
assign fetch_pc = (retire_ptr==2’d0) ? fq0_pc :
                  (retire_ptr==2’d1) ? fq1_pc :
                                       fq2_pc ;

```

Revised coding:

```
assign ex_src1 =  ex_reg_src1
               | ({XLEN{ex_src1_bypass[0]}} & wb_wdata)
               | ({XLEN{ex_src1_bypass[1]}} & mm_wdata)
               | ({XLEN{ex_src1_bypass[2]}} & lsu_ipipe_wb_bypass_data)
               ;

assign fetch_pc = ({VALEN{retire_ptr[0]}} & fq0_pc)
                | ({VALEN{retire_ptr[1]}} & fq1_pc)
                | ({VALEN{retire_ptr[2]}} & fq2_pc)
                ;
```

## Separating Control and Data Path (For FSM/Sequential Logic/Control and Data Path)

Typically,

- **Data path has more fan-outs**
- Control signal has worse timing Synthesizer need more effort to optimize when control signal is propagated to data path.

Original coding:

```verilog
wire      mdu_req_in      = mdu_req_valid & mdu_req_ready & ~mdu_kill;
assign    mdu_req_ready   = state == IDLE;

always @(posedge core_clk) begin
        if (mdu_req_in)
                reg0 <= reg0_req_nx;
        else if (state == PRE)
                reg0 <= reg0_pre_nx;
        else if (state == EXE)
                reg0 <= reg0_exe_nx;
        else if (state == POST)
                reg0 <= reg0_post_nx;
end

```

Revised coding:

```verilog
always @(posedge core_clk) begin
        if (reg0_en)        // reg0_en is control signal
                reg0 <= reg0_nx;    // reg0_nx is data path
end

assign reg0_en = (state == PRE )
               | (state == EXE )
               | (state == POST)
               | (mdu_req_valid & mdu_req_ready)
               ;

assign reg0_nx = ({(2*XLEN+1){(state == PRE )}} & reg0_pre_nx )
               | ({(2*XLEN+1){(state == EXE )}} & reg0_exe_nx )
               | ({(2*XLEN+1){(state == POST)}} & reg0_post_nx)
               | ({(2*XLEN+1){(state == IDLE)}} & reg0_req_nx )
               ;

```

Another example

```verilog
// Control Path: rf_we is real write enable signal, but the timing is worse
// Data    Path: wb_reg_rf_we has better timing
assign rf_we = ~wb_stall & ( (wb_valid & wb_reg_rf_we & ~wb_abort) |
                             (mdu_resp_valid & mdu_write_enable) |
                              init_rf
                            );

assign rs1_rf_rdata = (wb_valid & wb_reg_rf_we && (wb_rd == ii_rs1)) ? rf_wdata : rf_rdata1;
assign rs2_rf_rdata = (wb_valid & wb_reg_rf_we && (wb_rd == ii_rs2)) ? rf_wdata : rf_rdata2;
```

# Simplicity

## Code Reduction for Different Configurations

Avoid duplicated codes of different configurations

Original coding:

```verilog
generate
if (BTB_SIZE != 0 && RVC_SUPPORT == "yes") begin : gen_branch_control_with_isa_c
        assign ex_btb_update_alloc      = (ex_btb_alloc & (!ex_pred_hit)) & ex_taken & rvc_enable;
        assign ex_btb_update_invalidate = ((!ex_btb_alloc) & ex_pred_hit) & ex_pred_taken;
        assign ex_btb_update_revise     = ex_btb_alloc & ex_pred_hit & ex_pred_taken & ex_taken & (ex_ag_result != ex_pred_npc);
        assign ex_btb_update_extend     = ex_btb_alloc &
                  (ex_ag_result[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1] != ex_pc[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1]);

end
else if (BTB_SIZE != 0 && RVC_SUPPORT == "no") begin
        assign ex_btb_update_alloc      = (ex_btb_alloc & (!ex_pred_hit)) & ex_taken;
        assign ex_btb_update_invalidate = ((!ex_btb_alloc) & ex_pred_hit) & ex_pred_taken;
        assign ex_btb_update_revise     = ex_btb_alloc & ex_pred_hit & ex_pred_taken & ex_taken & (ex_ag_result != ex_pred_npc);
        assign ex_btb_update_extend     = ex_btb_alloc &
                                   (ex_ag_result[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1] != ex_pc[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1]);
end
endgenerate

```

Revised coding:

```verilog
generate
     if (BTB_SIZE != 0 && RVC_SUPPORT == "no") begin
    assign rvc_enable  = 1'b0;
end
endgenerate

assign ex_btb_update_alloc      = (ex_btb_alloc & (!ex_pred_hit)) & ex_taken & rvc_enable;
assign ex_btb_update_invalidate = ((!ex_btb_alloc) & ex_pred_hit) & ex_pred_taken;
assign ex_btb_update_revise     = ex_btb_alloc & ex_pred_hit & ex_pred_taken & ex_taken & (ex_ag_result != ex_pred_npc);
assign ex_btb_update_extend     = ex_btb_alloc &
          (ex_ag_result[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1] != ex_pc[VALEN-1:TARGET_ADDRESS_BIT_NUMBER+1]);

```

Original coding:

```verilog
// NOTE: only wb_addr[1:0] and wb_addr[2:0] are different
generate
if (XLEN == 32) begin : gen_una_alignment_logic_32b_load_alignment_logic
        vc_ls_align #(.XLEN(XLEN)) ld_data_align (.unit(wb_size[1:0]), .offset(wb_addr[1:0]), .se(se), .single_access(single),
                                                  .cur_data(ld_din), .pre_data(aligned_pre_data), .out_data(aligned_data), .residue(aligned_pre_data_nx));
end
endgenerate

generate
if (XLEN != 32) begin : gen_una_alignment_logic_64b_load_alignment_logic
        vc_ls_align #(.XLEN(XLEN)) ld_data_align (.unit(wb_size[1:0]), .offset(wb_addr[2:0]), .se(se), .single_access(single),
                                                  .cur_data(ld_din), .pre_data(aligned_pre_data), .out_data(aligned_data), .residue(aligned_pre_data_nx));
end
endgenerate

```

Revise coding

```verilog
// NOTE: unify by configurable bitwidth
wire [XBYTES_WIDTH-1:0] wb_align_offset = wb_addr[XBYTES_WIDTH-1:0];
vc_ls_align #(.XLEN(XLEN)) ld_data_align (.unit(wb_size[1:0]), .offset(wb_align_offset), .se(se), .single_access(single),
                                          .cur_data(ld_din), .pre_data(aligned_pre_data), .out_data(aligned
```

## Aggregate Signal

```verilog
// leverage the same control part for status and rdata. (Reduce similar and duplicated coding)
assign {m2_mem_status, m2_mem_rdata} = ({(XLEN+`LSMEM_BITS){m2_ilm &  lm_support}} & {ilm_status, ilm_rdata})
                                     | ({(XLEN+`LSMEM_BITS){m2_dlm &  lm_support}} & {dlm_status, dlm_rdata})
                                     | ({(XLEN+`LSMEM_BITS){m2_dcu | ~lm_support}} & {dcu_status, dcu_rdata})
                                     ;
```

## set/clr/enable/next Logic for a Flag

Good example:

```verilog
assign yyy_en  =  yyy_set | yyy_clr;
assign yyy_set = ...;
assign yyy_clr = ...;

// assign yyy_nx =  yyy_set | (yyy & ~yyy_clr); // set > clr
   assign yyy_nx = ~yyy_clr & (yyy |  yyy_set); // clr > set

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n)
        yyy <= 1'b0;
    else if (yyy_en)
        yyy <= yyy_nx;
end

```

Bad example:

```verilog
reg mm_vec_ls_start_q;
wire mm_vec_ls_start_clr = mm_replay | (wb_replay & wb_valid) | (mm_ctrl_en & ex_vec_ls_last);

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mm_vec_ls_start_q  <= 1'b0;
    end
    else if (mm_vec_ls_start_clr)
        mm_vec_ls_start_q <= 1'b0;
    else if (mm_ctrl_en) begin
        mm_vec_ls_start_q  <= ex_vec_ls_uop;
    end
end

```

See more in design by:

```verilog
ack "_clr.*_set"
ack "_set.*_clr"
```

## Signal Variants

For example, stall signal derives several variants for different purpose (e.g. timing, mutual-stall and etc.)

Recommended practice:

- put all variants together
- extract/use common part across variants

### Use Loop to Simply the Code

[Digital Logic Design Using Verilog: Appendix I Synthesizable and Non-Synthesizable Verilog Constructs](https://link.springer.com/content/pdf/bbm%3A978-81-322-2791-5%2F1.pdf)

> | functions (and task) | Both are synthesizable. Provided that the task does not have the timing constructs | | loop | The for loop is synthesizable and used for the multiple iterations. |

Complex loop example:

```verilog
// Style-1: combinational logic with wire assignment
// $PVC_LOCALDIR/andes_ip/ar_core/ucore/hdl/ar_mem_isu.v
assign miw_free_list[0]            = (miw_status_nx[0] == MIW_ST_INVLD); //To get free entry
assign miw_free_entry0[0]          = (miw_status_nx[0] == MIW_ST_INVLD);
assign miw_free_entry1[MIW_SIZE-1] = (miw_status_nx[MIW_SIZE-1] == MIW_ST_INVLD);

generate
    for (i_var=2; i_var<MIW_SIZE; i_var=i_var+1) begin: gen_find_unused_entry0
        assign miw_free_list[i_var]   = (miw_status_nx[i_var] == MIW_ST_INVLD);
        assign miw_free_entry0[i_var] = miw_free_list[i_var] & !(|miw_free_list[i_var-1:0]);
    end
endgenerate

```

```verilog
// Style-2: combinational logic with reg
// $PVC_LOCALDIR/andes_ip/ar_core/ucore/hdl/ar_mem_isu.v
// $PVC_LOCALDIR/andes_ip/ar_core/ucore/hdl/ar_mem_isu.v
always @* begin
    miw_wptr0_nx  = {(MIW_WPTR_WIDTH){1'b0}};
    for (i=0; i<MIW_SIZE; i=i+1) begin
        miw_wptr0_nx = ({MIW_WPTR_WIDTH{miw_free_entry0[i]}} & i[MIW_WPTR_WIDTH-1:0]) | miw_wptr0_nx;
    end
end

```

````verilog

```verilog
// $PVC_LOCALDIR/andes_ip/soc/ncepldm200/hdl/ncepldm200.v
wire [HALTGROUP_COUNT:1] group_halt_trig;
reg  [(NHART-1):0]       group_halt_harts;
wire [(NHART-1):0]       halt_group_vector [1:HALTGROUP_COUNT];

for (i = 1; i <= HALTGROUP_COUNT; i = i + 1) begin : gen_halt_group_onehot_per_group
        for (j = 0; j < NHART; j = j + 1) begin : gen_halt_group_onehot_per_hart
                assign halt_group_vector[i][j] = (dmi_hart_halt_group[j] == i[4:0]);
        end
end

for (i = 1; i <= HALTGROUP_COUNT; i = i + 1) begin : gen_group_halt_trig
        assign group_halt_trig[i] =  | (hart_halted_event & halt_group_vector[i]);
end

integer k;
always @* begin
        group_halt_harts = {NHART{1'b0}};
        for (k = 1; k <= HALTGROUP_COUNT; k = k + 1) begin
                group_halt_harts = group_halt_harts | ({NHART{group_halt_trig[k]}} & halt_group_vector[k]);
        end
end
````

# Readability

## Naming Convention

TODO: _n active signal TODO: simple always FSM block

- `~` only for bitwise operation
- `!` only for logic operation
- `always @*`

`integer` and `genvar`

## Bit-width Declaration

- `parameter` and `localparam`
- Width and MSB
    - The that WIDTH is a parameter and MSB is a derived parameter.

```verilog
parameter  ADDR_WIDTH = `original_default;
parameter  DATA_WIDTH = `original_default;
localparam ADDR_MSB = ADDR_WIDTH  - 1;
localparam DATA_MSB = DATA_WIDTH  1;
input  [ADDR_MSB:0] addr;
input  [DATA_MSB:0] wdata;
output [DATA_MSB:0] rdata;
```

# Reusability

## Avoid `defparam`

The `defparam` Verilog syntax may not work well in DC synthesizer, especially within “generate” block. The consensus is:

- all design should not use `defparam`.
- the benches are allowed to use it but only when needed.

For more reason why using `defparam` is not a good practice, please see [New Verilog-2001 Techniques for Creating Parameterized Models(or Down With `define and Death of a defparam!)](http://www.sunburst-design.com/papers/CummingsHDLCON2002_Parameters_rev1_2.pdf).

```verilog
// WARN: this may not work on some synthesizer/simulator
generate
if (CORE_DATA_WIDTH  > 256) begin: gen_sizedn
    defparam axi_sizedn.US_DATA_WIDTH = 256;
    defparam axi_sizedn.DS_DATA_WIDTH = 128;
    axi_sizedn axi_sizedn (
        .us_araddr (core_araddr ),
        .us_arburst(core_arburst),
        // ...
    );
end
endgenerate

// NOTE: This is more compatible
generate
if (CORE_DATA_WIDTH  > 256) begin: gen_sizedn
    axi_sizedn #(
                .US_DATA_WIDTH (256), // NOTE: assign the paramter here
                .DS_DATA_WIDTH (128)
    ) axi_sizedn (
        .us_araddr (core_araddr ),
        .us_arburst(core_arburst),
        // ...
    );
end
endgenerate
```

## Reduce the use of `casez`

Some linting tool may complain the potential misused `casez` . TODO: change title and make the example easier

- for better readability
- let unspecific term as don't-care

The follow example

Example: prioritized decoding could be replaced by

```verilog
// pvc diff $PVC_LOCALDIR/andes_ip/soc/nceplic100/hdl/nceplic100_core.v 1.20 1.22
// Original coding:
always @* begin : gen_lzu_info
        casez(lzu_stack_word_summary[w])
        8'b1??????? : begin lzu_stage1_p_reg_nx[w] = 3'b111; end
        8'b01?????? : begin lzu_stage1_p_reg_nx[w] = 3'b110; end
        8'b001????? : begin lzu_stage1_p_reg_nx[w] = 3'b101; end
        8'b0001???? : begin lzu_stage1_p_reg_nx[w] = 3'b100; end
        8'b00001??? : begin lzu_stage1_p_reg_nx[w] = 3'b011; end
        8'b000001?? : begin lzu_stage1_p_reg_nx[w] = 3'b010; end
        8'b0000001? : begin lzu_stage1_p_reg_nx[w] = 3'b001; end
        8'b00000001 : begin lzu_stage1_p_reg_nx[w] = 3'b0;   end
        default     : begin lzu_stage1_p_reg_nx[w] = 3'b0;   end
        endcase
end

// Revised coding:
assign lzu_stage1_p_reg_nx[w] =
                ({3{lzu_stack_word_summary[w][7  ] == 1'b1}} & 3'b111) |
                ({3{lzu_stack_word_summary[w][7:6] == 2'b1}} & 3'b110) |
                ({3{lzu_stack_word_summary[w][7:5] == 3'b1}} & 3'b101) |
                ({3{lzu_stack_word_summary[w][7:4] == 4'b1}} & 3'b100) |
                ({3{lzu_stack_word_summary[w][7:3] == 5'b1}} & 3'b011) |
                ({3{lzu_stack_word_summary[w][7:2] == 6'b1}} & 3'b010) |
                ({3{lzu_stack_word_summary[w][7:1] == 7'b1}} & 3'b001) |
                ({3{lzu_stack_word_summary[w][7:0] == 8'b1}} & 3'b000) ;

```

Example: prioritized encoding

```verilog
// pvc diff $PVC_LOCALDIR/andes_ip/vc_core/biu/hdl/vc_biu_path.v 1.81 1.82
// Original coding:
always @(biu_arbiter_in0) begin
        casez(biu_arbiter_in0)
                5'b????1: biu_arbiter_out0 = 5'b00001;
                5'b???10: biu_arbiter_out0 = 5'b00010;
                5'b??100: biu_arbiter_out0 = 5'b00100;
                5'b?1000: biu_arbiter_out0 = 5'b01000;
                5'b10000: biu_arbiter_out0 = 5'b10000;
                default : biu_arbiter_out0 = 5'b00000;
        endcase
end

// Revised coding:
assign biu_arbiter_out0[0] = (biu_arbiter_in0[0:0] == 1'b1    );
assign biu_arbiter_out0[1] = (biu_arbiter_in0[1:0] == 2'b10   );
assign biu_arbiter_out0[2] = (biu_arbiter_in0[2:0] == 3'b100  );
assign biu_arbiter_out0[3] = (biu_arbiter_in0[3:0] == 4'b1000 );
assign biu_arbiter_out0[4] = (biu_arbiter_in0[4:0] == 5'b10000);

```

Example: the priority encoding for request/grant arbitration could be implemented by `vperl` `&PRIORITY_ONEHOT_ENCODER()`:

```verilog
// pvc diff $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_dcu.v 1.460 1.461
// VPERL_BEGIN
// &PRIORITY_ONEHOT_ENCODER("i2_evt",
//      [
//      {"iberr_req_i2" => "iberr_gnt_i2"}, # hightest priority
//      {  "nmi_req_i2" =>   "nmi_gnt_i2"}, # ...
//      { "dbgi_req_i2" =>  "dbgi_gnt_i2"}, # ...
//      {  "int_req_i2" =>   "int_gnt_i2"}, # lowest   priority
//      ]
// );
// VPERL_END

// VPERL_GENERATED_BEGIN
wire[3:0]       i2_evt_req;
wire[3:0]       i2_evt_gnt;

assign  i2_evt_req[3] = iberr_req_i2;
assign  i2_evt_req[2] =   nmi_req_i2;
assign  i2_evt_req[1] =  dbgi_req_i2;
assign  i2_evt_req[0] =   int_req_i2;

assign  iberr_gnt_i2  = i2_evt_gnt[3];
assign    nmi_gnt_i2  = i2_evt_gnt[2];
assign   dbgi_gnt_i2  = i2_evt_gnt[1];
assign    int_gnt_i2  = i2_evt_gnt[0];

assign  i2_evt_gnt[3] = (i2_evt_req[3]   == 1'b1);
assign  i2_evt_gnt[2] = (i2_evt_req[3:2] == 2'b1);
assign  i2_evt_gnt[1] = (i2_evt_req[3:1] == 3'b1);
assign  i2_evt_gnt[0] = (i2_evt_req[3:0] == 4'b1);
// VPERL_GENERATED_END

```

```verilog
// pvc diff $PVC_LOCALDIR/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v 1.21 1.22
// Original coding:
always @* begin
    casez({get_mtime_gray, shadow_bin_to_gray})
        3'b1?? : mtime_shadow_gray_nx = mtime_gray_sync;
        3'b000 : mtime_shadow_gray_nx = 2'b00;
        3'b001 : mtime_shadow_gray_nx = 2'b01;
        3'b010 : mtime_shadow_gray_nx = 2'b11;
        3'b011 : mtime_shadow_gray_nx = 2'b10;
        default: mtime_shadow_gray_nx = 2'dx;
    endcase
end

// Revised coding:
assign mtime_shadow_gray_nx = get_mtime_gray ? mtime_gray_sync :
                                               {shadow_bin_to_gray[1],^shadow_bin_to_gray[1:0]};

```

Example:

```verilog
# Original coding:
always @* begin
        casez ({fq_ptr, fq_ready, resp_valid})
        7'b??1_??0_0: {kill_getire_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        7'b??1_??0_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_010;
        7'b??1_?01_0: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_010;
        7'b??1_?01_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_100;
        7'b??1_011_0: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_100;
        7'b??1_011_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        7'b??1_111_?: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        //...
        7'b1??_0??_0: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        7'b1??_0??_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_001;
        7'b1??_1?0_0: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_001;
        7'b1??_1?0_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_010;
        7'b1??_101_0: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b1_010;
        7'b1??_101_1: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        7'b1??_111_?: {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'b0_xxx;
        default:      {kill_fq_ptr_en, kill_fq_ptr_nx} = 4'bx_xxx;
        endcase
end

# Revised coding:
assign kill_fq_ptr_en =
    ( fq_ready[2:0]              != 3'b111 )
  & ({fq_ready[2:0], resp_valid} != 4'b1101)
  & ({fq_ready[2:0], resp_valid} != 4'b1011)
  & ({fq_ready[2:0], resp_valid} != 4'b0111)
  & ({fq_ready[2:0], resp_valid} != 4'b0000);

assign kill_fq_ptr_nx =
    ({3{fq_ptr[0] & ~fq_ready[0]                                &  resp_valid}} & 3'b010)
  | ({3{fq_ptr[0] &  fq_ready[0] & ~fq_ready[1]                 & ~resp_valid}} & 3'b010)
  | ({3{fq_ptr[0] &  fq_ready[0] & ~fq_ready[1]                 &  resp_valid}} & 3'b100)
  | ({3{fq_ptr[0] &  fq_ready[0] &  fq_ready[1] &  ~fq_ready[2] & ~resp_valid}} & 3'b100)
  | ({3{fq_ptr[1] & ~fq_ready[1]                                &  resp_valid}} & 3'b100)
  | ({3{fq_ptr[1] &  fq_ready[1] & ~fq_ready[2]                 & ~resp_valid}} & 3'b100)
  | ({3{fq_ptr[1] &  fq_ready[1] & ~fq_ready[2]                 &  resp_valid}} & 3'b001)
  | ({3{fq_ptr[1] &  fq_ready[1] &  fq_ready[2] &  ~fq_ready[0] & ~resp_valid}} & 3'b001)
  | ({3{fq_ptr[2] & ~fq_ready[2]                                &  resp_valid}} & 3'b001)
  | ({3{fq_ptr[2] &  fq_ready[2] & ~fq_ready[0]                 & ~resp_valid}} & 3'b001)
  | ({3{fq_ptr[2] &  fq_ready[2] & ~fq_ready[0]                 &  resp_valid}} & 3'b010)
  | ({3{fq_ptr[2] &  fq_ready[2] &  fq_ready[0] &  ~fq_ready[1] & ~resp_valid}} & 3'b010);
```

## Use Function to Simply the Code

`module` vs. `function`

- module may derive buffers across module boundary
- function is expanded as normal combination logic. (`function` is similar to `inline` function in C language.)

## Bit Select or Part Select is Allowed

Bit select syntax in Verilog 2001

- `[x:y]`: both `x` and `y` must be constant.
- `[x +: y]` or `[x -: y]`, `x` must be constant while `y` can be variable.

NOTE: if the constant rule is violated, simulator will fail with "Illegal operand for constant expression" error message.

```verilog
assign LEDR[1  : 0] = SW[3  : 2]  & SW[1  : 0];
assign LEDR[3 -: 2] = SW[3 -: 2]  | SW[1 -: 2];
```

```verilog
always @(posedge web) begin
        if (~csb) begin // chip select active
                if (DATA_WIDTH == 8) begin
                        if (~beb[0]) mem[addr]          = data[0 +: 8];
                end
                else if (DATA_WIDTH == 16) begin
                        if (~beb[1]) mem[{addr, 1'b1}]  = data[8 +: 8];
                        if (~beb[0]) mem[{addr, 1'b0}]  = data[0 +: 8];
                end
                else begin
                        if (~beb[3]) mem[{addr, 2'b11}] = data[24 +: 8];
                        if (~beb[2]) mem[{addr, 2'b10}] = data[16 +: 8];
                        if (~beb[1]) mem[{addr, 2'b01}] = data[8  +: 8];
                        if (~beb[0]) mem[{addr, 2'b00}] = data[0  +: 8];
                end
        end
end
```

## Every Variable in Function Should be Local Scope

The use of variable that is outside function scope may lead to failure of RTL synthesis.

```verilog
log/compile.log:Error: vc_dsp.v:2339: Net 'i[0]', or a directly connected net, is driven by more than one source, and at least one source is a constant net. (ELAB-368)
log/compile.log:Error: vc_dsp.v:2759: Net 'i[3]', or a directly connected net, is driven by more than one source, and at least one source is a constant net. (ELAB-368)

```

To avoid variable scope issue, every variables inside `function` should declared locally/explicitly inside `function`.

```verilog
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_dsp.v 1.51
integer i; // NOTE: this is a variable for whole module scope
always @* begin
    for (i=0; i<64; i=i+1) begin
        psimdxlen_bpick_result_64b[i] = psimdxlen_op3_64b[i] ? psimdxlen_op1_64b[i] : psimdxlen_op2_64b[i];
    end
end

assign simd8_shift_result_B0 = simd8_shift(...);
function [8:0] simd8_shift;
    integer      i; // NOTE: this i should be declared locally
    input        is_func_slra;

        for (i=0; i<16; i=i+1) begin: gen_shift_l_din
            shift_l_din[i] = shift_r_din[15-i];
        end
        simd8_shift = {ovfout, result};
    end
endfunction
```

## Allowed Synthsizable Coding

- System functions `$signed()`, `$unsigned()` and `$clog2()` are allowed.
- Part-Select Addressing Operators `([+:]` and `[-:])` are allowed.
- Arithmetic Shift Operators (`<<<` and `>>>`)
- Power Operator `(**)`

System functions `$signed()`, `$unsigned()` `$clog2()` are syntheiszable.

```verilog
// in $PVC_LOCALDIR/andes_vip/vc_core/ucore/hdl/vc_alu.v
//    $PVC_LOCALDIR/andes_vip/vc_core/ucore/hdl/vc_dsp.v

wire           [XLEN:0] shin  = alu_sll ? {1'b0, shin_l[XLEN-1:0]} : shin_r;
wire  [SHAMT_WIDTH-1:0] shamt = alu_word ? {1'b0, alu_op1[SHAMT_WIDTH-2:0]} : alu_op1[SHAMT_WIDTH-1:0];
wire         [XLEN-1:0] shout_r = $signed(shin) >>> shamt;

```

TODO: adding the description about the relationship of `$signed` and `>>>` here

[[SOLVED] Is $signed() task is synthesizable in verilog 2001?](https://www.edaboard.com/showthread.php?208908-Is-signed\(\)-task-is-synthesizable-in-verilog-2001)

> Re: Is $signed() task is synthesizable in verilog 2001? Hi, yes and it is even recommended for better QoR for Design Compiler. Synopsys even has a great appnote about this called "Coding Guidelines for Datapath Synthesis". You can find it on solvnet.

See "Appendix B Verilog Language Support" of HDL Compiler (Presto Verilog) Reference Manual v2008.09 for more example.

---

## DRY (Don't Repeat Yourself) Principle

Example-1: logic reduction

```verilog
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_dcu.v 1.271
(~resp_store & resp_atomic) | (resp_store & ~resp_atomic)

```

Could be simplified to:

```verilog
 (resp_store ^ resp_atomic)

```

Or with proper comment for better/later maintenance:

```verilog
((~resp_store & resp_atomic) |   // atomic instruction , not store => atomic load
  (resp_store & ~resp_atomic))); // store instruction without atomic => normal store

```

Example-2: logic grouping

```verilog
assign ipipe_csr_int_plic_valid = int_vector_plic &
    ~int_disabled & ~(lsu_ipipe_wait_noncacheable_load | ace_int_disabled) & ~vectored_trap_pc_not_valid;

```

Could be clarified to:

```verilog
assign ipipe_csr_int_plic_valid = int_vector_plic &
    ~(int_disabled | ace_int_disabled) // NOTE: group the disable and exclude condictions together
    ~lsu_ipipe_wait_noncacheable_load & ~vectored_trap_pc_not_valid; // valid conidtion

```

Example-3: reduce duplication

```verilog
//VPERL_BEGIN
//:assign wb_localint_code = ({9{wb_reg_localint_m_slpecc & (LOCALINT_SLPECC==12)}} & 9'd12)
//for (my $i=13; $i<32; $i++) {
//:                         | ({9{wb_reg_localint_m_slpecc & (LOCALINT_SLPECC==%d)}} & 9'd%2d)    :: $i, $i
//}
//for (my $i=12; $i<32; $i++) {
//:                         | ({9{wb_reg_localint_s_slpecc & (LOCALINT_SLPECC==%d)}} & (9'd%2d + 9'd256))    :: $i, $i
//}
//VPERL_END

// VPERL_GENERATED_BEGIN
assign wb_localint_code = ({9{wb_reg_localint_m_slpecc & (LOCALINT_SLPECC==12)}} & 9'd12)
                        | ({9{wb_reg_localint_m_slpecc & (LOCALINT_SLPECC==13)}} & 9'd13)
                        | ...
                        | ({9{wb_reg_localint_s_slpecc & (LOCALINT_SLPECC==12)}} & (9'd12 + 9'd256))
                        | ({9{wb_reg_localint_s_slpecc & (LOCALINT_SLPECC==13)}} & (9'd13 + 9'd256))
                        | ...

```

Could be simplified as:

```verilog
// NOTE: Because LOCALINT_SLPECC would be 12, 13 and ....
//       Using LOCALINT_SLPECC to replace original listing logic term would make thing simplier.
assign wb_localint_code = ({9{wb_reg_localint_m_slpecc}} &  LOCALINT_SLPECC)
                        | ({9{wb_reg_localint_s_slpecc}} & (LOCALINT_SLPECC + 9'd256))
```

# Auxiliary

Coding for quality/coverage/lint/debug and etc.

---

## Lint Checking

### Bit Width Mismatch

The principle is to make sure the bit widths of LHS/RHS (assignment or operator) are the same.

- the linting warning on the carry out bit in case-1 is allowed and waivable.
- the first statement in case-2 and case-3 is not a good practice and should be change to second statement.

```verilog
// case-1
assign a[1:0] = b[1:0] + c[1:0]; // NOTE: the warning about carry out bit could be waived

// case-2
assign a[1:0] = b[1:0] + 1'b1;  // WARN: LHS ~= RHS
assign a[1:0] = b[1:0] + 2'b01; // NOTE: the warning about carry out bit could be waived

// case-3
assign valid_cnt[1:0] = valid_a + valid_b + valid_c;                         // WARN: LHS ~= RHS
assign valid_cnt[1:0] = {1'b0, valid_a} + {1'b0, valid_b} + {1'b0, valid_c}; // NOTE: the warning about
```

### Multi-driven Caused by Multi-write

In some case, there may be multiple write to same register structure while the design guarantee that those writes are exclusive. The static linting warns the potential multi-driven issue or multi-write ports to theses kind of structure. The coding can be revised to avoid this kind of linting issue by `merging the write enables` (and the related index/selection) as below:

```verilog
generate
    for (i_var=0; i_var<MIW_SIZE; i_var=i_var+1) begin: gen_miw_wen_gen
        assign miw_instr0_wen[i_var] = miw_instr0_wvld & miw_wready0 & !dispatch_pending & (miw_wptr0 == i_var[MIW_WPTR_WIDTH-1:0]);
        assign miw_instr1_wen[i_var] = miw_instr1_wvld & miw_wready1 & !dispatch_pending & (miw_wptr1 == i_var[MIW_WPTR_WIDTH-1:0]);

        assign miw_wen[i_var] = miw_instr0_wen[i_var] |
                                miw_instr1_wen[i_var] ;

        assign sel_instr0[i_var] = (miw_wptr0 == i_var[MIW_WPTR_WIDTH-1:0]);
    end
endgenerate

generate
    for (i_var=0; i_var<MIW_SIZE; i_var=i_var+1) begin: gen_update_iw
always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                miw_age[i_var]     <= {AGE_WIDTH{1'b0}};
            end
            else if (miw_wen[i_var]) begin
                miw_age[i_var]     <= sel_instr0[i_var] ? uop0_age_in     : uop1_age_in;
            end
        end
    end
endgenerate
```

### Zero Replication

bit extension能是"0”

EX: {0{bit_extension}}

Zero replication

- catch by Vivado as `[Synth 8-693]`
- catch by `xrun` as `W,ZROMCW`

```verilog
WARNING: [Synth 8-693] zero replication count - replication ignored [/NOBACKUP/atcpcw12/ellis/vicuna/andes_ip/vc_core/ucore/hdl/vc_csr.v:9100]
```

```verilog
xmelab: *W,ZROMCW (/NOBACKUP/atcpcw08/flin/vicuna/andes_ip/vc_core/biu/hdl/vc_biu_axi_wrapper.v,869|29): Zero multiple concatenation multiplier, treated as zero width by enclosing concatenation.
        assign awlen   = {{(8-BIU_LENGTH_WIDTH){1'b0}},reg_awlen};
```

Possible solution by conditional `generate` as below:

```verilog
-assign mshr_entry_issue_done_ext = {{(16-MSHR_DEPTH){1'b0}},mshr_entry_issue_done};
+generate
+if (MSHR_DEPTH == 16) begin : gen_mshr_entry_issue_done_eq_16
+       assign mshr_entry_issue_done_ext = mshr_entry_issue_done;
+end
+else begin : gen_mshr_entry_issue_done_less_than_max
+       assign mshr_entry_issue_done_ext = {{(16-MSHR_DEPTH){1'b0}},mshr_entry_issue_done};
+end
+endgenerate
```

Alternative is to extend 1-bit (dummy) to hide the issue:

```verilog
-assign veq_v1_ex_valid         = sel_vp ? v1_ex_valid          : {{(VFU_CNT-8){1'b0}},v1_fp_ex_valid[2:0],5'b0};
+wire ext1; // [lint] extend one bit to avoid "Zero multiple concatenation multiplier issue"
+assign {ext1,veq_v1_ex_valid}  = sel_vp ? {1'b0,v1_ex_valid}   : {{(VFU_CNT-8+1){1'b0}},v1_fp_ex_valid[2:0],5'b0};
```

### Generate/Wiring Dummy/Extra Bits Only When Necessary

```verilog
// ISSUE: [WARN (VERI-9005)] ncepldm200.v(1631): 10-bit index expression resumereq_hartsel truncated to 2 bits

reg  [9:0]    resumereq_hartsel;
wire [1023:0] hart_resumereq_active;
assign hart_resumereq_active[(NHART-1):0] =  hart_resumereq[(NHART-1):0] & ~hart_resumeack[(NHART-1):0];

generate // SOLUTION: conditionally generate code
if (NHART < 1024) begin : gen_hart_resumereq_active_hardwired
        assign hart_resumereq_active[1023:NHART] = {(1024-NHART){1'b0}};
end
endgenerate

assign resumereq_valid = hart_resumereq_active[resumereq_hartsel];

```

### Unused Wire

Use `unused_wire` (and the variants) to mark the wires to be waived in linting checking.

```
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_ilm.v
wire    unused_wire = ilm_ecc_1bit_error  | ilm_ecc_2bit_error | ...

```

```
// $PVC_LOCALDIR/andes_ip/soc/ncepldm200/hdl/ncepldm200.v
wire unused_wires = (|dmi_hprot) | (|rv_hprot) | ...

```

```
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_dcu.v
wire unused_wire0 = ...
wire unused_wire1 = ...
wire unused_wire2 = ...

```

---

### Unequal Length Operand in Bit/Arithmetic Operator of Parameter

There may be linting warning on the use of parameter as arithmetic logic:

```verilog
// HAL: Unequal length operand in bit/arithmetic operator AND in module/design-unit vc_ipipe.
parameter LOCALINT_SLPECC = 9'd12;
assign wb_localint_code = ({9{wb_reg_localint_m_slpecc}} & LOCALINT_SLPECC);
```

The width specifier in the use of parameter can resolve this issue:

```verilog
assign wb_localint_code = ({9{wb_reg_localint_m_slpecc}} & LOCALINT_SLPECC[8:0]);
```

Although range modifier on parameter could resolve the linting warning, this SystemVerilog syntax may not be compatible across all EDA tools.

```verilog
parameter logic [8:0] LOCALINT_SLPECC = 9'd12;
```

### Wire Wrapper Outside `generate` Block

The linting tool complains there is un-driven variable on the following coding.

```verilog
// PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_ifu.v 1.252
reg [1:0]  bht_offset_0_rdata;

generate
if (BTB_SIZE != 0 && (RVC_SUPPORT == "yes")) begin : gen_bht_array_control_for_isa_c_support
always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            bht_offset_0_rdata    <= 2'b0;
        end
        else if (pred_valid) begin
            bht_offset_0_rdata    <= bht_offset_0_rdata_nx;
        end
    end
end //gen_bht_array_control_for_no_isa_c_support
else begin : gen_bht_array_control_else_case
end // gen_bht_array_control_else_case
endgenerate

```

The wrapper wire coding could solve it.

```verilog
// PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_ifu.v 1.251
wire [1:0] bht_offset_0_rdata;

generate
if (BTB_SIZE != 0 && (RVC_SUPPORT == "yes")) begin : gen_bht_array_control_for_isa_c_support
    reg  [1:0] bht_offset_0_rdata_reg;  // NOTE: add signal wrapping like this
always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            bht_offset_0_rdata_reg    <= 2'b0;
        end
        else if (pred_valid) begin
            bht_offset_0_rdata_reg    <= bht_offset_0_rdata_nx;
        end
    end
    assign    bht_offset_0_rdata = bht_offset_0_rdata_reg;
end //gen_bht_array_control_for_no_isa_c_support
else begin : gen_bht_array_control_else_case
    assign bht_offset_0_rdata = 2'b0;
end // gen_bht_array_control_else_case
endgenerate

```

---

### Bit-width Mismatch on Multiple Possible Width

```verilog
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_csr.v  1.342
assign dpc_reset_vector    = (EXTVALEN > VALEN) ? {1'b0, reset_vector} : reset_vector[EXTVALEN-1:0];
```

```verilog
// $PVC_LOCALDIR/andes_ip/vc_core/ucore/hdl/vc_csr.v  1.343
assign dpc_reset_vector    = {{(EXTVALEN - VALEN){1'b0}}, reset_vector};
```

NOTE: most simulators allow zero-length coding although some linting may complaint on it.

---

### Optimization Due to Constant Propagation

The synthesizer may optimize out some logic/FF when some logic are constant. Because some signal may be tied to constant under system integration, the example warning below is waivable.

```verilog
log/elaborate.log:Warning:  $PVC_LOCALDIR/andes_ip/soc/nceplic100/hdl/nceplic100_core.v:438: Netlist for always block is empty. (ELAB-985)
```

```verilog
# $PVC_LOCALDIR/andes_ip/soc/nceplic100/hdl/nceplic100_core.v
#   plic_sw has int_src tied to 31'b0. As a result, this part of code will be optimized out if the constant optimization through sequential cells is enabled.
#   Then the "always block is empty" message may be reported.

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        int_src_d1 <= {(INT_NUM){1'b0}};
    else
        int_src_d1 <= int_src_sync_out;
end
```

### Avoid Using Supply 0

Synthesis tool (DC) may complaint on `supply0` and `supply1`. Use `wire xxx = 'b0;` instead.

NOTE: the support of `supply0` and `supply1` is obsoleted after `vperl` v1.x

## Assertion

```
// immediate assertion: in some simulator #0 is required
`ifdef WITH_AST
AST_onehot:
assert ($onehot0({a, b, c}) else begin
    $error("%0t:%m:ERROR:%m: {a, b, c}=%x should be onehot", $time, {a, b, c} );
end
`endif // WITH_AST
```

## Coverage Checking

### **Disable Coverage Checking on Default State of FSM**

Enable unknown injection but disable coverage analysis

```verilog
always @* begin
    micro_state_nx = MICRO_IDLE;
    case (micro_state)
        MICRO_IDLE:
            if (ii_amo_instr) begin
                micro_state_nx = MICRO_AMO;
            end
    `ifdef WITH_COV
    // pragma coverage off
    `endif // WITH_COV
        default: micro_state_nx = 1'bx;
    `ifdef WITH_COV
    // pragma coverage on
    `endif // WITH_COV
    endcase
end

```

However, for the case with full case statements. The listing for unknown propagation is not necessary and may introduce another linting warning as below.

```
`| CDFG-472 |Warning | 152 |Unreachable statements for case item. |`

```

The example solution below uses one of the case as `default` one for the fully-listed cases to avoid the linting issue.

```verilog
index 3b5537657..0496dd57e 100644
--- a/andes_ip/vc_core/ucore/hdl/vc_ld_align_una.v
+++ b/andes_ip/vc_core/ucore/hdl/vc_ld_align_una.v
@@ -81,7 +81,6 @@ if (XLEN == 64) begin : gen_merge_64
         reg    [    XLEN - 1:0] window_;
         begin
                 case (os)
-                        3'b000:  window_ =                                           cur;
                         3'b001:  window_ = single_access ? {cur[ 7:0], cur[63: 8]}: {cur[ 7:0], pre[55:0]};
                         3'b010:  window_ = single_access ? {cur[15:0], cur[63:16]}: {cur[15:0], pre[47:0]};
                         3'b011:  window_ = single_access ? {cur[23:0], cur[63:24]}: {cur[23:0], pre[39:0]};
@@ -89,17 +88,10 @@ if (XLEN == 64) begin : gen_merge_64
                         3'b101:  window_ = single_access ? {cur[39:0], cur[63:40]}: {cur[39:0], pre[23:0]};
                         3'b110:  window_ = single_access ? {cur[47:0], cur[63:48]}: {cur[47:0], pre[15:0]};
                         3'b111:  window_ = single_access ? {cur[55:0], cur[63:56]}: {cur[55:0], pre[ 7:0]};
-                        `ifdef WITH_COV
-                        // pragma coverage off
-                        `endif  // WITH_COV
-                        default: window_ = {XLEN{1'bx}};
-                        `ifdef WITH_COV
-                        // pragma coverage on
-                        `endif  // WITH_COV
+                       default:  window_ =                                           cur;
                 endcase

```

---

## Debugging

### E**nable Signal for Waveform Debugging**

Sometimes, some signals (e.g. content of array entries) are useful when debugging. Linting tool may complain these unused signals. We can leverage `DUMP_ENABLE` which is defined by `runr` when dumping waveform.

```verilog
`ifdef DUMP_ENABLE
wire xxx_debug ; // glue logic for debugging
`endif

```

Debug array content by auxiliary code generated with `vperl`:

```verilog
reg [8:0] edm_bpc [0:`NDS_BREAKPOINT_NUM-1];

generate
for(i = 0; i < `NDS_BREAKPOINT_NUM; i = i + 1) begin: gen_edm_bp_set
        // BPC${i}
always @(posedge core_clk or negedge core_reset_n) begin
                if(!core_reset_n)
                        edm_bpc[i] <= 9'b0;
                else if (update_edm_bpc[i])
                        edm_bpc[i] <= edm_sr_din[8:0];
        end
end
endgenerate

// VPERL_BEGIN
//:`ifdef DUMP_ENABLE // for dumping debug only
// for my $i (0..7) {
//:`ifdef       NDS_BREAKPOINT_SET_${i}
//:wire sru_edm_bpc${i}         = edm_bpc[${i}]; // for waveform debugging
//:wire sru_edm_bpc${i}_byte_en = edm_bpc[${i}][8:5];
//:`endif       // end of NDS_BREAKPOINT_SET_${i}
//}
//:`endif // DUMP_ENABLE
// VPERL_END
```