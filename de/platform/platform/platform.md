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

# sequence

- 這個是 Andes CPU 的 power sequence, 需要注意的是他們要求中途一定要 CPU 進入 WFI
	- CPU power off 前, PC 必須被記錄, 並進入 WFI
	- CPU power on 的時候, 會進入 ISR, 在 ISR 中取得 PC
	- ![[Pasted image 20251119143418.png | 1000]]
# smu

- ![[system_management_unit.svg]]

# pcs

- ![[power_control_slot.svg]]
	- 爲了設計的安全性, output 一律 register out

# waveform

![[Pasted image 20251208191132.png]]
- notice: 
	- ref: [[cdc]]
	- async handshake(req/ack) 不要使用 2 phase handshake, 使用 4 phase handshake 比較安全
```json
{signal: [
  {name: 'cs',               wave: '3.4.5.6789.=....9.8765.3...', data:['active','wait','frq','iso','ret','rst','pwr','sleep','pwr','rst','ret','iso','frq','active']},
  {name: 'cmd',              wave: 'x3x..........|x............', data:'sleep'},
  {name: 'pcs_slv_req',      wave: 'l.h.l........|x............'},
  {name: 'pcs_slv_ack',      wave: 'l..h.l.......|x............'},
  {name: 'pcs_clkgen_req',   wave: 'l...h.l......|x............'},
  {name: 'pcs_clkgen_ack',   wave: 'l....h.l.....|x............'},
  {name: 'clk',              wave: 'p.....l......|x............'},
  {name: 'pcs_iso',          wave: 'l.....h......|x............'},
  {name: 'pcs_ret',          wave: 'l......h.....|x............'},
  {name: 'pcs_resetn',       wave: 'h.......l....|x............'},
  {name: 'pcs_pwr_req',      wave: 'l........h.l.|x............'},
  {name: 'pcs_pwr_ack',      wave: 'l.........h.l|x............'},
  {name: 'pcs_wakeup_event', wave: 'l............|.h...........'},
  {name: 'pcs_pwr_req',      wave: 'x............|l.h.l........'},
  {name: 'pcs_pwr_ack',      wave: 'x............|l..h.l.......'},
  {name: 'pcs_resetn',       wave: 'x............|l...h........'},
  {name: 'pcs_ret',          wave: 'x............|h....l.......'},
  {name: 'pcs_iso',          wave: 'x............|h.....l......'},
  {name: 'pcs_clkgen_req',   wave: 'x............|l......h.l...'},
  {name: 'pcs_clkgen_ack',   wave: 'x............|l.......h.l..'},
  {name: 'clk',              wave: 'x............|l........p...'},
]}
```

# arch

![[andes_platform.svg]]

# soft_reset

- 將 soft_reset 分成 assert 和 deassert 是一個聰明的做法, 但在 synthesis 的時候會有問題, async 和 sync 電路會混合, 直接導致合成出現 warning, 對於 SoC 公司而言無所謂, 但對於 IP 公司而言是個麻煩, 因爲 IP 公司不處理 SoC 的 synthesis, 需要跟客戶直接說明這個 warning, 太麻煩, 不推薦, ARM U-series 的解決方式是不做 soft_reset, 將 soft_reset 和 hard_reset 共用一個 reset, 這個 reset 用 hard reset 實作
- ![[arm_ethos-u85_npu_technical_reference_manual_102685_0000_05_en.pdf#page=34&rect=80,334,558,529|arm_ethos-u85_npu_technical_reference_manual_102685_0000_05_en, p.34]]