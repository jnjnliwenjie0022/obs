///// producer.h /////
#include <string>
#include <iomanip>
using std::string;
 
#include <systemc.h>
#include <tlm.h>
using namespace sc_core;
using namespace tlm;
 
template <class T>
class producer : public sc_module {

 public:
  sc_port<tlm_blocking_transport_if<T> > out;
  sc_event done;
 
  producer(sc_module_name nm) : out("out") {
    SC_THREAD(run);
  }
 
  SC_HAS_PROCESS(producer);
 
  void run() {
    sc_time delay;
    T t;

    int d_size;
    packet_base::cmd_t cmd;
    int unsigned addr;
    vector<char> data;
    char unsigned tmp;

    d_size = (rand() % 8) + 1;
    for(int i=0; i < d_size; i++) {
      tmp = rand();
      data.push_back(tmp);
    }
    t.set_data_copy(data);

    for (int i=0; i < d_size; i++) {
      printf("===== Loop Number %d / %d =====\n", i+1, d_size);
      delay = sc_time(10,SC_NS);
      cmd  = (packet_base::cmd_t)(rand()&3);
      addr = rand();
      t.cmd  = cmd;
      t.addr = addr;
      out->b_transport(t, delay);
    }
    done.notify();
  }
};

template <class T>
class producer_uvm : public producer<T> {

  public:

  producer_uvm(sc_module_name nm) : producer<T>(nm) {
    SC_THREAD(objector);
  }

  SC_HAS_PROCESS(producer_uvm);

  void objector() {
    uvmc_raise_objection("run");
    wait(this->done);
    uvmc_drop_objection("run");
  }
};
