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
# mos

- ref: https://semiwiki.com/semiconductor-manufacturers/tsmc/300552-vlsi-technology-forum-short-course-logic-devices/

# wire_rc

- ref: https://www.deepchip.com/items/0582-01.html

|                                  | N90  | N65 | N45 | N28  | N20   | N16 | N10 | N7     |
| -------------------------------- | ---- | --- | --- | ---- | ----- | --- | --- | ------ |
| Wire RC Delay / Transistor Delay | 100  |     |     | 1000 | 10000 |     |     | 100000 |
| Wire RC Delay的重視度                | RC輕度 |     |     | RC中度 | RC重度  |     |     | RC嚴重   |

# congestion
## m2p_congestion

- ref: https://ivlsi.com/pitch-spacing-offset-vlsi-physical-design/
	- pitch: The distance between the center to center of the metal is called as pitch. In the below picture, B is pitch.
	- spacing: Spacing is the distance between the edge to edge metal layers. The distance A is spacing in below picture.
	- offset: Offset is the distance between the core and first metal layer. In below picture, C is offset.

- Max_Wire on one side assumed floorplan is square and only use metal2 layer: ((KGate_Count \* Gate_Factor) \^ 1/2) \/ M2P
- Max_Wire = Max_Wire for one side * (1 or 2 or 3 or 4)
- Design_Wire only use metal2 layer: Total_Wire
- Compare Max_Wire and Design_Wire

![[Pasted image 20250919153321.png|500]]

## rtla_congestion

- 左邊的Overflow要符合 Genus Congestion Criteria
	- Genus標準是小於10,000
- 左邊的Overflow要符合 Synopsys Criteria
	- Overflow Max < 10是Low Congestion
	- 10 <= Overflow Max < 15是moderate Congestion
	- Overflow Max >= 15是High Congestion
- 右邊的Overflow要符合 Synopsys Criteria
	- GRC% < 1%是Low Congestion
	- 1% < GRC% < 5%是moderate Congestion
	- GRC% > 5%是High Congestion
- 需要搭配看Congestion Map
	
![[Pasted image 20250923100859.png]]

# power

![[Pasted image 20250919180034.png|500]]

# apr_uncertainty


|                         | Synthesis                    | Floorplan                        | Pre-CTS            | CTS                            | Post-CTS           | Routing                         | Post-Route                      | Signoff |
| ----------------------- | ---------------------------- | -------------------------------- | ------------------ | ------------------------------ | ------------------ | ------------------------------- | ------------------------------- | ------- |
| uncertainty             | Period \* 30%<br>(EX: 300ps) | Same as Synthesis<br>(EX: 300ps) | 1/2<br>(EX: 150ps) | Same as Pre-CTS<br>(EX: 150ps) | 2/3<br>(EX: 100ps) | Same as Post-CTS<br>(EX: 100ps) | Same as Post-CTS<br>(EX: 100ps) |         |
| uncertainty information | skew+margin                  | skew+margin                      | skew+margin        | skew+margin                    | margin             | margin                          | margin                          |         |
| information             | N/A                          | N/A                              | N/A                | N/A                            | skew               | skew                            | skew, RC                        |         |
