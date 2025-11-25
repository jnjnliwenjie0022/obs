# hw_power_sequence

- ref: power sequence
	- ![[Low Power Methodology Manual For System-on-Chip Design.pdf#page=72&rect=134,243,458,378|Low Power Methodology Manual For System-on-Chip Design, p.72|1000]]
- ref: power architecture
	- ![[Low Power Methodology Manual For System-on-Chip Design.pdf#page=88&rect=127,147,465,302|Low Power Methodology Manual For System-on-Chip Design, p.88 | 1000]]
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
- Notice: 根據以上的設計原則, 我們可以知道, reset 必須只能是 async reset, 如果是 sync reset, power on sequence 必然錯誤在 resetn assert -> power off -> power on -> resetn deassert -> clock 的過程中, power on 之後 register init 永遠爲 unknown value, 因此可以推論得知 sync reset 的 sequence 必然不同

