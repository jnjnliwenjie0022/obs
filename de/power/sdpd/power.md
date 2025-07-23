# ref
https://accelergy.mit.edu/

https://www.youtube.com/watch?v=dK66mV6RU5Q

https://www.youtube.com/watch?v=2zm_HPKM0-E

https://mlsysbook.ai/contents/hw_acceleration/hw_acceleration.html
# dennard_scaling

![[Pasted image 20240826141554.png]]

[[Domain-Specific Architecture AI for Future Tech.pdf#page=2&selection=2,0,2,36|Domain-Specific Architecture AI for Future Tech, page 2]]

![[Pasted image 20240924220253.png]]
# dennard_scaling_with_cpu

P 正比 nCV\*\*2Freq
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

library 中的internal_power 不是功率，而是熱量，單位是焦耳，因此有負數

先進製成 Internal Power >= Switch Power (P=1/2CV \*\* 2Freq)

P.S: Internal Power只能查表，先進製成無法滿足 P=1/2CV \*\* 2Freq

先進製成 Leakage Power無法忽視

P.S: Leakage Power只能查表

![[Pasted image 20240924140655.png]]

dynamic power = switch power + internal power

|        | Switching Power            | Internal Power                                                                       | Leakage Power                              |
| ------ | -------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------ |
|        | 1/2 \* V\*\*2 * Cout \* Tr | V \* Qx * Tr<br>F_LUT(Input_Transition_Time, Status Dependency, Output_Capacitation) | V \* I_leakage<br>F_LUT(Status Dependency) |
| Report | Net                        | Cell                                                                                 | Cell                                       |
| Target | Output Pin Power           | Short Power + Internal Switch Power                                                  | Leakage Power                              |
SDPA: Status Dependency Path Dependency

Cout = Pin capacitation + wire load

Qx = 瞬間短路時間 \*  瞬間短路電流

|                                               | Switching Power  | Input Pin Internal Power | Output Pin Internal Power | Leakage Power |
| --------------------------------------------- | ---------------- | ------------------------ | ------------------------- | ------------- |
| Status Dependency (Input Value)               | N/A              | Yes                      | Yes                       | Yes           |
| Path Dependency (Input Value -> Output Value) | N/A              | Yes                      | Yes                       | N/A           |
| Wire Load                                     | Yes              | N/A                      | Yes                       | N/A           |
| Input_Transition_Time (input訊號轉換時間)           | N/A              | 正比 **(先進製成非綫性)**         | 正比 **(先進製成非綫性)**          | N/A           |
| Output_Capacitation                           | 正比               | N/A                      | 反比 **(先進製成非綫性)**          | N/A           |
| Tr                                            | 正比(0->1 or 1->1) | 正比                       | 正比                        | N/A           |
| V                                             | 正比               | 正比                       | 正比                        | 正比            |
| Vth                                           | N/A              | N/A                      | N/A                       | 反比            |

**重要結論: 先進製成的Internal Power > Switching Power, 但先進製成的Internal Power非綫性, 使得Dynamic Power無法預測**

Tr(翻轉率): Toggle_Rate * Freq

![[Pasted image 20240924160623.png]]

## leakage_power

**
1. Sub-threshold Leakage Current(ISUB):當MOS處於關閉狀態時, MOS Drain跟Source之間的漏電流,ISUB主導靜態功率消耗
2. 與pattern（Status Dependency）有關，但實際應用差異不大，可以視爲無關，誤差為1%

![[Pasted image 20240924153311.png]]

Static Power在65nm之後占比大幅度上升

![[Pasted image 20240925115502.png]]

W/area 越來越高,且Leakage Power在65nm之後占比大幅度上升

![[Pasted image 20240925115734.png]]

實際看TSMC,除了5nm例外意外其他都符合預期

![[Pasted image 20240925143438.png]]

## internal_power

input pin internal power (internal switch power)

![[Pasted image 20240924154029.png]]

output pin internal power (short power)



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

![[Pasted image 20240924221233.png]]
# power_gating

![[Pasted image 20240924221249.png]]

# architecture_level_power_evaluation

## prerequisite

Summary
1. Logic power 與 pattern 有絕對的關係(有22%誤差)
	1. random mult
	2. reused mult
	3. gated mult
2. Memory power 與 pattern 的關係比較無關(有3%誤差)
3. Memory power 必須獨立分析(有66%誤差)
	1. random read
	2. repeated read
	3. random write
	4. repeated write
	5. constant data write

60%Data為0

![[Pasted image 20240925185456.png]]

0% Data為0

![[Pasted image 20240925185041.png]]

[[slides.pdf#page=37&selection=2,0,4,29|slides, page 37]]

![[Pasted image 20240926110143.png]]

## ddr_power
![[Pasted image 20241209165553.png]]


