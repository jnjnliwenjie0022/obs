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
![[Pasted image 20240924140655.png]]

dynamic power = switch power + internal power

|        | Switching Power              | Internal Power                      | Leakage Power  |
| ------ | ---------------------------- | ----------------------------------- | -------------- |
|        | 1/2 \* V\*\*2 * Cout \* Freq | V \*\* Qx * Freq                    | V \* I_leakage |
| Report | Net                          | Cell                                | Cell           |
| Target | Output Pin Power             | Short Power + Internal Switch Power | Leakage Power  |
SDPA: Status Dependency Path Dependency
Cout = input pin capacitation + wire load

|                                               | Switching Power  | Input Pin Internal Power | Output Pin Internal Power | Leakage Power |
| --------------------------------------------- | ---------------- | ------------------------ | ------------------------- | ------------- |
| Target                                        | Output Pin Power | Internal Switch Power    | Short Power               | Leakage Power |
| Status Dependency (Input Value)               | N/A              | Yes                      | Yes                       | Yes           |
| Path Dependency (Input Value -> Output Value) | N/A              | Yes                      | Yes                       | N/A           |
| Wire Load                                     | Yes              | N/A                      | Yes                       | N/A           |
| Input_Transition_Time                         | N/A              | 正比                       | 正比                        | N/A           |
| Output_Capaciance                             | 正比               | N/A                      | 反比                        | N/A           |
| Freq                                          | 正比               | 正比                       | 正比                        | N/A           |
| V                                             | 正比               | 正比                       | 正比                        | 正比            |
| Vth                                           | N/A              | N/A                      | N/A                       | 反比            |





# switch_power

![[Pasted image 20240924133224.png]]