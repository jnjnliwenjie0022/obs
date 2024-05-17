#
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

TESTS = \
    config \
    reporting \
    factory \
    topology \
    phasing

UVMC_HOME ?= ../..

MAKE_CMD = $(MAKE) -f Makefile.questa

TRACE_OPT=
ifdef TRACE
TRACE_OPT=+UVMC_COMMAND_TRACE
endif

help:
	@echo " -----------------------------------------------------------------";
	@echo "|                     UVM COMMAND EXAMPLES                        |";
	@echo " -----------------------------------------------------------------";
	@echo "|                                                                 |";
	@echo "| Usage:                                                          |";
	@echo "|                                                                 |";
	@echo "|   make [UVM_HOME=path] [UVMC_HOME=path] [TRACE=1] <example>     |";
	@echo "|                                                                 |";
	@echo "| where <example> is one of                                       |";
	@echo "|                                                                 |";
	@echo "|   go_nogo   : quick "go/no-go" test that just runs one basic    |";
	@echo "|               test by executing local 'run_questa' script to    |";
	@echo "|               demonstrate the full flow of building a UVMC      |";
	@echo "|               library to the local 'work' lib then running a    |";
	@echo "|               a single test. See comments in 'run_questa'.      |";
	@echo "|                                                                 |";
	@echo "|   config    : shows usage of the UVMC set/get config API        |";
	@echo "|                                                                 |";
	@echo "|   reporting : shows how to issue and filter UVM standard        |";
	@echo "|               reports                                           |";
	@echo "|                                                                 |";
	@echo "|   factory   : shows how to set type and instance overrides and  |";
	@echo "|               dump factory state and perform factory debug      |";
	@echo "|                                                                 |";
	@echo "|   topology  : illustrates how (and when) to dump UVM topology   |";
	@echo "|                                                                 |";
	@echo "|   phasing   : show how SC can wait for any UVM phase state      |";
	@echo "|               and raise/drop objections to control their        |";
	@echo "|               progression                                       |";
	@echo "|                                                                 |";
	@echo "| UVM_HOME and UVMC_HOME, if specified, will override any         |";
	@echo "| environment variables by the same name. If the UVM_HOME env     |";
	@echo "| variable is not defined, you must specify UVM_HOME on the       |";
	@echo "| command line. If you are running these examples outside the     |";
	@echo "| the UVMC directory tree you must either define the UVMC_HOME    |";
	@echo "| environment variable or specify UVMC_HOME on the command line.  |";
	@echo "|                                                                 |";
	@echo "| If TRACE=1 is used, UVM command tracing is enabled (try it!)    |";
	@echo "|                                                                 |";
	@echo "| Other options:                                                  |";
	@echo "|                                                                 |";
	@echo "|   all   : Run all examples after cleaning.                      |";
	@echo "|   clean : Remove simulation files and directories               |";
	@echo "|   help  : Print this help information                           |";
	@echo "|                                                                 |";
	@echo "|                                                                 |";
	@echo " -----------------------------------------------------------------";

include $(UVMC_HOME)/examples/common/Makefile.questa

CHECK_TESTS=$(TESTS:%=check.%)

all: sim check clean

sim: go_nogo $(TESTS)
check: $(CHECK_TESTS)

go_nogo: check_uvm_home
	./run_questa

config: check_uvm_home
	$(MAKE_CMD) EXAMPLE=ex_config ARGS="+CONFIG_ON +TRANS_ON" run
	mv $(LOG).log check.$@.log

reporting: check_uvm_home
	$(MAKE_CMD) EXAMPLE=ex_reporting run
	mv $(LOG).log check.$@.log

factory: check_uvm_home
	$(MAKE_CMD) EXAMPLE=ex_factory run
	mv $(LOG).log check.$@.log

topology: check_uvm_home
	$(MAKE_CMD) EXAMPLE=ex_print_topology run
	mv $(LOG).log check.$@.log

phasing: check_uvm_home
	$(MAKE_CMD) EXAMPLE=ex_phase_control ARGS=+PHASING_ON run
	mv $(LOG).log check.$@.log

clean:
	rm -rf work *.log vsim* transcript *.vstf *.log.cmp modelsim.ini

$(CHECK_TESTS):
	cat $@.log | \
			grep -v "UVM_WARNING :" | \
			grep -v "^# \[UVM\/COMP\/NAME\]" | \
			grep -v "^# \[UVM\/RELNOTES\]" | \
			grep -v "^# \[UVM\/REPORT\/CATCHER\]" | \
			grep -v "\/uvm-1.2\/" | \
		perl gold/check.pl > $@.log.cmp
	cmp $@.log.cmp gold/$@.log.cmp

run:
	-rm -rf work
	vlib work
	$(VLOG) sv_main.sv
	$(SCCOM) $(EXAMPLE).cpp
	$(LINK)
	$(VSIM) $(TRACE_OPT) $(ARGS) sc_main sv_main
	$(CHECK)
