
#include "systemc.h"
#include "tlm.h"
#include <vector>
#include <iomanip>
#include <uvmc.h>

using std::vector;
using namespace sc_core;
using namespace tlm;

namespace user_lib 
{

    using namespace uvmc;

    class packet
    {
        public:
        enum cmd_t { WRITE=0, READ, NOOP };

        cmd_t cmd;
        unsigned int addr;
        vector<unsigned char> data;
        int jasonli;

        virtual void do_pack(uvmc_packer &packer) const {
            packer << cmd << addr << data << jasonli;
        }

        virtual void do_unpack(uvmc_packer &packer) {
            packer >> cmd >> addr >> data >> jasonli;
        }
    };

    template <class T>
    class sv2systemc : public sc_module
    {
        public:
        sc_port<tlm_get_if<T> > port;
    
        sv2systemc(sc_module_name nm) : port("port")
        {
            SC_THREAD(p);
        }

        SC_HAS_PROCESS(sv2systemc);

        void p()
        {
            for(;;){
                T t = port->get();
                cout << sc_time_stamp() << " SC sv2systemc executing packet:" 
                     << endl << "  " << t << endl;
            }
        }
        
    };

    template <class T>
    class sc2systemv : public sc_module
    {
        public:
        sc_port<tlm_put_if<T> > port;
    
        sc2systemv(sc_module_name nm) : port("port")
        {
            SC_THREAD(p);
        }

        SC_HAS_PROCESS(sc2systemv);

        void p(void)
        {
            //sc_time delay;
            //delay = sc_time(10,SC_NS);

            unsigned int addr = 1000;
            T t;
            for(int i = 0; i < 10; i++){
                t.addr = addr++;
                cout << sc_time_stamp() << " SC sc2systemcv executing packet:" 
                     << endl << "  " << t << endl;
                port->put(t);
            }
            //wait(delay);
            cout << "here: " << t << endl;
        }
        
    };
}

using namespace user_lib;
UVMC_PRINT_4(packet,cmd,addr,data,jasonli)

class sc_env : public sc_module
{
    public:
    sv2systemc<packet> sv2sc;
    sc2systemv<packet> sc2sv;

    sc_env(sc_module_name nm) : sv2sc("sv2sc"), sc2sv("sc2sv") {
        uvmc_connect(sv2sc.port,"sv2sc_connect");
        uvmc_connect(sc2sv.port,"sc2sv_connect");
    }
};
int sc_main(int argc, char* argv[]) 
{  
    sc_env env("env");
    sc_start();
    return 0;
}







