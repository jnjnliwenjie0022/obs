# ============================================================================
#  @(#) $Id: common.mk 1972 2021-05-20 10:17:03Z markma $
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

UVMC_HOME ?= ..
UVMC_LIB ?= $(UVMC_HOME)/lib/uvmc_lib
UVM_LIB  ?= $(UVMC_HOME)/lib/uvmc_lib

CXX=g++
OPT=-O3
CFLAGS = $(OPT)

INCL = \
    -I$(UVMC_HOME)/src/connect/sc
