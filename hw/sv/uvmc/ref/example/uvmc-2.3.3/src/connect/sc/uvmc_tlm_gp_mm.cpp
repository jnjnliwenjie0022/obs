//-----------------------------------------------------------//
//   Copyright 2023 Siemens EDA                              //
//                                                           //
//   Licensed under the Apache License, Version 2.0 (the     //
//   "License"); you may not use this file except in         //
//   compliance with the License.  You may obtain a copy of  //
//   the License at                                          //
//                                                           //
//       http://www.apache.org/licenses/LICENSE-2.0          //
//                                                           //
//   Unless required by applicable law or agreed to in       //
//   writing, software distributed under the License is      //
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR  //
//   CONDITIONS OF ANY KIND, either express or implied.      //
//   See the License for the specific language governing     //
//   permissions and limitations under the License.          //
//-----------------------------------------------------------//

#include "uvmc_tlm_gp_mm.h"

//________________________                                     _______________
// class uvmc_tlm_gp_base \___________________________________/ johnS 7-7-2023
//----------------------------------------------------------------------------

uvmc::uvmc_tlm_gp_mm_base *uvmc::uvmc_tlm_gp_mm_base::dMmQueue = NULL;

void uvmc::uvmc_tlm_gp_mm_base::printAllStats(){
    uvmc_tlm_gp_mm_base *mm;

    for( mm = dMmQueue; mm; mm = mm->dMmNext )
        mm->printStats();
}
