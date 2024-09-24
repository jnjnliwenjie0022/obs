# ref
https://accelergy.mit.edu/

https://www.youtube.com/watch?v=dK66mV6RU5Q

https://www.youtube.com/watch?v=2zm_HPKM0-E

https://mlsysbook.ai/contents/hw_acceleration/hw_acceleration.html
# dennard_scaling

![[Pasted image 20240826141554.png]]

[[Domain-Specific Architecture AI for Future Tech.pdf#page=2&selection=2,0,2,36|Domain-Specific Architecture AI for Future Tech, page 2]]
# dennard_scaling_with_cpu

P 正比 nCV\*\*2f
1. n：電晶體數量
2. C：每個電晶體的電容量
3. V：電壓很難低於0.6，MTK在sleep mode大概可以是0.55
4. F：頻率基本上在4GHz是極限
5. P：會撞上Power Wall，無法再增加Power

| CPU Component | Old Fabrication Processes | Advanced Fabrication Processes |
| ------------- | ------------------------- | ------------------------------ |
| n             | 1                         | 1.4 ~= 1/0.7                   |
| S             | 1                         | 1.4                            |
| C             | 1                         | 1/1.4 ~= 0.7                   |
| V             | 1                         | 1                              |
| F             | 1                         | 1                              |
| P             | 1                         | 1 = n * 0.7 which n ~= 1.4     |

![[Pasted image 20240924220150.png]]
# power_analysis

## ref
https://blog.csdn.net/i_chip_backend/article/details/90347161

https://blog.csdn.net/i_chip_backend/article/details/118963247

https://blog.csdn.net/i_chip_backend/article/details/118303553

https://blog.csdn.net/qq_21842097/article/details/88420050?spm=1001.2014.3001.5502

https://hackmd.io/@derek8955/B1ur7Ibbo
## concept

https://www.cnblogs.com/lelin/p/11412133.html

library 中的internal_power 不是功率，而是熱量，單位是焦耳

Internal Power >= Switch Power

![[Pasted image 20240924140655.png]]

dynamic power = switch power + internal power

|        | Switching Power            | Internal Power                                                                       | Leakage Power  |
| ------ | -------------------------- | ------------------------------------------------------------------------------------ | -------------- |
|        | 1/2 \* V\*\*2 * Cout \* Tr | V \* Qx * Tr<br>F_LUT(Input_Transition_Time, Status Dependency, Output_Capacitation) | V \* I_leakage |
| Report | Net                        | Cell                                                                                 | Cell           |
| Target | Output Pin Power           | Short Power + Internal Switch Power                                                  | Leakage Power  |
SDPA: Status Dependency Path Dependency

Cout = Pin capacitation + wire load

Qx = 瞬間短路時間 \*  瞬間短路電流

|                                               | Switching Power  | Input Pin Internal Power | Output Pin Internal Power | Leakage Power |
| --------------------------------------------- | ---------------- | ------------------------ | ------------------------- | ------------- |
| Target                                        | Output Pin Power | Internal Switch Power    | Short Power               | Leakage Power |
| Status Dependency (Input Value)               | N/A              | Yes                      | Yes                       | Yes           |
| Path Dependency (Input Value -> Output Value) | N/A              | Yes                      | Yes                       | N/A           |
| Wire Load                                     | Yes              | N/A                      | Yes                       | N/A           |
| Input_Transition_Time                         | N/A              | 正比                       | 正比                        | N/A           |
| Output_Capacitation                           | 正比               | N/A                      | 反比                        | N/A           |
| Tr                                            | 正比               | 正比                       | 正比                        | N/A           |
| V                                             | 正比               | 正比                       | 正比                        | 正比            |
| Vth                                           | N/A              | N/A                      | N/A                       | 反比            |

Tr(翻轉率): Toggle_Rate * Freq

![[Pasted image 20240924160623.png]]

## leakage_power

1. 與pattern（Status Dependency）有關

![[Pasted image 20240924153311.png]]

![[Pasted image 20240924153719.png]]

![[Pasted image 20240924164604.png]]
## internal_power

input pin internal power (internal switch power)

![[Pasted image 20240924154029.png]]

output pin internal (short power)

![[Pasted image 20240924154212.png]]
## switch_power

![[Pasted image 20240924133224.png]]

## dc_power_analysis
![[Pasted image 20240924155659.png]]

# clock_gating

![[Pasted image 20240924164530.png]]

1. 優化 dynamic power
2. 優化 area, 將原有的 data 的通用邏輯整合挂到EN上
3. 有機率劣化 leakage power

