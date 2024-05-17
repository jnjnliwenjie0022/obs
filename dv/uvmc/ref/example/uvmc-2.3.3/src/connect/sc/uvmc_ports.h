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

#ifndef UVMC_PORTS_H
#define UVMC_PORTS_H

//------------------------------------------------------------------------------
//
//                               SV --> SC 
//
// This file defines ports/sockets that drive SC-side interfaces, exports, and
// target sockets. These ports are driven by SV-side.
//
//
//------------------------------------------------------------------------------

#include <string>
#include <map>
#include <vector>
#include <iomanip>
#include <systemc.h>
#include <tlm.h>

using namespace sc_core;
using namespace sc_dt;
using namespace tlm;
using std::string;
using std::map;
using std::vector;


#include "svdpi.h"

#include "uvmc_common.h"
#include "uvmc_convert.h"

// UVMC233_ADDITIONS {
#include "uvmc_trans_mm.h"
// } UVMC233_ADDITIONS

//------------------------------------------------------------------------------
//
// Group- DPI-C export functions
//
// Not intended for public use.
//
// The following C2SV-prefixed functions are called by UVMC to transfer
// packed bits across the language boundary using standard DPI-C.
//
//------------------------------------------------------------------------------

// SV DPI export functions (to SV, in response to blocking calls))

extern "C"
{
void  C2SV_blocking_req_done (int x_id);
void  C2SV_blocking_rsp_done (int x_id, const bits_t *bits, sc_dt::uint64 delay);
}

namespace uvmc
{

//------------------------------------------------------------------------------
//
// CLASS- uvmc_tlm1_port_proxy <T1,T2>
//
// DPI SV--> calls into these methods. SV-side must not call into more than
// one method at a time, i.e. must use a semaphore.
//
// NOTE- x_put, x_write, x_transport take bits from SV and unpack them into
// a new transaction on the SC side. The new transaction is created on the stack,
// unpacked into, then 'put' to the target component as a const &T. This
// means that T must have a copy c'tor defined (or the default must be 
// sufficient).

// NOTE- ports and sockets only support N=1 and POL=SC_ONE_OR_MORE_BOUND

//------------------------------------------------------------------------------

template <class T1, class T2=T1,
          class CVRT_T1=uvmc_converter<T1>,
          class CVRT_T2=uvmc_converter<T2> >
class uvmc_tlm1_port_proxy : public uvmc_proxy_base
{
  public:
  typedef uvmc_tlm1_port_proxy <T1,T2,CVRT_T1,CVRT_T2> this_type;

  uvmc_tlm1_port_proxy(const string name, const string lookup, const int mask,
                       uvmc_packer *packer=NULL, unsigned int stack_size=0) 
                : uvmc_proxy_base(name, lookup, mask, packer, UVM_PORT) {
    blocking_op = NONE;
    if (stack_size > 0)
      m_stack_size = stack_size;
    else
      m_stack_size = uvmc_default_stack_size;
  }

  virtual ~uvmc_tlm1_port_proxy() {
  }

  protected:
  enum op_e {NONE, PUT, GET, PEEK, TRANSPORT};
  op_e blocking_op;
  sc_event blocking_op_done;
  sc_process_handle blocking_process_h;
  T1 req;
  T2 rsp;
  unsigned int m_stack_size;

  void blocking_sync_process() {
    while(true) {
      switch (blocking_op) {
        case PUT:
          this->put(req);
          svSetScope(uvmc_pkg_scope);
          C2SV_blocking_req_done(x_id());
          break;
        case GET:
          this->get(rsp);
          m_packer->init_pack(m_bits);
          CVRT_T1::do_pack(rsp,*m_packer);
          svSetScope(uvmc_pkg_scope);
          C2SV_blocking_rsp_done(x_id(),m_bits,0);
          break;
        case PEEK:
          this->peek(rsp);
          m_packer->init_pack(m_bits);
          CVRT_T1::do_pack(rsp,*m_packer);
          svSetScope(uvmc_pkg_scope);
          C2SV_blocking_rsp_done(x_id(),m_bits,0);
          break;
        case TRANSPORT:
          this->transport(req,rsp);
          m_packer->init_pack(m_bits);
          CVRT_T1::do_pack(rsp,*m_packer);
          svSetScope(uvmc_pkg_scope);
          C2SV_blocking_rsp_done(x_id(),m_bits,0);
          break;
        case NONE:
          C2SV_blocking_req_done(x_id());
          break;
      }
      wait(blocking_op_done);
    }
  }

  void set_stack_size(unsigned int stack_size) {
    m_stack_size = stack_size;
  }

  void notify_blocking_sync_process(op_e op) {
    blocking_op = op;
    static int cnt=1;
    static sc_spawn_options sp_ops;
    sp_ops.set_stack_size(m_stack_size);
    if (!blocking_process_h.valid()) {
      char name[200];
      sprintf(name,"%s%s%0d",uvmc_legal_path(this->name()).c_str(),"_sync_proc",cnt++);
      blocking_process_h =
        sc_spawn(sc_bind(&this_type::blocking_sync_process,this), name, &sp_ops);
    }
    else
      blocking_op_done.notify();
  }

