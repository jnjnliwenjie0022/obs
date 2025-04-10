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
# comment
在业界，**UVM_ML** 和 **UVMC** 都是支持跨语言（SystemVerilog 和其他语言，如 C/C++、SystemC）的验证方法，具体选择取决于项目需求、公司环境和工具链。以下是两者的比较以及在业界的使用趋势：

---

### **1. UVM_ML（UVM Multi-Language）**
#### **特点：**
- **多语言支持：** UVM_ML 是 Accellera 提供的标准实现，旨在通过标准化的接口支持多个语言的协同验证（SystemVerilog、SystemC、C/C++）。
- **扩展性强：** 允许多语言 UVM 环境的直接交互，支持 TLM 1.0 和 TLM 2.0 通信。
- **工具链支持：** UVM_ML 的实现依赖于特定仿真工具的支持，如 Cadence（通过 Xcelium）和 Mentor Graphics（通过 Questa）。

#### **优势：**
- 与标准 UVM 无缝集成，适合已有完整 UVM 环境的团队。
- 原生支持 UVM 的多语言扩展。
- 提供标准化的 API，未来维护成本低。

#### **劣势：**
- 对仿真工具的依赖较强，某些仿真器可能不支持完整功能。
- 配置和调试相对复杂，需要团队成员对多语言环境有深刻理解。

---

### **2. UVMC（UVM Co-Emulation Library）**
#### **特点：**
- **针对硬件建模的跨语言接口：** UVMC 是 OSCI（SystemC 标准委员会）提供的跨语言解决方案，重点在于将 SystemVerilog 和 SystemC 模型连接。
- **轻量级实现：** 通过简单的 `uvmc_connect` 和 `uvmc_xxx` API，方便快速建立 SystemC 和 SystemVerilog 之间的 TLM 通道。
- **工具独立性：** 相较于 UVM_ML，UVMC 更加通用，适配多个仿真器，包括 Cadence、Mentor 和 Synopsys。

#### **优势：**
- 易于部署，工具链适配范围广。
- 对于需要将 SystemC 模块（如 Virtual Platform 或 SoC 模型）与 UVM 测试平台集成的场景，UVMC 是理想选择。
- 代码简单直观，调试成本低。

#### **劣势：**
- 与标准 UVM 的集成程度不如 UVM_ML。
- 功能相对简单，可能无法满足复杂的多语言通信需求。

---

### **业界使用趋势**
1. **UVM_ML 的使用场景：**
   - UVM_ML 更适合已经建立 UVM 环境，并且需要多语言协同的项目（例如联合使用 SystemVerilog 和 SystemC）。
   - 大型企业（如英特尔、AMD 等）倾向于使用 UVM_ML，因为他们的验证环境复杂且依赖工具的高度优化支持。
   - 如果验证团队对工具链优化和 Accellera 的长期支持非常依赖，UVM_ML 是首选。

2. **UVMC 的使用场景：**
   - UVMC 在需要快速整合 SystemC 模块的验证环境中非常流行，尤其是在中小型项目和轻量级验证需求下。
   - 对于需要跨仿真器的灵活性（如从 ModelSim 切换到 VCS），UVMC 提供了更好的兼容性。
   - 虽然 UVMC 是 OSCI 提供的“非标准化实现”，但其简单性使其在验证团队中得到较多使用。

---

### **业界使用比例**
- **UVM_ML** 在高端验证环境中更受欢迎（特别是大型 SoC/ASIC 项目），因为其功能全面、与 UVM 紧密集成。
- **UVMC** 在中小型项目和需要快速验证的环境中更为常见，特别是当 SystemC 被用于系统级建模时。

---

### **总结建议**
- 如果你的团队已经在使用完整的 UVM 测试平台并希望扩展到多语言验证，**UVM_ML 是更好的选择**。
- 如果你的团队更注重工具链灵活性或需要快速连接 SystemC 和 UVM 环境，**UVMC 会更适合**。

**最终选择可以基于以下因素：**
- **工具链支持：** 现有环境是否支持 UVM_ML？
- **项目规模：** 项目复杂度是否需要多语言深度集成？
- **团队技术水平：** 团队是否熟悉 SystemC 和多语言验证框架？

如果你能提供更具体的使用场景或需求，我可以给出更精准的建议！