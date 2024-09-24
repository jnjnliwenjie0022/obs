# ref
https://accelergy.mit.edu/

https://www.youtube.com/watch?v=dK66mV6RU5Q

https://www.youtube.com/watch?v=2zm_HPKM0-E

https://mlsysbook.ai/contents/hw_acceleration/hw_acceleration.html
# dennard_scaling

![[Pasted image 20240826141554.png]]

[[Domain-Specific Architecture AI for Future Tech.pdf#page=2&selection=2,0,2,36|Domain-Specific Architecture AI for Future Tech, page 2]]
![[Pasted image 20240826163637.png]]
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

![[Pasted image 20240827105334.png]]
# power_analysis

dynamic power = switch power + internal power

|      | Switching Power              | Internal Power   | Leakage Power  |
| ---- | ---------------------------- | ---------------- | -------------- |
|      | 1/2 \* V\*\*2 * Cout \* Freq | V \*\* Qx * Freq | V \* I_leakage |
| Freq |                              |                  |                |
| Volt |                              |                  |                |
|      |                              |                  |                |
|      |                              |                  |                |
|      |                              |                  |                |
|      |                              |                  |                |

Cout = input pin capacitation + wire load

# switch_power

![[Pasted image 20240924133224.png]]