# concept

- ref: https://semiwiki.com/semiconductor-manufacturers/tsmc/300552-vlsi-technology-forum-short-course-logic-devices/
	- MOS Layout

![[Pasted image 20250919143906.png|500]]

![[Pasted image 20250919153454.png|500]]
- tcbn28hpcplusbwp30p140ssg0p81vm40c
	- 28hpcplus: TSMC 28nm HPC+
	- bwp: well type / power domain (bwp = bulk well process)
	- 9t: 沒寫就是標準的9t
	- 30: gate length
	- P140: poly pitch
	- ssg: ss表示nmos和pmos，g表示全域最糟（包含溫度和電壓）
	- 0p81v: 0.81 Volt
	- m40c: -40c
- temn28hpcphssrammacros
# wire_load

- ref: https://www.deepchip.com/items/0582-01.html

|                                  | N90  | N65 | N45 | N28  | N20   | N16 | N10 | N7     |
| -------------------------------- | ---- | --- | --- | ---- | ----- | --- | --- | ------ |
| Wire RC Delay / Transistor Delay | 100  |     |     | 1000 | 10000 |     |     | 100000 |
| Wire RC Delay的重視度                | RC輕度 |     |     | RC中度 | RC重度  |     |     | RC嚴重   |

# uncertainty

|                         | Synthesis                    | Floorplan                        | Pre-CTS            | CTS                            | Post-CTS           | Routing                         | Post-Route                      | Signoff |
| ----------------------- | ---------------------------- | -------------------------------- | ------------------ | ------------------------------ | ------------------ | ------------------------------- | ------------------------------- | ------- |
| uncertainty             | Period \* 30%<br>(EX: 300ps) | Same as Synthesis<br>(EX: 300ps) | 1/2<br>(EX: 150ps) | Same as Pre-CTS<br>(EX: 150ps) | 2/3<br>(EX: 100ps) | Same as Post-CTS<br>(EX: 100ps) | Same as Post-CTS<br>(EX: 100ps) |         |
| uncertainty information | skew+margin                  | skew+margin                      | skew+margin        | skew+margin                    | margin             | margin                          | margin                          |         |
| information             | N/A                          | N/A                              | N/A                | N/A                            | skew               | skew                            | skew, RC                        |         |

# congestion

# high_fanin_cell

- ref: https://blog.csdn.net/LogicYarn/article/details/149078684
- AOI
	- ![[Pasted image 20251209135504.png|500]]
	- 優點: Low Latency
	- 缺點: high fanin

## m2p_congestion

- ref: https://ivlsi.com/pitch-spacing-offset-vlsi-physical-design/
	- pitch: The distance between the center to center of the metal is called as pitch. In the below picture, B is pitch.
	- spacing: Spacing is the distance between the edge to edge metal layers. The distance A is spacing in below picture.
	- offset: Offset is the distance between the core and first metal layer. In below picture, C is offset.

- Max_Wire on one side assumed floorplan is square and only use metal2 layer: ((KGate_Count \* Gate_Factor) \^ 1/2) \/ M2P
	- ![[Pasted image 20250919153321.png|500]]
- Max_Wire = Max_Wire for one side * (1 or 2 or 3 or 4)
- Design_Wire only use metal2 layer: Total_Wire
- Compare Max_Wire and Design_Wire

## rtla_congestion

- 右邊的Overflow要符合 Synopsys Criteria
	- GRC% < 1%是Low Congestion
	- 1% < GRC% < 5%是moderate Congestion
	- GRC% > 5%是High Congestion
- 需要搭配看Congestion Map
	
![[Pasted image 20250923100859.png]]
![[Pasted image 20250923140119.png]]


# routing_flow

- ref: https://blog.csdn.net/weixin_37584728/article/details/116529950?spm=1001.2101.3001.4242.2&utm_relevant_index=3
- global route -> track assignment -> detail route

# global_routing_cell

- ref: https://blog.csdn.net/sinat_41774721/article/details/123430167
- GRC(Global Routing Cell / Gcell)
	- 在LEF或是Floorplan的DEF中
	- GCELLGRID X Start DO numColumnsRows+1 STEP Space;
		- X: 表示V還是H
		- Start: 表示第一個grid的位置
		- numColumnsRows+1: 表示grid的數量
		- Space: gird之間的間距

![[Pasted image 20250924163225.png]]
## global_route

- global route 的 granularity 是以 Gcell 為單位，佈綫軌道（track）沒有實際被實作，僅僅描述經過哪一個 Gcell

- input: 
	- cell and macro placement
	- routing channel capacity pre layer
- output:
	- coarse gird routing through global routing cells (GRCs)
	- congestion map through global routing cells
- detail step:
	- assign nets to specific metal layers and global routing cells (Gcells)
	- ties to avoid congested Gcells while minimizing detours
	- ties to avoid P/G (rings/straps/rails) and routing blockages

## track_assignment

- detail step:
	- assign actual metal
	- ties to make long and straight metal
	- ties to reduce via  

## detail_route

- detail step:
	- solve DRC and rerouting, rerouting by using sbox
	- solve short and rerouting, rerouting by using sbox

![[Pasted image 20250924180053.png]]



# power_mesh

![[Pasted image 20250919180034.png|500]]


