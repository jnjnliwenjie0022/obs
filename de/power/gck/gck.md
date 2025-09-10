- ref: https://blog.csdn.net/zhenhuagege/article/details/102837173
- latch也需要解setup time和hold time
- 解決glitch
	- CLK is 0, update latch, Output always "0" (無glitch)
	- CLK is 1, latch engage, Output is depended on ENL (無glitch, 因爲input是latch out)

![[gck.svg|1000]]

- 以下是STARC的DFT+GCK設計建議
![[RTL Design Style Guide.pdf#page=247&rect=94,149,520,413|RTL Design Style Guide, p.247|500]]

# ICG

- **ICG 的最大特點就是「安全無毛刺的時鐘閘控」**，優點在於 **降低功耗、工具支持完善、時序容易收斂**，是 ASIC 設計裡標準的 clock gating 做法。
- 個人覺得優勢是APR的layout可以很近, 排除因爲APR帶來的所有風險