# sdc

![[Pasted image 20240620171703.png]]

place and route前
``` TCL
create_clock -period VALUE [get_ports CLK]
set_clock_uncertainty VALUE CLK
1. 通常只討論jitter: 5%
set_clock_transition VALUE CLK
1. 上升轉換和下降轉換时间(電壓的20%到80%)
2. 通常這個是給backend去填
set_clock_latency -source VALUE CLK
set_clock_latency VALUE CLK
```


place and route後
``` TCL
create_clock -period VALUE [get_ports CLK]
set_clock_uncertainty VALUE CLK
1. 通常只討論jitter: 5%
set_clock_transition VALUE CLK 
set_clock_latency -source VALUE CLK
set_propagated_clock VALUE CLK
```


# wcl

frequency signoff criteria
1. wcl (worse case for low temperature)
2. wc (worse case for high temperature)


for 40nm以下

d = (1/2) μn Cox (W/L) (VGS – VT)2

K 與 μn 成反比(μn是説明電阻特性,溫度越低,電子撞擊原子核的機率下降,所以電流量越高,電阻越低)

K 與 Vth成正比

K在40nm以下會有下圖的特性,worse case for frequency會有兩個corner(High K and Low K)

[[PVT (Process, Voltage, Temperature) - VLSI- Physical Design For Freshers.pdf#page=12&annotation=183R|PVT (Process, Voltage, Temperature) - VLSI- Physical Design For Freshers, page 12]]
![[Pasted image 20240611164733.png]]
