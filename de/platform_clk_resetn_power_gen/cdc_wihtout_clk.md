# handshake

- 4 phase handshake
	- 必須有4個 phase
	- rsp == 1 && ack == 0 的時候資料合法
- 2 phase handshake
	- 必須有2個phase
	- rsp ^ ack 的時候資料合法
	- rsp == ack 的時候資料不合法
- 其實只要是 handshake 結構就會發生 deadlock or livelock, 解決方式如下
	- - ref: https://fpgacpu.ca/fpga/handshake.html
	- deadlocks
		- sender 的 valid 不能 depend on ready
	- livelocks
		- sender 和 receiver 要確切執行 handshake, 以 valid-ready han'k

ref: https://mp.weixin.qq.com/s/EDAjjVJzzyKstI10fqv6Lw
ref: https://zhuanlan.zhihu.com/p/530973109


#TODO

ref: https://hackmd.io/@TRChen/S1DOZOOS6