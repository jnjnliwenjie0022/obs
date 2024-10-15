## uarch
![[Pasted image 20240321170457.png]]
## ahb_lite_with_critical_path
![[ahb_lite_w_critical_path.svg]]
## ahb_lite_without_critical_path
使用pending buffer
![[ahb_lite_wo_critical_path.svg]]


[[IHI0033C_amba_ahb_protocol_spec.pdf#page=57&selection=13,1,71,35|IHI0033C_amba_ahb_protocol_spec, page 57]]

master:
1. hready: only control "DATA_PHASE"
slave:
1. hreadyout: bypass to master
2. hready: only control "DATA_PHASE"
bmc_us:
bmc_ds:
## corner_case
[[IHI0033C_amba_ahb_protocol_spec.pdf#page=18&selection=39,0,44,0|IHI0033C_amba_ahb_protocol_spec, page 18]]
![[Pasted image 20240411162207.png]]
[AHB Bus Protocol -- Address Phase - SoC Design and Simulation forum - Support forums - Arm Community](https://community.arm.com/support-forums/f/soc-design-and-simulation-forum/43735/ahb-bus-protocol----address-phase?ReplySortBy=CreatedDate&ReplySortOrder=Ascending)
![[Pasted image 20240411165735.png]]

