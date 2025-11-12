# hw_power_sequence

- hw deep sleep mode power down sequence
	- at active mode
	- at wait mode
	- disable clock
	- enable iso_en (isolation)
	- enable ret_en (retention)
	- resetn
		- when power down, assert resetn
		- when power up , deassert resetn
	- power down
	- at deep sleep mode
	- PS: hw deep sleep mode power up sequence 就是反過來操作
- hw light sleep mode power down sequence
	- at active mode
	- at wait mode
	- disable clock
	- at deep sleep mode
	- PS: hw light sleep mode power up sequence 就是反過來操作