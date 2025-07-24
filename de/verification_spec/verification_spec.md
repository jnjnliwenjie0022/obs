![[verification_spec.svg|1000]]

core coverage的要求是
1. core interface toggle coverage
2. core internal design


- 藍色：
	- Test Suite: UT
	- Major Coverage: block, fsm, assert, coverage group, toggle for input/output
- 紅色：
	- Test Suite: IT
	- Major Coverage: toggle for input/output
	- Unit Design assumes that verification has done
	- IT的範圍是可以改變的
- Coverage：
	- 藍色的要求是
	- 紅色