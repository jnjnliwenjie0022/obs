# hw_power_sequence

- ref: [[Low Power Methodology Manual For System-on-Chip Design.pdf#page=115|Low Power Methodology Manual For System-on-Chip Design, p.115]]
- ref: [[Low Power Methodology Manual For System-on-Chip Design.pdf#page=71|Low Power Methodology Manual For System-on-Chip Design, p.71]]
- PS: hw deep / light sleep mode power up sequence 就是反過來操作
- hw deep sleep mode power down sequence
	- at active status
	- at wait status
	- clock
	- iso_en
	- ret_en (retention)
	- resetn
	- power
	- at deep sleep status
- hw light sleep mode power down sequence
	- at active status
	- at wait status
	- clock
	- at deep sleep status
- Notice: 根據以上的設計原則, 我們可以知道, reset 必須只能是 async, 如果是 sync, power on sequence 必然錯誤