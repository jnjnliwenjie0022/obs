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
	- ![[gck.svg|1000]]
![[Pasted image 20251018041246.png]]
- 實際 gate-level 用的 GCK
``` 
andla_RC_CG_MOD_150 andla_RC_CG_HIER_INST150(.enable (n_955), .ck_in(clk), .ck_out (andla_rc_gclk_11174), .test (1'b0));
```



- 以下是STARC的DFT+GCK設計建議
	- ![[RTL Design Style Guide.pdf#page=247&rect=94,149,520,413|RTL Design Style Guide, p.247|500]]
- 以下是Scan Chain的補充說明
	- ![[Pasted image 20251017140317.png]]