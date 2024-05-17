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
    field_types

UVMC_HOME ?= ../..

help:
	@echo " -----------------------------------------------------------------";
	@echo "|                    FIELD TYPE EXAMPLES                          |";
	@echo " -----------------------------------------------------------------";
	@echo "|                                                                 |";
	@echo "| Usage:                                                          |";
	@echo "|                                                                 |";
	@echo "|   make [UVM_HOME=path] [UVMC_HOME=path] all                     |";
	@echo "|                                                                 |";
	@echo "|   go_nogo   : quick "go/no-go" test that just runs one basic    |";
	@echo "|               test by executing local 'run_questa' script to    |";
	@echo "|               demonstrate the full flow of building a UVMC      |";
	@echo "|               library to the local 'work' lib then running a    |";
	@echo "|               a single test. See comments in 'run_questa'.      |";
	@echo "|                                                                 |";
	@echo "| UVM_HOME and UVMC_HOME specify the location of the source       |";
	@echo "| headers and macro definitions needed by the examples. You must  |";
	@echo "| specify their locations via UVM_HOME and UVMC_HOME environment  |";
	@echo "| variables or make command line options. Command line options    |";
	@echo "| override any envrionment variable settings.                     |";
	@echo "|                                                                 |";
	@echo "| The UVM and UVMC libraries must be compiled prior to running    |";
	@echo "| any example. If the libraries are not at their default location |";
	@echo "| (UVMC_HOME/lib) then you must specify their location via the    |";
	@echo "| UVM_LIB and/or UVMC_LIB environment variables or make command   |";
	@echo "| line options. Make command line options take precedence.        |";
	@echo "|                                                                 |";
	@echo "| Other options:                                                  |";
	@echo "|                                                                 |";
	@echo "|   clean : Remove simulation files and directories               |";
	@echo "|   help  : Print this help information                           |";
	@echo "|                                                                 |";
	@echo " -----------------------------------------------------------------";


include $(UVMC_HOME)/examples/common/Makefile.questa

CHECK_TESTS=$(TESTS:%=check.%)

all: sim check clean

sim: go_nogo $(TESTS)
check: $(CHECK_TESTS)

go_nogo: check_uvm_home
	./run_questa

field_types: check_uvm_home
	-rm -rf work
	vlib work
	$(VLOG) sv_main.sv
	$(SCCOM) sc_main.cpp
	$(LINK)
	$(VSIM) sc_main sv_main
	$(CHECK)
	mv $(LOG).log check.$@.log

$(CHECK_TESTS):
	cat $@.log | perl gold/check.pl > $@.log.cmp
	cat $@.log | \
			grep -v "UVM_WARNING :" | \
			grep -v "^# \[UVM\/COMP\/NAME\]" | \
			grep -v "^# \[UVM\/RELNOTES\]" | \
			grep -v "^# \[UVM\/REPORT\/CATCHER\]" | \
			grep -v "^# \[SB\/ACTUAL\/RECV\]" | \
			grep -v "\/uvm-1.2\/" | \
		perl gold/check.pl > $@.log.cmp
	cmp $@.log.cmp gold/$@.log.cmp

clean:
	rm -rf work *.log vsim* transcript *.vstf *.log.cmp modelsim.ini

