//{{{ include
#include "uvmc.h"
using namespace uvmc;

#include <string>
#include <iomanip>
using std::string;

#include <systemc.h>
#include <tlm.h>
using namespace sc_core;
using namespace tlm;

#include "simple_target_socket.h"
using tlm_utils::simple_target_socket;
#include "simple_initiator_socket.h"
using tlm_utils::simple_initiator_socket;
//}}}
//{{{ sc2systemv
class sc2systemv : public sc_module
{
    public:
    simple_initiator_socket<sc2systemv> inr_socket;

    SC_HAS_PROCESS(sc2systemv);
    sc2systemv(sc_module_name nm) : inr_socket("inr_socket")
    {
        SC_THREAD(p);
    }

    void p(void)
    {
        tlm_generic_payload gp; 
        char unsigned data[8];
        gp.set_data_ptr(data);
        sc_time delay;

        uvmc_raise_objection("run");

        for (int i = 0; i < 10; i++){
            int d_size;

            gp.set_command(TLM_WRITE_COMMAND);
            gp.set_address(rand());
            delay = sc_time(10,SC_NS);

            d_size = (rand() % 8) + 1;

            gp.set_data_length(d_size);

            for (int i=0; i < d_size; i++) {
                data[i] = rand();
            }
            cout << sc_time_stamp()
                 << " [sc2systemv/SEND] "
                 << "cmd:" << gp.get_command()
                 << " addr:" << hex << gp.get_address() << " data:{ ";

            for (int i = 0; i < (int)gp.get_data_length(); i++)
                cout << hex << (int)(data[i]) << " ";
            cout << "}" << endl;

            inr_socket->b_transport(gp,delay);
        }
        uvmc_drop_objection("run");
    }
};
//}}}
//{{{ sv2systemc
class sv2systemc : public sc_module
{
    public:
    simple_initiator_socket<sv2systemc> inr_socket;

    SC_HAS_PROCESS(sv2systemc);
    sv2systemc(sc_module_name nm) : inr_socket("inr_socket")
    {
        SC_THREAD(p);
    }

    void p(void)
    {
        tlm_generic_payload gp; 
        char unsigned *data;
        sc_time delay;

        for (int i = 0; i < 10; i++){
            delay = sc_time(10,SC_NS);
            inr_socket->b_transport(gp,delay);

            cout << sc_time_stamp()
                 << " [sv2systemc/GET] "
                 << "cmd:" << gp.get_command()
                 << " addr:" << hex << gp.get_address() << " data:{ ";
            data = gp.get_data_ptr();

            for (int i = 0; i < (int)gp.get_data_length(); i++)
                cout << hex << (int)(data[i]) << " ";
            cout << "}" << endl;
        }
    }
};
//}}}
//{{{ sc_main
int sc_main(int argc, char* argv[]) 
{  
    sv2systemc sv2sc("sv2sc");
    sc2systemv sc2sv("sc2sv");
    uvmc_connect(sv2sc.inr_socket, "sv2sc");
    uvmc_connect(sc2sv.inr_socket, "sc2sv");
    sc_start(-1);
    return 0;
}
//}}}
