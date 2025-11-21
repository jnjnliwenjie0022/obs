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

# hw_sw_sequence

- 這個是 Andes CPU 的 power sequence, 需要注意的是他們要求中途一定要 CPU 進入 WFI
	- CPU power off 前, PC 必須被記錄, 並進入 WFI
	- CPU power on 的時候, 會進入 ISR, 在 ISR 中取得 PC
	- ![[Pasted image 20251119143418.png | 1000]]
# smu

- ![[system_management_unit.svg]]
	- 

# ppu

- ![[power_control_slot.svg]]
	- 