  virtual void x_put (const bits_t *bits) {
    m_packer->init_unpack(bits);
    CVRT_T2::do_unpack(req,*m_packer);
    notify_blocking_sync_process(PUT);
  }

  virtual void x_get () {
    notify_blocking_sync_process(GET);
  }

  virtual void x_peek () {
    notify_blocking_sync_process(PEEK);
  }

  virtual bool x_try_put (const bits_t *bits) {
    T1 t;
    m_packer->init_unpack(bits);
    CVRT_T2::do_unpack(t,*m_packer);
    return nb_put(t);
  }

  virtual bool x_can_put() {
    return nb_can_put();
  }

  virtual bool x_try_get (bits_t *bits) {
    T2 t;
    if (this->nb_get(t)) {
      m_packer->init_pack(bits);
      CVRT_T1::do_pack(t,*m_packer);
      return 1;
    }
    return 0;
  }

  virtual bool x_can_get () {
    return this->nb_can_get();
  }

  virtual bool x_try_peek (bits_t *bits) {
    T2 t;
    if (this->nb_peek(t)) {
      m_packer->init_pack(bits);
      CVRT_T1::do_pack(t,*m_packer);
      return 1;
    }
    return 0;
  }

  virtual bool x_can_peek() {
    return this->nb_can_peek();
  }

  virtual void x_write (const bits_t *bits) {
    T1 t;
    m_packer->init_unpack(bits);
#ifdef UVMC23_ADDITIONS // {
    // Allow converters to query if transaction being unpacked/packed
    // is owned by application or UVMC (for knowing when to allocate/
    // release local config extensions or use application defined ones)
    m_packer->uvmc_owns_trans(1);
#endif // } UVMC23_ADDITIONS
    CVRT_T2::do_unpack(t,*m_packer);
    this->write(t);
#ifdef UVMC23_ADDITIONS // {
    m_packer->uvmc_owns_trans(0);
#endif // } UVMC23_ADDITIONS
  } 

  virtual void x_transport (bits_t *bits) {
    m_packer->init_unpack(bits);
    CVRT_T2::do_unpack(req,*m_packer);
    notify_blocking_sync_process(TRANSPORT);
  }

  // empty virtual TLM methods. Proxy Port extensions will override only
  // those belonging to the interface
  virtual void put      (const T1 &t) { }
  virtual void get      (T2 &t)       { }
  virtual void peek     (T2 &t)       { }

  virtual bool nb_put   (const T1 &t) { return false; }
  virtual bool nb_get   (T2 &t)       { return false; }
  virtual bool nb_peek  (T2 &t)       { return false; }

  virtual bool nb_can_put  (tlm_tag <T1> *t=0) const { return false; }
  virtual bool nb_can_get  (tlm_tag <T2> *t=0) const { return false; }
  virtual bool nb_can_peek (tlm_tag <T2> *t=0) const { return false; }

  virtual void write    (const T1 &t) { }

  virtual void transport(const T1 &req, T2 &rsp) { }

};



//------------------------------------------------------------------------------
//
// CLASS- uvmc_tlm2_port_proxy <IMP,T,PHASE>
//
// DPI SV--> calls into these methods. SV-side must not call into more than
// one method at a time, i.e. must use a semaphore.
//------------------------------------------------------------------------------

template <class T, class PHASE=tlm_phase, class CVRT=uvmc_converter<T> >
class uvmc_tlm2_port_proxy : public uvmc_proxy_base
{
  public:
  typedef uvmc_tlm2_port_proxy<T,PHASE,CVRT> this_type;

