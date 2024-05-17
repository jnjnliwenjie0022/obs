
#include "systemc.h"
#include "tlm.h"
#include <vector>
#include <iomanip>
#include <uvmc.h>

using std::vector;
using namespace sc_core;
using namespace tlm;

namespace user_lib {

    using namespace uvmc;

    class packet
    {
        public:
        enum cmd_t { WRITE=0, READ, NOOP };

        cmd_t cmd;
        unsigned int addr;
        vector<unsigned char> data;

        virtual void do_pack(uvmc_packer &packer) const {
            packer << cmd << addr << data;
        }

        virtual void do_unpack(uvmc_packer &packer) {
            packer >> cmd >> addr >> data;
        }
    };

    template <class T>
    class sv2systemc : public sc_module, public tlm_blocking_transport_if<T>
    {
        public:
        sc_export<tlm_blocking_transport_if<T> > texp;
        sc_port<tlm_blocking_transport_if<T> > tp;
    
        sv2systemc(sc_module_name nm) : texp("texp"), tp("tp")
        {
            texp(*this);
        }
    
        virtual void b_transport(T& t, sc_core::sc_time& delay) {
            cout << sc_time_stamp() << " SC sv2systemc executing packet:" 
                 << endl << "  " << t << endl;
            wait(delay);

            delay = SC_ZERO_TIME;
            tp->b_transport(t, delay);
        }
    };
}

using namespace user_lib;
UVMC_PRINT_3(packet,cmd,addr,data)

class sc_env : public sc_module
{
    public:
    sv2systemc<packet> sv2sc;

    sc_env(sc_module_name nm) : sv2sc("sv2sc") {
        uvmc_connect(sv2sc.texp,"sv2sc_connect");
        uvmc_connect(sv2sc.tp,"sc2sv_connect");
    }
};
int sc_main(int argc, char* argv[]) 
{  
    sc_env env("env");
    sc_start();
    return 0;
}
