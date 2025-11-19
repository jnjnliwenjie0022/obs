# concept

- ref: https://zhuanlan.zhihu.com/p/161891614
- ref: https://zhuanlan.zhihu.com/p/161010994
- ref: https://zhuanlan.zhihu.com/p/161194737
- ref: https://zhuanlan.zhihu.com/p/161787237
- always_on_power_domain
	- PMU
	- RTC
	- Watchdog
	- RSTGEN
	- CLKGEN
- Low_power_mode
	- Normal:
		- power on
		- clock on
	- Light Sleep
		- power on
		- clock off
	- Deep Sleep
		- power off
		- clock off
		- Need micro-second to wake up

# andes_solution

- 這個是 Andes CPU 和周邊共用的 power sequence, 最需要注意的是他們要求中途一定要 CPU 進入 WFI
	- CPU power off 前進入 PC 必須記錄在 WFI, CPU power on 的時候脫離 WFI
	- 周邊電路在進入 power off 的時候, CPU 也會進入 WFI (這個真的有點問題!!明明就和CPU沒什麼關係)
	- ![[Pasted image 20251119143418.png | 1000]]