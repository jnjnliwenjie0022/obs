![[Pasted image 20250804132816.png]]

- constant 一定要宣告bit width
- module input 不可以直接給數值

1. constant 一定要宣告 bit width
2. module interface connection 是不可以直接給值，即便是常數，也永遠是要先給到一個 wire，connection 只能出現 wire 不能出現其他的
3. module interface connection 不可以空接，宣告 unused_wire_xxxx 去接，然後 waive rule 去 waive 掉所有針對 unused_wire_ 的部份

![[Pasted image 20250804133458.png]]