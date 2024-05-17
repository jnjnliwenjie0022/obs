# uarch
## overall_uarch
![[axi4.0.svg]]
![[axi4.0_detail.svg]]
## us_ar_addr
preload_pipeline_with_single_pending_buffer_with_multi_slave
![[3_preload_pipeline_with_single_pending_buffer_with_multi_slave.svg]]

us_ar_addr_include_outstanding
![[4_us_ar_addr_include_outstanding_solution.svg]]

## ds_addr
ds_addr_ctrl
![[5_ds_addr_ctrl.svg]]

## us_resp
us_resp_include_outstanding
![[6_us_resp_include_outstanding_solution.svg]]

## ds_rdata
ds_rdata_include_outstanding
![[7_ds_rdata_include_outstanding_solution.svg]]

## us_wdata
us_wdata_include_outstanding
![[10_us_wdata_include_outstanding_solution.svg]]

# error_behavior
ar_r_err_behavior
![[us_ar_r_err_behavior.svg]]
aw_w_b_err_behavior
![[us_aw_w_b_err_behavior.svg]]
error_pending
![[error_pending.svg]]

# exclusive_behavior

ref:
exclusive access in BMC
https://bbs.eetop.cn/thread-923098-1-1.html?fbclid=IwAR0n5pmD01L5UIDdeHdigGhNeux3bNAdUu5_wvt2or_T-C6JvUiTQzMMKa8
exclusive access in SW and HW excluding BMC
[深入理解AMBA总线（十六）AXI设计的关键问题（一）-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/1303336)
[深入理解AMBA总线（十三）AXI原子访问机制和AXI响应 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/642172790)
