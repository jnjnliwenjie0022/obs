# evalution
可以用execl先做profiler不用一直去systhesis和跑pattern

SRAM
MBIST: 10%
Core Utilization: 75%

Cell
Scan: 15%~25%
Core Utilization: 65%~70%
# sdc

![[Pasted image 20240620171703.png]]

place and route前


![[Pasted image 20240621184044.png]]

index_1 就是 data transition

![[Pasted image 20240621182018.png]]
``` TCL
create_clock -period VALUE [get_ports CLK]
set_clock_uncertainty VALUE CLK
1. clock_period * 0.3
set_clock_transition VALUE CLK
1. 上升轉換和下降轉換时间(電壓的20%到80%)
2. 通常會設定為0
set_clock_latency -source VALUE CLK
set_clock_latency VALUE [all_clocks]

set_max_transition VALUE [get_db designs *]
1. 成熟製成: 0.4~0.2
2. 先進製成：0.1~0.08
3. data transition violate基本上只會高機率發生在soc
4. data transition是為了避免dynamtic power在transition太長導致不必要的增加
5. 可以對clock path和data path作用

set bus_ratio 0.667
set bus_clk_period 1.0
set clock_uncertainty 0.0

set apr_margin [expr $bus_clk_period * 0.3]
set synthesis_margin [expr $clock_uncertainty + $apr_margin]
set bus_io_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]

set 

```

place and route and CTS 後
``` TCL
create_clock -period VALUE [get_ports CLK]
set_clock_uncertainty VALUE CLK
1. clock_period *0.3
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
# synthesis_library
multi-vt
1. lvt: 建議25%以上
2. svt: 建議50%以上, 建議合成的時候只使用svt
3. ulvt: 通常不用ulvt, ulvt會給APR做最後的防守
![[Pasted image 20240625161622.png]]
![[Pasted image 20240625162050.png]]

# analysis
power 分析通常是architecture team分析不會是implemeation team分析
power 分析也需要wire delay 
power 分析要85度/TT/0.75(normal) for 7nm
wcl frequency 分析-40度/multivt/SS/0.75\*0.9 for 7nm
wc frequency 分析85度/multivt/SS/0.75\*0.9 for 7nm