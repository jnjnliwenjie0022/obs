# concept

- ref: https://hackmd.io/@TRChen/S1DOZOOS6
- CDC 設計原則遵守
	- sender data path output 必須是 register
		- data path 的 delay 必須小於 control path 的 delay
		- APR前: 因爲 control path input 必有 syncer, 所以 data path 必然比 control path 的 delay 小
		- APR後: data path output 和 control path output 在 routing 上的 delay 需要一致
	- sender control path output 必須是 register
		- 改善 MTBF
	- receiver control path input 必須有 syncer
		- 解決 metastable state
	- receiver control path input 如果是 pulse 信號, 必須轉成 level 信號
	- receiver control path input 的 syncer 必須是 2 stages 以上
# phase_handshake

- ref: https://aijishu.com/a/1060000000200711
- 4 phase handshake
	- ![[Ultra Low Cost Asynchronous Handshake Checker.pdf#page=2&rect=55,107,295,183|Ultra Low Cost Asynchronous Handshake Checker, p.2|500]]
	- 必須有4個 phase
	- req == 1 && ack == 0 的時候資料合法
	- req == 1 && ack == 1 的時候資料合法
	- req == 0 && ack == 1 的時候資料不合法
	- req == 0 && ack == 0 的時候資料不合法
	- 不易發生deadlock
	- ![[Pasted image 20251210150354.png]]
- 2 phase handshake (不推薦, 所以 AMBA P/Q-Channel 才採用 4 phase handshake)
	- ![[Ultra Low Cost Asynchronous Handshake Checker.pdf#page=2&rect=54,86,294,163|Ultra Low Cost Asynchronous Handshake Checker, p.2|500]]
	- 必須有2個phase
	- req ^ ack 的時候資料合法
	- req == ack 的時候資料不合法
	- 容易發生 deadlock
		- rdc (sender.req = 1 發送後, receiver.req = 1, 但 sender 被 reset, 導致雙方都在等待 toggle)
		- ![[Pasted image 20251210150334.png]]
		- 環形 deadlock (A等待B, B等待C, C等待A)
```json
{ signal: [
  { name: 'req',               wave: 'LH.L.H.L..' },
  { name: 'ack',               wave: 'L.H.L.H.L.' },
  { name: 'cs',                wave: 'x.3x......', data:['reset']},
  { name: '2phase',            wave: 'x==x......', data:['valid','valid']},
  { name: '2phase.sender.req', wave: 'LHL.......' },
  { name: '2phase.sender.ack', wave: 'L.HL......' },
  { name: 'req',               wave: 'LH.L.H.L..' },
  { name: 'ack',               wave: 'L.H.L.H.L.' },
  { name: 'cs',                wave: 'x.3x......', data:['reset']},
  { name: '4phase',            wave: 'x.........' },
  { name: '4phase.sender.req', wave: 'LHL.......' },
  { name: '4phase.sender.ack', wave: 'L.........' },
]}
```
- valid ready handshake
	- ref: https://fpgacpu.ca/fpga/handshake.html
	- deadlock
		- sender 的 valid 不能 depend on ready
	- livelock
		- sender 和 receiver 要確切執行 handshake, 以 valid-ready handshake 爲例子, sender 和 receiver 都必須確實出現 valid == 1 && ready == 1

# handshake_with_clk

- pulse signal to level signal then level signal to pulse signal
- ![[Pasted image 20251115202803.png|1000]]