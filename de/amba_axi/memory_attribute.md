# bufferable

| Type  | Bufferable | Modifiable | Allocate | Other Allocate | Response Description                                                     |
| ----- | ---------- | ---------- | -------- | -------------- | ------------------------------------------------------------------------ |
| Write | 0          | X          | X        | X              | final destination                                                        |
| Write | 1          | X          | X        | X              | intermediate point                                                       |
| Read  | 0          | 1          | 0        | 0              | final destination                                                        |
| Read  | 1          | 1          | 0        | 0              | intermediate point (write that is progressing to the final destination.) |
| Read  | X          | 0          | X        | X              | final destination                                                        |

# modifiable

- Non-modifiable transactions
	- 可改變
		- ID, QoS
		- Bufferable -> Non-bufferable
	- 不可改變
		- AxADDR, AxREGION, AxSIZE, AxLEN, AxBURST, AxPROT, AxNSE 
		- Allocate, Other Allocate
	- 例外的可改變
		- Length greater than 16 can be split into multiple transactions
			- AxLEN, AxADDR
		- AxLOCK is asserted
			- AxSIZE, AxLEN (只要滿足 AxSIZE \* AxLEN =  \`AxSIZE \* \`AxLEN)
		- Downsize (data width narrower than required by Size)