![[verification_spec.svg|500]]

- core design requirement
	- core interface toggle coverage 100%
	- core internal design coverage 100%
- Test Suite：藍色（不可以調整範圍）
	- coverage definition:
		- module内部都要收集coverage，包含interface
		- coverage除了expression都要收集
- Test Suite：紅色（可以調整範圍）
	- coverage definition:
		- module内部不收集coverage, 但包含interface
		- 
	- Module内部完成驗證的
	- 主要是看toggle coverage
	- pattern attribute: scenario
- Test Suite：綠色（可以調整範圍）
	- 不用看coverage
	-  pattern attribute: scenario