# hw_power_sequence

- hw power down sequence
	- enable iso_en (isolation)
	- enable ret_en (retention)
	- disable clock
	- enable ESD power clamp (UPF simulation)
	- disable power (UPF simulation)
	- assert resetn
- hw power up sequence
	- assert resetn
	- enable clock
	- 