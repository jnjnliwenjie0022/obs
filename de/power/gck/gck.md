- ref: https://blog.csdn.net/zhenhuagege/article/details/102837173
- latch也需要解setup time和hold time
- 解決glitch
	- CLK is 0, update latch, Output always "0" (無glitch)
	- CLK is 1, latch engage, Output is depended on ENL (無glitch, 因爲input是latch out)
- 實際的ICG Cell考慮到
	- glitch 問題
	- low power 問題
	- APR layout 問題
- RTL Simulation 用的 GCK
	- ![[gck.svg|500]]
 ```verilog
    always #10 clk = ~clk;
    initial begin
        {clk,rst_n} = 0;
        #105 rst_n = 1;
    end

    reg [3:0] clk_cnt;
    always @ (posedge clk or negedge rst_n)
        if (!rst_n)
            clk_cnt <= 4'd0;
        else
            clk_cnt <= clk_cnt + 4'd1;
// gck for rtl-simulation
    wire clk_en = clk_cnt[3];

    reg latch_out;
    always @(clk or clk_en)
        if (!clk)
            latch_out <= clk_en;

    wire clk_out = clk & latch_out;
////////////////////////////////////
```
- DV實際結果:
	- 
	- ![[Pasted image 20251018041246.png]]
- 實際 gate-level 用的 GCK
```verilog
  CKLNQOPTMAD4BWP30P140 RC_CGIC_INST(.E (enable), .CP (ck_in), .TE(test), .Q (ck_out));
```

```verilog
module CKLNQOPTMAD4BWP30P140 (TE, E, CP, Q);
    input TE, E, CP;
    output Q;
    reg notifier;
    `ifdef NTC
        wire TE_d, E_d, CP_d;
        pullup (CDN);
        pullup (SDN);
        or (D_i, E_d, TE_d);
        not (CPB, CP_d);
        tsmc_dla (Q_buf, D_i, CPB, CDN, SDN, notifier);
        and (Q, Q_buf, CP_d);
    `else 
        pullup (CDN);
        pullup (SDN);
        or (D_i, E, TE);
        not (CPB, CP);
        tsmc_dla (Q_buf, D_i, CPB, CDN, SDN, notifier);
        and (Q, Q_buf, CP);
    `endif 

  `ifdef TETRAMAX
  `else
    tsmc_xbuf (nTE_SDFCHK, nTE, 1'b1);
    tsmc_xbuf (nE_SDFCHK, nE, 1'b1);
    tsmc_xbuf (E_TE_SDFCHK, E_TE, 1'b1);
    tsmc_xbuf (E_nTE_SDFCHK, E_nTE, 1'b1);
    tsmc_xbuf (nE_TE_SDFCHK, nE_TE, 1'b1);
    tsmc_xbuf (nE_nTE_SDFCHK, nE_nTE, 1'b1);
    not (nTE, TE);
    not (nE, E);
    and (E_TE, E, TE);
    and (E_nTE, E, nTE);
    and (nE_TE, nE, TE);
    and (nE_nTE, nE, nTE);


  // Timing logics defined for default constraint check
    `ifdef NTC
      not  (E_int_not, E_d);
      not  (TE_int_not, TE_d);
    `else
      not  (E_int_not, E);
      not  (TE_int_not, TE);
    `endif
    buf  (E_check, TE_int_not);
    buf  (TE_check, E_int_not);
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (TE_DEFCHK, TE_check, 1'b1);

  specify
    if (E == 1'b1 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b1 && TE == 1'b0)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b0)
    (negedge CP => (Q+:1'b0)) = (0, 0);
    $width (posedge CP &&& E_TE_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& E_TE_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& E_nTE_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& E_nTE_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& nE_TE_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& nE_TE_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& nE_nTE_SDFCHK, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& nTE_SDFCHK, posedge E , 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& nTE_SDFCHK, negedge E , 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& nE_SDFCHK, posedge TE , 0, 0, notifier,,, CP_d, TE_d);
    $setuphold (posedge CP &&& nE_SDFCHK, negedge TE , 0, 0, notifier,,, CP_d, TE_d);
  `else
    $setuphold (posedge CP &&& nTE_SDFCHK, posedge E , 0, 0, notifier);
    $setuphold (posedge CP &&& nTE_SDFCHK, negedge E , 0, 0, notifier);
    $setuphold (posedge CP &&& nE_SDFCHK, posedge TE , 0, 0, notifier);
    $setuphold (posedge CP &&& nE_SDFCHK, negedge TE , 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule
`endcelldefine

primitive tsmc_dla (q, d, e, cdn, sdn, notifier);
   output q;
   reg q;
   input d, e, cdn, sdn, notifier;
   table
   1  1   1   ?   ?   : ?  :  1  ; // Latch 1
   0  1   ?   1   ?   : ?  :  0  ; // Latch 0
   0 (10) 1   1   ?   : ?  :  0  ; // Latch 0 after falling edge
   1 (10) 1   1   ?   : ?  :  1  ; // Latch 1 after falling edge
   *  0   ?   ?   ?   : ?  :  -  ; // no changes
   ?  ?   ?   0   ?   : ?  :  1  ; // preset to 1
   ?  0   1   *   ?   : 1  :  1  ;
   1  ?   1   *   ?   : 1  :  1  ;
   1  *   1   ?   ?   : 1  :  1  ;
   ?  ?   0   1   ?   : ?  :  0  ; // reset to 0
   ?  0   *   1   ?   : 0  :  0  ;
   0  ?   *   1   ?   : 0  :  0  ;
   0  *   ?   1   ?   : 0  :  0  ;
   ?  ?   ?   ?   *   : ?  :  x  ; // toggle notifier
   endtable
endprimitive

```
- 使用後
![[Pasted image 20251018043644.png]]
![[Pasted image 20251018045341.png]]


- 以下是STARC的DFT+GCK設計建議
	- ![[RTL Design Style Guide.pdf#page=247&rect=94,149,520,413|RTL Design Style Guide, p.247|500]]
- 以下是Scan Chain的補充說明
	- ![[Pasted image 20251017140317.png]]