  uvmc_tlm2_port_proxy(const string name, const string lookup, const int mask,
                            uvmc_packer *packer=NULL, unsigned int stack_size=0)
  : uvmc_proxy_base(name, lookup, mask, packer, UVM_PORT),
// UVMC233_ADDITIONS {
    proxy_mm( string(name+".proxy_mm").c_str() )
// } UVMC233_ADDITIONS
  {
    blocking_op = NONE;
    if (stack_size > 0)
      m_stack_size = stack_size;
    else
      m_stack_size = uvmc_default_stack_size;

// UVMC233_ADDITIONS {
    // By default we use a reusable transaction data type 'T' (typically T is
    // tlm_generic_payload) for all nb_transport_*() ops. This can be overriden
    // if application chooses to enable a TLM GP memory heap
    // manager for use by this uvmc_ports module by calling
    // uvmc_enable_trans_mm().
    //
    // ATTENTION ! The main reason for an application to call
    // uvmc_enable_trans_mm() is if it is desired to allow for TLM GP object
    // preservation between the REQ phases (nb_transprt_fw() calls) and the
    // RESP phases (nb_transport_bw() calls). In this case is it is the onus of
    // the application to pass the same TLM GP transaction to nb_transport_bw()
    // on the RESP phase as was passed in through nb_transport_fw() in the
    // matching REQ phase.
    //
    // If the nb_transport_fw() call has "early completion" (i.e returns
    // tlm::TLM_COMPLETED) then the TLM GP's ::release() method will be
    // called on nb_transport_fw() return and thus automaticaly freed back
    // to the heap.
    //
    // In a 4 phase operation during which the RESP phases are deployed by
    // the target's call to nb_transport_bw() then it is assumed that the
    // passed in transaction will be one matched in the nb_transport_fw() call
    // and the nb_transport_bw() in this itself will call the ::release()
    // method to also release storage.
    //
    // In this case UVMC infrastructure on the SV side will guarantee that
    // the same transaction that was passed into nb_transport_fw() during
    // the REQ phases will be reflected back to that initiator's
    // nb_transport_bw() callback during the RESP phases. Thus original TLM GP 
    // will be preserved through all 4 phases of the TLM-2.0 base protocol.
    // 
    // However, WORD OF CAUTION: if the target does not pass the same TLM GP to
    // nb_transport_bw() as was received via nb_transport_fw() a memory leak
    // will result. This is because there is otherwise no way to know when it
    // is safe to return that TLM GP back to the heap.
    //
    // Fortunately there is a sanity check that is called when -DDEBUG is
    // enabled that captures print heap statistics from the uvmc_trans_mm<T>
    // on all alloc and free operations. At the end of the simulation function
    // calls can be made to print all heap statistics. These statistics will
    // clearly indicate if any memory leakage has occurred. These calls exist
    // for both uvmc_tlm_gp_mm and uvmc_trans_mm heap managers,
    //
    // uvmc_tlm_gp_mm_base::printAllStats();
    // uvmc_trans_mm_base::printAllStats();

    m_nb_t = &m_nb_t_default;

// } UVMC233_ADDITIONS
  }

  virtual ~uvmc_tlm2_port_proxy() { }

  enum op_e {NONE,B_TRANSPORT};

  void set_stack_size(unsigned int stack_size) {
    m_stack_size = stack_size;
  }


  protected:
  op_e blocking_op;
  sc_event blocking_op_done;
  sc_process_handle blocking_process_h;
  T  m_b_t;
  T* m_nb_t;
// UVMC233_ADDITIONS {
  T m_nb_t_default;
  uvmc_trans_mm<T> proxy_mm; // Proxy's private transaction object
                             // ('T') memory manager.
// } UVMC233_ADDITIONS
  sc_time *m_x_delay;
  unsigned int m_stack_size;

  void notify_blocking_sync_process(op_e op) {
    static int cnt = 0;
    static sc_spawn_options sp_ops;
    sp_ops.set_stack_size(m_stack_size);
    blocking_op = op;
    if (!blocking_process_h.valid()) {
      char name[200];
      sprintf(name,"%s%s%0d",uvmc_legal_path(this->name()).c_str(),"_sync_proc",cnt++);
      blocking_process_h =
        sc_spawn(sc_bind(&this_type::blocking_sync_process,this),name,&sp_ops);
    }
    else
      blocking_op_done.notify();
  }

  void blocking_sync_process() {
    while(true) {
      switch (blocking_op) {
        case B_TRANSPORT:
          double delay_in_ps;
          sc_dt::uint64* delay_in_bits;
          this->b_transport(m_b_t,*m_x_delay);
          m_packer->init_pack(m_bits);
          CVRT::do_pack(m_b_t,*m_packer);
#ifdef UVMC23_ADDITIONS // {
          m_packer->uvmc_owns_trans(0);
#endif // } UVMC23_ADDITIONS
          delay_in_ps = m_x_delay->to_seconds() * 1e12; 
          delay_in_bits = reinterpret_cast<sc_dt::uint64*>(&delay_in_ps);
          svSetScope(uvmc_pkg_scope);
          C2SV_blocking_rsp_done(x_id(),m_bits,*delay_in_bits);
          delete m_x_delay;
          break;
        case NONE:
          C2SV_blocking_req_done(x_id());
          break;
        default: break;
      }
      wait(blocking_op_done);
    }
  }

  virtual void x_b_transport (bits_t *bits, sc_dt::uint64 delay) {
    m_packer->init_unpack(bits);
#ifdef UVMC23_ADDITIONS // {
    // Allow converters to query if transaction being unpacked/packed
    // is owned by application or UVMC (for knowing when to allocate/
    // release local config extensions or use application defined ones)
    m_packer->uvmc_owns_trans(1);
#endif // } UVMC23_ADDITIONS
    CVRT::do_unpack(m_b_t,*m_packer);
    double* d = reinterpret_cast<double*>(&delay);
    m_x_delay = new sc_time(*d,SC_PS);
    notify_blocking_sync_process(B_TRANSPORT);
  }

