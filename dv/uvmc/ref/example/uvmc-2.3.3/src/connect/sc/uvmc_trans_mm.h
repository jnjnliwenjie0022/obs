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

#ifndef _uvmc_trans_mm_h
#define _uvmc_trans_mm_h

#include <tlm.h>

namespace uvmc {

//__________________                                           _______________
// class uvmc_trans \_________________________________________/ johnS 7-7-2023
//
// Single pool object allocated or freed to a uvmc_trans_mm heap. This object
// can be parametrized to either a uvmc_xl_config_base or tlm_generic_payload.
//----------------------------------------------------------------------------

template <typename T>
class uvmc_trans {

  public:
    T payload;
    uvmc_trans *next;

    uvmc_trans() { next = NULL; }
};

//_______________________                                      _______________
// class uvmc_trans_base \____________________________________/ johnS 7-7-2023
//----------------------------------------------------------------------------

class uvmc_trans_mm_base {

  private:
    static uvmc_trans_mm_base *dMmQueue;
    uvmc_trans_mm_base *dMmNext;

  protected:
    uvmc_trans_mm_base(){ dMmNext = dMmQueue; dMmQueue = this; }

  public:
    static void printAllStats();
    virtual void printStats() = 0;
};

//_____________________                                        _______________
// class uvmc_trans_mm \______________________________________/ johnS 7-7-2023
//
// Memory pool manager for objects of type T where T can be
// uvmc_xl_config_base or tlm_generic_payload
//
// Used for efficient memory management of frequent allocs and deallocs of
// TLM GPs and static and sideband configs in UVM-Connect'ed TLM fabric.
//
// Also provides leak and usage statistics at the end of a simulation when run
// with DEBUG diagnostics enabled.
//----------------------------------------------------------------------------

template <typename T>
class uvmc_trans_mm : public uvmc_trans_mm_base {

  private:
    uvmc_trans<T> *dQueue;
    unsigned dTotalNumAllocs;
    unsigned dTotalNumFrees;
    string dHeapId;

  public:
    //-----------------------------------
    uvmc_trans_mm( const char *heapId )
      : dQueue(NULL), dTotalNumAllocs(0), dTotalNumFrees(0), dHeapId(heapId) {}

    //-----------------------------------
    ~uvmc_trans_mm() {
        uvmc_trans<T> *entry, *old;
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
    T *alloc(){
        uvmc_trans<T> *entry;

        // if( queue is empty ) ...
        if( dQueue == NULL ){
            entry = new uvmc_trans<T>();
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
    void free( T *t ){
        uvmc_trans<T> *entry = reinterpret_cast<uvmc_trans<T> *>( t );
        
        entry->next = dQueue;
        dQueue = entry;
#ifdef DEBUG
        dTotalNumFrees++;
#endif
    }

  public:
    //---------------------------------------------------------
    // printStats()
    //---------------------------------------------------------

    void printStats() {
        uvmc_trans<T> *entry;
        unsigned numFreePoolEntries = 0;

        // Count current # of entries in free pool for reporting.
        for( entry=dQueue; entry; entry = entry->next ) numFreePoolEntries++;

        printf( "uvmc_trans_mm::printStats() heapId=%s "
            "totalNumAllocs=%d totalNumFrees=%d "
            "numFreePoolEntries=%d\n",
            dHeapId.c_str(),
            dTotalNumAllocs, dTotalNumFrees, numFreePoolEntries );
    }
};

} // namespace uvmc

#endif // _uvmc_trans_mm_h
