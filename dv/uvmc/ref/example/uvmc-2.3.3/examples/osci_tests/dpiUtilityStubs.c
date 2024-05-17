//
//-----------------------------------------------------------//
//   Copyright 2021 Siemens EDA                              //
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

#include "svdpi.h"

extern "C" {

static const char *errorMessageForStubFunctions =
    "UVMC ERROR: Attempted call to non-existent DPI utility "
    "function, %s function on HVL side.\n";

svScope svGetScope() __attribute__ ((weak));
svScope svGetScope()
{   printf( errorMessageForStubFunctions, "svGetScope()" );
    return NULL; }

svScope svSetScope( const svScope scope ) __attribute__ ((weak));
svScope svSetScope( const svScope scope )
{   printf( errorMessageForStubFunctions, "svSetScope()" );
    return NULL; }

void* svGetArrayPtr(const svOpenArrayHandle) __attribute__ ((weak));
void* svGetArrayPtr(const svOpenArrayHandle)
{   printf( errorMessageForStubFunctions, "svGetArrayPtr()" );
    return NULL; }

};
