# handshake

- 4 phase handshake
	- 必須有4個 phase
	- rsp == 1 && ack == 0 的時候資料合法
	- 不會有livelock
- 2 phase handshake
	- 必須有2個phase
	- rsp ^ ack 的時候資料合法
	- rsp == ack 的時候資料不合法
	- 會有livelock
- ref: https://fpgacpu.ca/fpga/handshake.html
- deadlocks
	- 
- livelocks

ref: https://mp.weixin.qq.com/s/EDAjjVJzzyKstI10fqv6Lw
ref: https://zhuanlan.zhihu.com/p/530973109


#TODO

ref: https://hackmd.io/@TRChen/S1DOZOOS6