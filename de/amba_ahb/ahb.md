# ref
https://www.arm.com/architecture/system-architectures/amba/amba-specifications
# uarch
![[Pasted image 20240321170457.png]]
## ahb_lite_with_critical_path
![[ahb_lite_w_critical_path.svg]]
## ahb_lite_without_critical_path
使用pending buffer
![[ahb_lite_wo_critical_path.svg]]


[[IHI0033C_amba_ahb_protocol_spec.pdf#page=57&selection=13,1,71,35|IHI0033C_amba_ahb_protocol_spec, page 57]]

master:
1. hready: only control "DATA_PHASE"
2. address phase and data phase之間要使用pipeline
slave:
1. hreadyout: bypass to master
2. hready: only control "DATA_PHASE"
	1.  hready即使為0, address phase也要收transaction
	2.  address phase要使用pending buffer
3. address phase and data phase之間要使用pipeline
bmc_us:
1. address phase need pending buffer
2. address phase and data phase之間要使用pipeline
bmc_ds:
1. hreadyout and hready之間是combination behavior
2. address phase and data phase之間要使用pipeline
brg:
1. address phase要使用pending buffer
2. address phase and data phase之間要使用pipeline
## corner_case
[[IHI0033C_amba_ahb_protocol_spec.pdf#page=18&selection=39,0,44,0|IHI0033C_amba_ahb_protocol_spec, page 18]]
![[Pasted image 20240411162207.png]]
[AHB Bus Protocol -- Address Phase - SoC Design and Simulation forum - Support forums - Arm Community](https://community.arm.com/support-forums/f/soc-design-and-simulation-forum/43735/ahb-bus-protocol----address-phase?ReplySortBy=CreatedDate&ReplySortOrder=Ascending)
![[Pasted image 20240411165735.png]]

結論: hready only control "DATA_PHASE"

<<< 需要舉例子 >>>
<<< hready hreadyout 架構描述 >>>

## address phase for slave

1. hreadyin == 


## data phase for slave


