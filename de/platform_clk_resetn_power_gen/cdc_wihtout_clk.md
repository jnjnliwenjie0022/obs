# handshake

- ref: https://aijishu.com/a/1060000000200711
- 4 phase handshake
	- 必須有4個 phase
	- rsp == 1 && ack == 0 的時候資料合法
- 2 phase handshake
	- ref: https://zhuanlan.zhihu.com/p/530973109
	- 必須有2個phase
	- rsp ^ ack 的時候資料合法
	- rsp == ack 的時候資料不合法
- 其實只要是 handshake 結構就會發生 deadlock or livelock, 解決方式如下
	- - ref: https://fpgacpu.ca/fpga/handshake.html
	- deadlock
		- sender 的 valid 不能 depend on ready
	- livelock
		- sender 和 receiver 要確切執行 handshake, 以 valid-ready handshake 爲例子, sender 和 receiver 都必須確實出現 valid == 1 && ready == 1


#TODO

ref: https://hackmd.io/@TRChen/S1DOZOOS6