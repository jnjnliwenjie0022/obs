
#include <systemc.h>
#include <tlm.h>
#include <vector>
#include <list>
using namespace sc_core;
using namespace tlm;
using namespace std;
#include "uvmc.h"
using namespace uvmc;



/*
Class: req_packet
Simple transaction class with various sizes of bit and logic vectors.
*/
class req_packet
  {

public:
	bool rnw;
	sc_bv < 32 > addr;
	sc_lv < 32 > wdata;
	sc_bv < 32 > rdata;

    req_packet() { }
    virtual ~req_packet() { }

    virtual void do_pack(uvmc_packer& p) const {
        p << rnw        ;
        p << addr       ;
        p << wdata      ;
        p << rdata      ;
    }

    virtual void do_unpack(uvmc_packer& p) {
        p >> rnw        ;
        p >> addr       ;
        p >> wdata      ;
        p >> rdata      ;
    }

    virtual void do_print (ostream& o) const {
        o << hex << "rnw                  " << rnw                  << endl;
        o << hex << "addr                 " << addr                 << endl;
        o << hex << "wdata                " << wdata                << endl;
        o << hex << "rdata                " << rdata                << endl;
        o << dec;
    }

};

#ifndef DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP
class rsp_packet
  {

public:
	sc_bv < 32 > addr;
	sc_bv < 32 > rdata;

    rsp_packet() { }
    virtual ~rsp_packet() { }

    virtual void do_pack(uvmc_packer& p) const {
        p << addr       ;
        p << rdata      ;
    }

    virtual void do_unpack(uvmc_packer& p) {
        p >> addr       ;
        p >> rdata      ;
    }

    virtual void do_print (ostream& o) const {
        o << hex << "addr                 " << addr                 << endl;
        o << hex << "rdata                " << rdata                << endl;
        o << dec;
    }

};
#else
typedef req_packet rsp_packet;
#endif // DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP

/*
 * Class: consumer_with_transport_port
 * Component to receive packet on the put port (sv_out) and send it back on the analysis port (sv_in).
 * Idea here is to check that after packing and unpacking we do not loose any information.
 */
class consumer_with_transport_port:
	public sc_module
    , public tlm::tlm_transport_if< req_packet, rsp_packet >
{
public:

  sc_export<tlm::tlm_transport_if < req_packet, rsp_packet > > sv_out;
  rsp_packet tx_rsp;

	consumer_with_transport_port(sc_module_name nm) :
      sc_module(nm), sv_out("sv_out"), tx_rsp()
	{
		sv_out(*this);
	}

	rsp_packet transport(const req_packet &tx) {
		cout << "received input in sc" << endl;
		tx.do_print(cout);
#ifdef DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP
        tx_rsp = tx;
#endif
        tx_rsp.addr = tx.addr;
        tx_rsp.rdata = tx.wdata;
        cout << "sent output to sv" << endl;
        tx_rsp.do_print(cout);
        return tx_rsp;
	}

};

// need to declare a converter for packing/unpacking both rsp and req type for transport port
struct req_rsp_packet_converter : public uvmc_converter<req_packet> {
  public:
  static void do_pack(const req_packet &t, uvmc_packer &packer) {
      t.do_pack(packer);
  }
  static void do_unpack(req_packet &t, uvmc_packer &packer) {
      t.do_unpack(packer);
  }

#ifndef DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP
  static void do_pack(const rsp_packet &t, uvmc_packer &packer) {
      t.do_pack(packer);
  }
  static void do_unpack(rsp_packet &t, uvmc_packer &packer) {
      t.do_unpack(packer);
  }
#endif
};


int sc_main(int argc, char* argv[]) {
	consumer_with_transport_port cons("cons");

#ifdef DEBUG_UVMC_TRANSPORT_PORT_SAME_REQ_RSP
	uvmc_connect(cons.sv_out, "transport_port_sv_out");
#else
    //uvmc_connect(cons.sv_out, "transport_port_sv_out");
    uvmc_connect<req_rsp_packet_converter, req_rsp_packet_converter > (cons.sv_out, "transport_port_sv_out");
#endif

	sc_start();
	return 0;

}