  virtual int x_nb_transport_fw (bits_t *bits, uint32 *phase, sc_dt::uint64 *delay) {
    double delay_in_ps;
    double* d = reinterpret_cast<double*>(delay);
    sc_time x_delay = sc_time(*d,SC_PS);
    PHASE x_phase = *phase;
    m_packer->init_unpack(bits);
#ifdef UVMC23_ADDITIONS // {
    // Allow converters to query if transaction being unpacked/packed
    // is owned by application or UVMC (for knowing when to allocate/
    // release local config extensions or use application defined ones)
    m_packer->uvmc_owns_trans(1);
#endif // } UVMC23_ADDITIONS
    CVRT::do_unpack(*m_nb_t,*m_packer);
    tlm_sync_enum result;
    result = this->nb_transport_fw(*m_nb_t,x_phase,x_delay);
    delay_in_ps = x_delay.to_seconds() * 1e12; 
    *delay = (sc_dt::uint64)delay_in_ps;
    *phase = x_phase;
    m_packer->init_pack(bits);
    CVRT::do_pack(*m_nb_t,*m_packer);
#ifdef UVMC23_ADDITIONS // {
    m_packer->uvmc_owns_trans(0);
#endif // } UVMC23_ADDITIONS
    return result;
  }

  virtual int x_nb_transport_bw ( unsigned long long trans_chandle,
    bits_t *bits, uint32 *phase, sc_dt::uint64 *delay)
  {
    double delay_in_ps;
    double* d = reinterpret_cast<double*>(delay);
    sc_time x_delay = sc_time(*d,SC_PS);
    PHASE x_phase = *phase;
    m_packer->init_unpack(bits);
#ifdef UVMC23_ADDITIONS // {
    // Allow converters to query if transaction being unpacked/packed
    // is owned by application or UVMC (for knowing when to allocate/
    // release local config extensions or use application defined ones)
    m_packer->uvmc_owns_trans(1);
#endif // } UVMC23_ADDITIONS
    CVRT::do_unpack(*m_nb_t,*m_packer);

// UVMC233_ADDITIONS {
    // If TLM GP transaction preservation across 4 phases of TLM-2.0 base
    // protocol is enabled then now in the nb_transport_bw() call made during
    // the RESP phases, we do a map lookup of the original transaction passed
    // to nb_transport_fw() during the REQ phases.
    //
    // The key to this map was the original SC-side TLM GP chandle for this
    // transaction. That chandle is passed as argument 'trans_chandle' coming
    // from the SV-side as a 64 bit integer (longint) quantity.
    if( uvmc_is_trans_mm_enabled ){
        T *t = reinterpret_cast<T *>( trans_chandle );
        if( t != NULL ) m_nb_t = t;
        else m_nb_t = &m_nb_t_default;
    }
// } UVMC233_ADDITIONS

    tlm_sync_enum result = this->nb_transport_bw(*m_nb_t,x_phase,x_delay);

    delay_in_ps = x_delay.to_seconds() * 1e12; 
    *delay = (sc_dt::uint64)delay_in_ps;
    *phase = x_phase;
    m_packer->init_pack(bits);
    CVRT::do_pack(*m_nb_t,*m_packer);
#ifdef UVMC23_ADDITIONS // {
    m_packer->uvmc_owns_trans(0);
#endif // } UVMC23_ADDITIONS
    return result;
  }

// UVMC233_ADDITIONS {
  // Here we allocate a trans object, 'T' (typically TLM GP) from our local
  // heap and return it as a 'chandle' to the requesting SV side. But at the
  // same time we assign it to the local proxy's m_mb_t member in anticipation
  // that the SV side will immediately call x_nb_transport_fw(). This allows
  // the SV side to map it's local SV trans object and use this chandle as its
  // key for later lookup during the RESP phase when nb_transport_bw() is
  // called back across the language boundary to the SV side.
  unsigned long long x_trans_mm_alloc(){
      m_nb_t = proxy_mm.alloc();
      //m_nb_t->acquire(); // If we knew this was a TLM GP we could call this
                           // to reference count our memory object. But we
                           // don't because it's a 'T' which can be anything.
                           // Hence we deviate from the TLM-2.0 LRM's
                           // recommended use of tlm_mm_interface.
      return reinterpret_cast<unsigned long long>( m_nb_t );
  }

  void x_trans_mm_free( unsigned long long trans_chandle ){
      proxy_mm.free( reinterpret_cast<T *>( trans_chandle ) );
      //m_nb_t->free(); // If we knew this was a TLM GP we could call this
                        // to free our memory object (after all ref counts
                        // decremented). But we don't because it's a 'T'
                        // which can be anything. Hence we deviate from the
                        // TLM-2.0 LRM's recommended use of tlm_mm_interface.
  }
// } UVMC233_ADDITIONS

  // empty virtual TLM methods. Proxy Port extensions will override only
  // those belonging to the interface

  virtual void b_transport( T& trans, sc_time& delay ) {
  }

  virtual tlm::tlm_sync_enum nb_transport_fw( T& trans,
                                              PHASE& phase,
                                              sc_core::sc_time& t) {
    return tlm::TLM_COMPLETED;
  }

  virtual tlm::tlm_sync_enum nb_transport_bw( T& trans,
                                              PHASE& phase,
                                              sc_core::sc_time& t) {
    return tlm::TLM_COMPLETED;
  }

#ifdef UVMC23_ADDITIONS // {
  protected:

