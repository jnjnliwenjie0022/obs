![[Pasted image 20250804132816.png]]

- constant 一定要宣告 bit width
- module input/output 不能 floating，且一定要有 wire 宣告，即便是常數，或是 floating
	- 如果 output 的行爲真的是 floating，則用 unused_wire_xxx 去對接，並在 waive rule 去 waive unused_wire_xxx
	- ![[Pasted image 20250821132202.png]]

![[Pasted image 20250804133458.png]]