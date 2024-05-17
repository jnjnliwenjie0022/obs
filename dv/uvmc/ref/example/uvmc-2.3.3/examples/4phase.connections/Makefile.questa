# ============================================================================
#  @(#) $Id: Makefile.questa 1972 2021-05-20 10:17:03Z markma $
# ============================================================================

#//-----------------------------------------------------------//
#//   Copyright 2021 Siemens EDA                              //
#//                                                           //
#//   Licensed under the Apache License, Version 2.0 (the     //
#//   "License"); you may not use this file except in         //
#//   compliance with the License.  You may obtain a copy of  //
#//   the License at                                          //
#//                                                           //
#//       http://www.apache.org/licenses/LICENSE-2.0          //
#//                                                           //
#//   Unless required by applicable law or agreed to in       //
#//   writing, software distributed under the License is      //
#//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR  //
#//   CONDITIONS OF ANY KIND, either express or implied.      //
#//   See the License for the specific language governing     //
#//   permissions and limitations under the License.          //
#//-----------------------------------------------------------//

include common.mk

VSIM_EXTRA ?=

include $(UVMC_HOME)/examples/common/Makefile.questa

CFLAGS= -g -DDEBUG

CHECK_TESTS=$(TESTS:%=check.%)

all: sim check clean

sim: $(TESTS)
check: $(CHECK_TESTS)

#-----------------------------------------------------------------------------

sc2sv2sc_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using original uvmc_converter's ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common $@.sv
	$(SCCOM) $(CFLAGS) -Icommon \
		-DNUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		-DPAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.cpp
	$(LINK)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

sv2sc2sv_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using original
	# uvmc_converter's ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common \
		+define+NUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		+define+PAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.sv
	$(SCCOM) $(CFLAGS) -Icommon $@.cpp
	$(LINK)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

#-----------------------------------------------------------------------------

sc2sv2sc_gp_converter_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using XLerated
	# uvmc_tlm_gp_converter's ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common $@.sv
	$(SCCOM) $(CFLAGS) -Icommon \
		-DNUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		-DPAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.cpp
	$(LINK) $(CFLAGS)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

sv2sc2sv_gp_converter_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using XLerated
	# uvmc_tlm_gp_converter's ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common \
		+define+NUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		+define+PAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.sv
	$(SCCOM) $(CFLAGS) -Icommon $@.cpp
	$(LINK) $(CFLAGS)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

#-----------------------------------------------------------------------------

sc2sv2sc_xl_gp_converter_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using XLerated uvmc_xl_converters ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common $@.sv
	$(SCCOM) $(CFLAGS) -Icommon \
		-DNUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		-DPAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.cpp
	$(LINK) $(CFLAGS)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

sv2sc2sv_xl_gp_converter_loopback: check_uvm_home
	# Benchmark 128 2048 byte payloads using XLerated uvmc_xl_converters ...
	-rm -rf work
	vlib work
	$(VLOG) +incdir+common \
		+define+NUM_TRANSACTIONS=$(NUM_LIMITED_TRANSACTIONS) \
		+define+PAYLOAD_NUM_BYTES=$(LIMITED_PAYLOAD_NUM_BYTES) \
		$@.sv
	$(SCCOM) $(CFLAGS) -Icommon $@.cpp
	$(LINK) $(CFLAGS)
	time $(VSIM) sc_main sv_main +UVMC_COMMAND_TRACE
	mv $(LOG).log check.$@.log

#-----------------------------------------------------------------------------

$(CHECK_TESTS):
	cat $@.log | \
			grep -v "^# \[UVM\/COMP\/NAME\]" | \
			grep -v "\[UVM\/REPORT\/CATCHER\]" | \
			grep -v "\[UVM\/REPORT\/SERVER\]" | \
			grep -v "UVM\/RELNOTES" | \
			grep -v "violates the uvm component name constraints" | \
			grep -iv "Time:" | \
			grep -v "^# $$" | \
		perl gold/check.pl > $@.log.cmp
	cmp $@.log.cmp gold/$@.log.cmp

clean:
	rm -rf work *.log vsim* transcript *.vstf *.log.cmp modelsim.ini
