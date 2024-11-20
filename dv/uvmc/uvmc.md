# setting
download tool_kit

[UVMC | Siemens Verification Academy](https://verificationacademy.com/topics/uvm-universal-verification-methodology/uvmc/)
```
vim uvmc.bashrc
	[[uvm-connect-2.3.3-primer-guide-verification-academy.pdf#page=16&selection=9,8,9,17|uvm-connect-2.3.3-primer-guide-verification-academy, page 16]]
	setenv UVM_HOME /home/project/eda/pkgs/cadence/ius/default/tools/methodology/UVM/CDNS-1.2/sv
	setenv IUS_HOME /home/project/eda/pkgs/cadence/ius/default
	setenv UVMC_HOME /NOBACKUP/atcpcw10/jasonli/sc/uvmc-2.3.3 # lib_src
	setenv UVM_LIB $UVMC_HOME/lib/uvmc_lib  # lib_src will distribute the library to here
	setenv UVMC_LIB $UVMC_HOME/lib/uvmc_lib # lib_src will distribute the library to here
source uvmc.bashrc
cd $UVMC_HOME/examples/connections
vim Makefile.ius
	[UVM Version Defines (verificationacademy.com)](https://verificationacademy.com/verification-methodology-reference/uvm/docs_1.2/html/files/macros/uvm_version_defines-svh.html)
	  +define+UVM_NO_DPI \
	  +define+UVM_FIX_REV="undefined" \
make -f Makefile.ius sc2sv
```
# ref
[Transaction-level riending - ppt download (slideplayer.com)](https://slideplayer.com/slide/12988254/)

https://sistenix.com/basic_uvmc.html
# concept
sv2sv
1. 使用TLM1.0
	
sc2sc
1. 使用TLM2.0
	
sc2sv or sv2sc on co-sim
1. 使用TLM2.0 socket
2. user-defined packet
3. generic payload

sc2sv or sv2sc on verify or modeling
1. 使用TLM1.0 
2. user-defined packet
3. generic payload
# converter

converter的需要主要是實作user_packet

![[Pasted image 20240509010353.png]]
# tlm1_user_packet
[TLM-2.0: tlm_core/tlm_1/tlm_req_rsp/tlm_1_interfaces/tlm_core_ifs.h Source File (eda-playground.readthedocs.io)](https://eda-playground.readthedocs.io/en/latest/_static/systemc-2.3.1/tlm/a00104_source.html)

[A basic tutorial of UVM Connect (sistenix.com)](https://sistenix.com/basic_uvmc.html)

```
cd $UVMC_HOME/examples
source /uvmc.bashrc
cd to tlm1_user_packet
make -f Makefile.ius sc2systemv
```
![[ac_tlm1_user_packet.svg]]
# tlm2_gp
[Generic Payload in TLM 2.0 - VLSI Verify](https://vlsiverify.com/uvm/tlm/generic-payload-in-tlm-2-0/)

[SystemC: 月球轉運站 - iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天 (ithome.com.tw)](https://ithelp.ithome.com.tw/articles/10266996)

[SystemC Study_system c payload-CSDN博客](https://blog.csdn.net/ocarvb/article/details/111227196)

[Slide 1 (uci.edu)](https://newport.eecs.uci.edu/~doemer/w19_eecs222/Lecture19_SystemC_Part3.pdf)

[UVM——TLM2通信-CSDN博客](https://blog.csdn.net/weixin_42482170/article/details/123574743)
```
cd $UVMC_HOME/examples
source /uvmc.bashrc
cd to tlm2_gp
make -f Makefile.ius sv2sc
```
![[ac_tlm2_gp.svg]]
![[Pasted image 20240509010048.png]]
# tlm2_user_packet
```
cd $UVMC_HOME/examples
source /uvmc.bashrc
cd to tlm2_user_packet
make -f Makefile.ius sc2systemv
```
![[ac_tlm2_user_packet.svg]]