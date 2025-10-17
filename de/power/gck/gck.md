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
andla_RC_CG_MOD_150 andla_RC_CG_HIER_INST150(.enable (n_955), .ck_in(clk), .ck_out (andla_rc_gclk_11174), .test (1'b0));
```
![[Pasted image 20251018043644.png]]
![[Pasted image 20251018045341.png]]


- 以下是STARC的DFT+GCK設計建議
	- ![[RTL Design Style Guide.pdf#page=247&rect=94,149,520,413|RTL Design Style Guide, p.247|500]]
- 以下是Scan Chain的補充說明
	- ![[Pasted image 20251017140317.png]]
