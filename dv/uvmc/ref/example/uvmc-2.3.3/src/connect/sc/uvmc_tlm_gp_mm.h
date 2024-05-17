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

#ifndef _uvmc_tlm_gp_mm_h
#define _uvmc_tlm_gp_mm_h

#include <tlm.h>

namespace uvmc {

//___________________                                          _______________
// class uvmc_tlm_gp \________________________________________/ johnS 7-7-2023
//
// Single pool object allocated or freed to a uvmc_tlm_gp_mm heap. This object
// can be parametrized to either a uvmc_xl_config_base or tlm_generic_payload.
//----------------------------------------------------------------------------

class uvmc_tlm_gp {

  public:
    tlm::tlm_generic_payload payload;
    uvmc_tlm_gp *next;

    uvmc_tlm_gp() { next = NULL; }
};

//________________________                                     _______________
// class uvmc_tlm_gp_base \___________________________________/ johnS 7-7-2023
//----------------------------------------------------------------------------

class uvmc_tlm_gp_mm_base {

  private:
    static uvmc_tlm_gp_mm_base *dMmQueue;
    uvmc_tlm_gp_mm_base *dMmNext;

  protected:
    uvmc_tlm_gp_mm_base(){ dMmNext = dMmQueue; dMmQueue = this; }

  public:
    static void printAllStats();
    virtual void printStats() = 0;
};

//______________________                                       _______________
// class uvmc_tlm_gp_mm \_____________________________________/ johnS 7-7-2023
//
// Memory pool manager for objects of type tlm_generic_payload.
//
// Used for efficient memory management of frequent allocs and deallocs of TLM
// GPs and static and sideband configs in UVM-Connect'ed TLM fabric. This is in
// accordance with recommendations for a custom memory manager derived from
// class tlm_mm_interface as described tin the IEEE 1666 TLM-2.0 LRM.
//
// Also provides leak and usage statistics at the end of a simulation when run
// with DEBUG diagnostics enabled.
//----------------------------------------------------------------------------

class uvmc_tlm_gp_mm : public uvmc_tlm_gp_mm_base, public tlm::tlm_mm_interface
{
  private:
    uvmc_tlm_gp *dQueue;
    unsigned dTotalNumAllocs;
    unsigned dTotalNumFrees;
    string dHeapId;

  public:
    //-----------------------------------
    uvmc_tlm_gp_mm( const char *heapId )
      : dQueue(NULL), dTotalNumAllocs(0), dTotalNumFrees(0), dHeapId(heapId) {}

    //-----------------------------------
    ~uvmc_tlm_gp_mm() {
        uvmc_tlm_gp *entry, *old;
#ifdef DEBUG
        printStats();
#endif
        // Since we're deleting the pool itself we assume we can delete
        // all of its entries.
        for( entry=dQueue; entry; ){
            old = entry;
            entry = entry->next;
            delete old;
        }
    }

    //-----------------------------------
    tlm::tlm_generic_payload *alloc(){
        uvmc_tlm_gp *entry;

        // if( queue is empty ) ...
        if( dQueue == NULL ){
            entry = new uvmc_tlm_gp();
            entry->next = NULL;
        }
        else {
            entry = dQueue;
            dQueue = entry->next;
        }
#ifdef DEBUG
        dTotalNumAllocs++;
#endif
        return &entry->payload;
    }

    //-----------------------------------
    void free( tlm::tlm_generic_payload *t ){
        uvmc_tlm_gp *entry = reinterpret_cast<uvmc_tlm_gp *>( t );
        
        entry->next = dQueue;
        dQueue = entry;
#ifdef DEBUG
        dTotalNumFrees++;
#endif
    }

  public:
    //---------------------------------------------------------
    // printStats()                              johnS 4-9-2014
    //---------------------------------------------------------

    void printStats() {
        uvmc_tlm_gp *entry;
        unsigned numFreePoolEntries = 0;

        // Count current # of entries in free pool for reporting.
        for( entry=dQueue; entry; entry = entry->next ) numFreePoolEntries++;

        printf( "uvmc_tlm_gp_mm::printStats() heapId=%s "
            "totalNumAllocs=%d totalNumFrees=%d numFreePoolEntries=%d\n",
            dHeapId.c_str(),
            dTotalNumAllocs, dTotalNumFrees, numFreePoolEntries );
    }
};

} // namespace uvmc

#endif // _uvmc_tlm_gp_mm_h