    virtual tlm::tlm_sync_enum sc2sc_nb_transport_bw(
        T &trans, PHASE &phase, sc_time &delay )
    { cout << "ERROR: unexpected call to "
           << "uvmc_tlm2_port_proxy::sc2sc_nb_transport_bw()" << endl;
      return tlm::TLM_COMPLETED; }

#endif // } UVMC23_ADDITIONS

};


//------------------------------------------------------------------------------
//
// CLASSES- concrete port proxies. To use, first create an sc_port<> of a
// type that is compatible with the export or interface you want to bind to.
// Then create the corresponding proxy from the classes below, passing a
// reference to the sc_port object as the first argument to the proxy's ctor.
// This enables SV-side calls to propagate through the DPI and the proxy, 
// eventually calling the interface method target via the sc_port.
//
// SV --> DPI --> x_* method in proxy --> TLM method in proxy extension -->
//   bound interface method via sc_port
//
// Each of the 24 port specializations has the same c'tors, so we put c'tor
// code in a macro. C'tors are not inherited--they must be coded in each
// derivative class.
// TODO: disable default c'tor and copy c'tor.
//
// Note on use of sc_core::sc_get_curr_simcontext()->hierarchy_pop() in c'tors:
// In the macro for the CTOR below, we call simcontext->hierarchy_pop().
// We've already pushed uvmc_registry module onto the hierarchy stack in
// uvmc_proxy_base's c'tor, which executes before the socket's c'tor. Then
// the socket is created, which makes it a child of uvmc_registry.
// By the time we've reached here, we need only pop the uvmc_registry
// off simcontext's hierarchy stack.
//------------------------------------------------------------------------------


#define UVMC_PORT_CTOR(IF_NAME,MASK) \
  \
  uvmc_##IF_NAME##_port(const string name, \
                        const string lookup, \
                        uvmc_packer *packer=NULL, \
                        unsigned int stack_size=0) : \
       proxy_type(name,lookup,MASK,packer,stack_size), \
       sc_port<if_type>((string("UVMC_PORT_FOR_") + uvmc_legal_path(name)).c_str()) \
  { \
    sc_core::sc_get_curr_simcontext()->hierarchy_pop(); \
  } \
  virtual const char *kind() const { \
    return "uvmc_" #IF_NAME "_port<>"; \
  } \
  virtual const char *name() const { \
    return proxy_type::name(); \
  }  

#define UVMC_PORT_BIDIR_CTOR(IF_NAME,MASK) \
  \
  uvmc_##IF_NAME##_port(const string name, \
                        const string lookup, \
                        uvmc_packer *packer=NULL, \
                        unsigned int stack_size=0) : \
       proxy_type(name,lookup,MASK,packer,stack_size), \
       sc_port<if_type>((string("UVMC_PORT_FOR_") + uvmc_legal_path(name)).c_str()) \
  { \
    sc_core::sc_get_curr_simcontext()->hierarchy_pop(); \
  } \
  virtual const char *kind() const { \
    return "uvmc_" #IF_NAME "_port<>"; \
  } \
  virtual const char *name() const { \
    return proxy_type::name(); \
  }  


// B_PUT

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_blocking_put_port
    : public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      public sc_port<tlm_blocking_put_if<T> >
{
  public:
  typedef tlm_blocking_put_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(blocking_put,TLM_B_PUT_MASK)
  virtual void put(const T &t) { (*this)->put(t); }
};


// NB_PUT

template <class T, 
          class CVRT=uvmc_converter<T> >
class uvmc_nonblocking_put_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_nonblocking_put_if<T> >
{
  public: 
  typedef tlm_nonblocking_put_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(nonblocking_put,TLM_NB_PUT_MASK)
  virtual bool nb_put(const T &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <T> *t=0) const { return (*this)->nb_can_put(); }
};


// PUT

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_put_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_put_if<T> >
{
  public:
  typedef tlm_put_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(put,TLM_PUT_MASK)
  virtual void put(const T &t) { (*this)->put(t); }
  virtual bool nb_put(const T &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <T> *t=0) const { return (*this)->nb_can_put(); }
};


// B_GET

template <class T,
          class CVRT=uvmc_converter<T> >
struct uvmc_blocking_get_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_blocking_get_if<T> >
{
  public: 
  typedef tlm_blocking_get_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(blocking_get,TLM_B_GET_MASK)
  virtual void get(T &t) { (*this)->get(t); }
};


// NB_GET

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_nonblocking_get_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_nonblocking_get_if<T> >
{
  public:
  typedef tlm_nonblocking_get_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(nonblocking_get,TLM_NB_GET_MASK)
  virtual bool nb_get(T &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <T> *t=0) const { return (*this)->nb_can_get(); }
};


// GET

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_get_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_get_if<T> >
{
  public:
  typedef tlm_get_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(get,TLM_GET_MASK)
  virtual void get(T &t) { (*this)->get(t); }
  virtual bool nb_get(T &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <T> *t=0) const { return (*this)->nb_can_get(); }
};


// B_PEEK

template <class T,
          class CVRT=uvmc_converter<T> >
struct uvmc_blocking_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_blocking_peek_if<T> >
{
  public: 
  typedef tlm_blocking_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(blocking_peek,TLM_B_PEEK_MASK)
  virtual void peek(T &t) { (*this)->peek(t); }
};


