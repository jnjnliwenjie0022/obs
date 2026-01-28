# verilog

- 語法對應的電路屬性
	- ref: https://www.cnblogs.com/oomusou/archive/2010/07/30/blocking_vs_nonblocking.html
	- ref: https://aijishu.com/a/1060000000202226
		- 對於 latch 的理解
```verilog
// logic
always @* begin
    a = a;
end

// latch
// 用在 RTL-simulation gck
always @* begin
    a <= a;
end

// register
// 用在 RTL-simulation gen clk, 確保 clk_out 爲 blocking
always @ (posedge clk) begin
    a = a;
end

// register
always @ (posedge clk) begin
    a <= a;
end
```
# frontend

- latch也需要解setup time和hold time
- 解決glitch
	- CLK is 0, update latch, Output always "0" (無glitch)
	- CLK is 1, latch engage, Output is depended on ENL (無glitch, 因爲input是latch out)
- 實際的ICG Cell考慮到
	- glitch 問題
	- low power 問題
	- APR layout 問題
- RTL Simulation 用的 gck
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
	- ![[Pasted image 20251018041246.png]]
	- ![[gck_waveform.svg]]
- 實際 gate-level 用的 gck
	- ref: [[CKLNQOPTMAD4BWP30P140.v]]
```verilog
  CKLNQOPTMAD4BWP30P140 RC_CGIC_INST(.E (enable), .CP (ck_in), .TE(test), .Q (ck_out));
```
	
- ![[tsmc_gck.svg]]

- 使用後發現 clk 會 race condition
	- clk 從 blocking 變成 non-blocking
	- ![[Pasted image 20251018043644.png]]
	- 這個才是我們想要的行爲
		- ![[Pasted image 20251018045341.png]]
	- 結論: 在 gate-level simulation 中如果有**使用 ICG CELL 建議要吃 SDF** 
		- ![[Pasted image 20251121154103.png]]

## specify

- ref: [[de/platform/gck/code/specify/vip/riu_top.sv|riu_top]]
- ![[specify.svg]]

# icg_skew

- 用 capture and launch 來說明 DFF 和 ICG 的行爲會比較好統一
	- hold time 的 buffer 要安插在 capture
	- skew = Tcapture - Tlaunch
- ref: https://vocus.cc/article/6745bf43fd89780001828dad
- ref: https://blog.csdn.net/Albert66666/article/details/141748849
- ref: http://ee.mweda.com/ask/335176.html
- ![[skew.svg|1000]]
- ICG 特性
	- 共用 ICG 可以減少 Area
	- 很容易產生負數的 Skew
	- Placement 和 Routing 對 Skew 有很大的影響
	- ICG 儘量接近 Capture, 藉此減少 skew
	- ICG 儘量接近 Launch, 藉此減少 power
	- 多級 ICG, 同時滿足 skew and power

# glitch

- 只要 CLK@A 和 CLK@B 有 delay 就會有 glitch 的問題發生, 解決方法是透過 APR 處理
- ![[Pasted image 20251223114206.png]]

# CTS #TODO

- ref: https://blog.csdn.net/weixin_41464428/article/details/111400942
- ref: https://aijishu.com/a/1060000000439299
- ref: https://blog.csdn.net/weixin_37584728/article/details/144055456?spm=1001.2101.3001.4242.2&utm_relevant_index=3

# testing

- register 需要置換
	- 之前的 interface: CLK, D, Q
	- 之後的 interface: CLK, D, Q, SI, SE,

	- ![[reg.svg|1000]]
- gck 不用置換
	- interface: EN, CLK_IN, SE, CLK_OUT





- ![[Pasted image 20260127193018.png|1000]]
- 