// NB_PEEK

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_nonblocking_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_nonblocking_peek_if<T> >
{
  public:
  typedef tlm_nonblocking_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(nonblocking_peek,TLM_NB_PEEK_MASK)
  virtual bool nb_peek(T &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <T> *t=0) const { return (*this)->nb_can_peek(); }
};


// PEEK

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_peek_if<T> >
{
  public:
  typedef tlm_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(peek,TLM_PEEK_MASK)
  virtual void peek(T &t) { (*this)->peek(t); }
  virtual bool nb_peek(T &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <T> *t=0) const { return (*this)->nb_can_peek(); }
};


// B_GET_PEEK

template <class T, class CVRT=uvmc_converter<T> >
struct uvmc_blocking_get_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_blocking_get_peek_if<T> >
{
  public: 
  typedef tlm_blocking_get_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(blocking_get_peek,TLM_B_GET_PEEK_MASK)
  virtual void get(T &t) { (*this)->get(t); }
  virtual void peek(T &t) { (*this)->peek(t); }
};


// NB_GET_PEEK

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_nonblocking_get_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_nonblocking_get_peek_if<T> >
{
  public:
  typedef tlm_nonblocking_get_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(nonblocking_get_peek,TLM_NB_GET_PEEK_MASK)
  virtual bool nb_get(T &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <T> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(T &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <T> *t=0) const { return (*this)->nb_can_peek(); }
};


// GET_PEEK

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_get_peek_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_get_peek_if<T> >
{
  public:
  typedef tlm_get_peek_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(get_peek,TLM_GET_PEEK_MASK)
  virtual void get(T &t) { (*this)->get(t); }
  virtual void peek(T &t) { (*this)->peek(t); }
  virtual bool nb_get(T &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <T> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(T &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <T> *t=0) const { return (*this)->nb_can_peek(); }
};


// WRITE

template <class T, 
          class CVRT=uvmc_converter<T> >
class uvmc_write_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public sc_port<tlm_write_if<T>,0,SC_ZERO_OR_MORE_BOUND >
{
  public:
  typedef tlm_write_if<T> if_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;
  UVMC_PORT_CTOR(write,TLM_ANALYSIS_MASK)
  virtual void write(const T &t) { (*this)->write(t); }
};


// ANALYSIS (WRITE)

template <class T,
          class CVRT=uvmc_converter<T> >
class uvmc_analysis_port
    : virtual public uvmc_tlm1_port_proxy<T,T,CVRT,CVRT>,
      virtual public tlm_analysis_port<T>
{
  public:
  typedef tlm_analysis_if<T> if_type;
  typedef tlm_analysis_port<T> port_type;
  typedef uvmc_tlm1_port_proxy<T,T,CVRT,CVRT> proxy_type;

  uvmc_analysis_port(const string name, 
                     const string lookup,
                     uvmc_packer *packer=NULL) : 
       proxy_type(name,lookup,TLM_ANALYSIS_MASK,packer), 
       port_type((string("UVMC_PORT_FOR_") +
                         uvmc_legal_path(name)).c_str()) { 
    sc_core::sc_get_curr_simcontext()->hierarchy_pop();
  } 
  
  virtual const char *kind() const { 
    return "uvmc_analysis_port<>"; 
  } 
  virtual const char *name() const { 
    return proxy_type::name();
  }  
  
  private:
  uvmc_analysis_port( );
};




// B_MASTER

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_blocking_master_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_blocking_master_if<REQ,RSP> >
{
  public:
  typedef tlm_blocking_master_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(blocking_master,TLM_B_MASTER_MASK)
  virtual void put(REQ &t) { (*this)->put(t); }
  virtual void get(RSP &t) { (*this)->get(t); }
  virtual void peek(RSP &t) { (*this)->peek(t); }
};


// NB_MASTER

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_nonblocking_master_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_nonblocking_master_if<REQ,RSP> >
{
  public:
  typedef tlm_nonblocking_master_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(nonblocking_master,TLM_NB_MASTER_MASK)
  virtual bool nb_put(const REQ &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_put(); }
  virtual bool nb_get(RSP &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(RSP &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_peek(); }
};


// MASTER

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_master_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_master_if<REQ,RSP> >
{
  public:
  typedef tlm_master_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(master,TLM_MASTER_MASK)
  virtual void put(REQ &t) { (*this)->put(t); }
  virtual void get(RSP &t) { (*this)->get(t); }
  virtual void peek(RSP &t) { (*this)->peek(t); }
  virtual bool nb_put(const REQ &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_put(); }
  virtual bool nb_get(RSP &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(RSP &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_peek(); }
};


// B_SLAVE

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_blocking_slave_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_blocking_slave_if<REQ,RSP> >
{
  public:
  typedef tlm_blocking_slave_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(blocking_slave,TLM_B_SLAVE_MASK)
  virtual void put(RSP &t) { (*this)->put(t); }
  virtual void get(REQ &t) { (*this)->get(t); }
  virtual void peek(REQ &t) { (*this)->peek(t); }
};


// NB_SLAVE

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_nonblocking_slave_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_nonblocking_slave_if<REQ,RSP> >
{
  public:
  typedef tlm_nonblocking_slave_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(nonblocking_slave,TLM_NB_SLAVE_MASK)
  virtual bool nb_put(const RSP &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_put(); }
  virtual bool nb_get(REQ &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(REQ &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_peek(); }
};


// SLAVE

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_slave_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_slave_if<REQ,RSP> >
{
  public:
  typedef tlm_slave_if<REQ,RSP> if_type;
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  UVMC_PORT_BIDIR_CTOR(slave,TLM_SLAVE_MASK)
  virtual void put(RSP &t) { (*this)->put(t); }
  virtual bool nb_put(const RSP &t) { return (*this)->nb_put(t); }
  virtual bool nb_can_put(tlm_tag <RSP> *t=0) const { return (*this)->nb_can_put(); }
  virtual void get(REQ &t) { (*this)->get(t); }
  virtual void peek(REQ &t) { (*this)->peek(t); }
  virtual bool nb_get(REQ &t) { return (*this)->nb_get(t); }
  virtual bool nb_can_get(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_get(); }
  virtual bool nb_peek(REQ &t) { return (*this)->nb_peek(t); }
  virtual bool nb_can_peek(tlm_tag <REQ> *t=0) const { return (*this)->nb_can_peek(); }
};


// TRANSPORT (TLM1)

template <class REQ,
          class RSP=REQ,
          class CVRT_REQ=uvmc_converter<REQ>,
          class CVRT_RSP=uvmc_converter<RSP> >
class uvmc_transport_port
    : virtual public uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP>,
      virtual public sc_port<tlm_transport_if<REQ,RSP> >
{
  public:
  typedef uvmc_tlm1_port_proxy<REQ,RSP,CVRT_REQ,CVRT_RSP> proxy_type;
  typedef tlm_transport_if<REQ,RSP> if_type;
  UVMC_PORT_BIDIR_CTOR(transport,TLM_TRANSPORT_MASK)
  virtual void transport(const REQ &req, RSP &rsp) { (*this)->transport(req,rsp); }
};


// TLM2

// B_TRANSPORT (TLM2)

template <class T=tlm_generic_payload,
          class CVRT=uvmc_converter<T> >
class uvmc_blocking_transport_port
    : virtual public uvmc_tlm2_port_proxy<T,tlm_phase,CVRT>,
      virtual public sc_port<tlm_blocking_transport_if<T> >
{
  public:
  typedef tlm_blocking_transport_if <T> if_type;
  typedef uvmc_tlm2_port_proxy<T,tlm_phase,CVRT> proxy_type;
  UVMC_PORT_CTOR(blocking_transport,TLM_B_TRANSPORT_MASK)
  virtual void b_transport( T& trans, sc_time& delay ) {
    (*this)->b_transport(trans,delay);
  }

};


// NB_TRANSPORT_FW (TLM2)

template <class T=tlm_generic_payload,
          class PHASE=tlm_phase,
          class CVRT=uvmc_converter<T> >
class uvmc_fw_nonblocking_transport_port
    : virtual public uvmc_tlm2_port_proxy<T,PHASE,CVRT>,
      virtual public sc_port<tlm_fw_nonblocking_transport_if<T,PHASE> >
{
  public:
  typedef tlm_fw_nonblocking_transport_if <T,PHASE> if_type;
  typedef uvmc_tlm2_port_proxy<T,PHASE,CVRT> proxy_type;
  UVMC_PORT_CTOR(fw_nonblocking_transport,TLM_FW_NB_TRANSPORT_MASK)
  virtual tlm::tlm_sync_enum nb_transport_fw( T& trans,
                                              PHASE& phase,
                                              sc_core::sc_time& delay) {
    tlm_sync_enum result;
    result = (*this)->nb_transport_fw(trans,phase,delay);
    return result;
  }
};


// NB_TRANSPORT_BW (TLM2)

template <class T=tlm_generic_payload,
          class PHASE=tlm_phase,
          class CVRT=uvmc_converter<T> >
class uvmc_bw_nonblocking_transport_port
    : virtual public uvmc_tlm2_port_proxy<T,PHASE,CVRT>,
      virtual public sc_port<tlm_bw_nonblocking_transport_if<T,PHASE> >
{
  public:
  typedef tlm_bw_nonblocking_transport_if <T,PHASE> if_type;
  typedef uvmc_tlm2_port_proxy<T,PHASE,CVRT> proxy_type;
  UVMC_PORT_CTOR(bw_nonblocking_transport,TLM_BW_NB_TRANSPORT_MASK)
  virtual tlm::tlm_sync_enum nb_transport_bw( T& trans,
                                              PHASE& phase,
                                              sc_core::sc_time& delay) {
    return (*this)->nb_transport_bw(trans,phase,delay);
  }
};




// INITIATOR_SOCKET

template <unsigned int BUSWIDTH = 32,
          class TYPES=tlm_base_protocol_types,
          int N = 1,
          sc_port_policy POL = SC_ONE_OR_MORE_BOUND,
          class CVRT=uvmc_converter<typename TYPES::tlm_payload_type> >

class uvmc_initiator_socket
    : 
      public uvmc_tlm2_port_proxy<typename TYPES::tlm_payload_type,
                                  typename TYPES::tlm_phase_type, CVRT>,
      public tlm_bw_transport_if<TYPES>
{
  typedef uvmc_initiator_socket<BUSWIDTH,TYPES,N,POL,CVRT> this_type;
  typedef uvmc_tlm2_port_proxy<typename TYPES::tlm_payload_type,
                                 typename TYPES::tlm_phase_type,
                                 CVRT> proxy_type;
  typedef tlm_initiator_socket <BUSWIDTH, TYPES, N, POL> initiator_type;
public:

  initiator_type m_init_skt;

#ifdef UVMC23_ADDITIONS // {
  typedef tlm_target_socket <BUSWIDTH, TYPES, N, POL> target_type;
  target_type *m_peer_sc_initiator_proxy;

  void set_peer_sc_initiator_proxy_socket( target_type *peer ){
    proxy_type::m_use_peer_sc_proxy = true;
    m_peer_sc_initiator_proxy = peer; }
#endif // } UVMC23_ADDITIONS

  uvmc_initiator_socket(const string nm,
                        const string lookup,
                        uvmc_packer *packer=NULL,
                        unsigned int stack_size=0) :
          proxy_type(string(nm), lookup,
                            TLM_FW_NB_TRANSPORT_MASK |
                            TLM_BW_NB_TRANSPORT_MASK |
                            TLM_B_TRANSPORT_MASK,
                            packer, stack_size),
          m_init_skt((string("UVMC_INIT_SOCKET_FOR_") + 
                     uvmc_legal_path(nm)).c_str())
   {
   // We've already pushed uvmc_registry module onto the hierarchy stack in
   // uvmc_proxy_base's c'tor, which executes before the socket's c'tor.
   // By the time we've reached here, we need only pop the uvmc_registry
   // off simcontext's hierarchy stack.
   sc_core::sc_get_curr_simcontext()->hierarchy_pop();

   m_init_skt.bind( *this );
  }

  // b_transport - from SV (x_b_transport)
  
  virtual void b_transport(typename TYPES::tlm_payload_type &trans, sc_time& delay ) {
    m_init_skt->b_transport(trans,delay);
  }

  // nb_tranport_fw - from SV (x_nb_transport_fw)

  virtual tlm::tlm_sync_enum nb_transport_fw(typename TYPES::tlm_payload_type &trans,
                                             typename TYPES::tlm_phase_type &phase,
                                              sc_core::sc_time& delay) {
    return m_init_skt->nb_transport_fw(trans,phase,delay);
  }

  // nb_transport_bw - to SV

  // this overrides the base imp in uvmc_bw_noblocking_transport_port.
  // This is ok as long as the SV side target proxy never calls SV2C_nb_transport_bw.
  virtual tlm::tlm_sync_enum nb_transport_bw(typename TYPES::tlm_payload_type &trans,
                                             typename TYPES::tlm_phase_type &phase,
                                             sc_core::sc_time& t)
  {
#ifdef UVMC23_ADDITIONS // {
    // if( SC <-> SC UVM-Connect'ion being used ) ...
    if( proxy_type::m_use_peer_sc_proxy )
        return sc2sc_nb_transport_bw( trans, phase, t );
#endif // } UVMC23_ADDITIONS

    int result;
    tlm_sync_enum sync;
    double delay_in_ps = t.to_seconds() * 1e12; 
    sc_dt::uint64* delay_in_bits = reinterpret_cast<sc_dt::uint64*>(&delay_in_ps);
    unsigned int ph = phase;
    proxy_type::m_packer->init_pack(this->m_bits);
    CVRT::do_pack(trans,*proxy_type::m_packer);
    svSetScope(uvmc_pkg_scope);

// UVMC233_ADDITIONS {
    unsigned long long trans_chandle
        = reinterpret_cast<unsigned long long>( &trans );

    result = C2SV_nb_transport_bw(this->m_x_id,
        trans_chandle, this->m_bits, &ph, delay_in_bits);
// } UVMC233_ADDITIONS
    sync = static_cast<tlm_sync_enum>(result);
    phase = ph;
    proxy_type::m_packer->init_unpack(this->m_bits);
    CVRT::do_unpack(trans,*proxy_type::m_packer);
    return sync;
  }
 
  virtual void invalidate_direct_mem_ptr(sc_dt::uint64 start_range, sc_dt::uint64 end_range)
  {
    // not implemented
  }

#ifdef UVMC23_ADDITIONS // {
  protected:
    virtual tlm::tlm_sync_enum sc2sc_nb_transport_bw(
        typename TYPES::tlm_payload_type &trans,
        typename TYPES::tlm_phase_type &phase, sc_time &delay )
    {   return (*m_peer_sc_initiator_proxy)->nb_transport_bw(
            trans, phase, delay ); }
#endif // } UVMC23_ADDITIONS

};

} // namespace uvmc

#endif // UVMC_PORTS_H
