`include "ae350_config.vh"
`include "ae350_const.vh"

module ae350_aopd_pin (
	//VPERL: &PORTLIST
	// VPERL_GENERATED_BEGIN
	`ifdef NDS_FPGA
	`else
		  X_osclio, 
	`endif // NDS_FPGA
		  X_osclin, 
		  T_oscl,   
	`ifdef PLATFORM_DEBUG_PORT
		  X_tck,    
	`endif // PLATFORM_DEBUG_PORT
		  T_tck,    
	`ifdef NDS_FPGA
		  mpd_por_b,
	`else
		  X_aopd_por_b,
		  X_om,     
	`endif // NDS_FPGA
		  T_aopd_por_b,
		  T_om,     
		  X_wakeup_in,
		  T_wakeup_in,
	`ifdef NDS_FPGA
	`else
	   `ifdef AE350_RTC_SUPPORT
		  X_rtc_wakeup,
		  rtc_alarm_wakeup,
	   `endif // AE350_RTC_SUPPORT
		  X_mpd_pwr_off,
	`endif // NDS_FPGA
		  mpd_pwr_off 
	// VPERL_GENERATED_END
);

`ifdef NDS_FPGA
wire		X_osclio;
`else	// !NDS_FPGA
inout		X_osclio;
`endif	// !NDS_FPGA
input		X_osclin;
output		T_oscl;

`ifdef PLATFORM_DEBUG_PORT
inout		X_tck;
`endif //PLATFORM_DEBUG_PORT
output		T_tck;

`ifdef NDS_FPGA
input		mpd_por_b;
`else
inout		X_aopd_por_b;
inout		X_om;
`endif //NDS_FPGA
output		T_aopd_por_b;
output		T_om;

inout		X_wakeup_in;
output		T_wakeup_in;

`ifdef AE350_RTC_SUPPORT
	`ifdef NDS_FPGA
	`else	// !NDS_FPGA
inout		X_rtc_wakeup;
input		rtc_alarm_wakeup;
	`endif	// !NDS_FPGA
`endif //AE350_RTC_SUPPORT

`ifdef NDS_FPGA
`else	// !NDS_FPGA
inout		X_mpd_pwr_off;
`endif	// !NDS_FPGA
input		mpd_pwr_off;

// OSCL interface
nds_osc_pad   oscl_pad		(.O(T_oscl), .I(X_osclin), .IO(X_osclio));

`ifdef NDS_FPGA
assign	T_aopd_por_b = mpd_por_b;
`else //~NDS_FPGA
// Power on Reset interface
nds_inout_pad aopd_porb_pad	(.O(T_aopd_por_b), .I(1'b0), .IO(X_aopd_por_b), .E(1'b0), .PU(1'b0), .PD(1'b0));
`endif// NDS_FPGA

// Test interface
`ifdef NDS_FPGA
assign	T_om = 1'b0;
`else //~NDS_FPGA
nds_inout_pad om_pad		(.O(T_om), .I(1'b0), .IO(X_om), .E(1'b0), .PU(1'b0), .PD(1'b0));
`endif //NDS_FPGA

// JTAG TCK is used as a wakeup event in main power down mode
`ifdef PLATFORM_DEBUG_PORT
nds_inout_pad jtag_tckc_pad	(.O(T_tck), .I(1'b0), .IO(X_tck), .E(1'b0), .PU(1'b0), .PD(1'b0));
`else //PLATFORM_DEBUG_PORT
assign  T_tck = 1'b0;
`endif //PLATFORM_DEBUG_PORT

// Wakeup event input
nds_inout_pad wakeup_pad	(.O(T_wakeup_in), .I(1'b0), .IO(X_wakeup_in), .E(1'b0), .PU(1'b0), .PD(1'b0));

// RTC alarm wakeup output
`ifdef AE350_RTC_SUPPORT
	`ifdef NDS_FPGA
	`else	// !NDS_FPGA
nds_inout_pad rtc_wakeup_pad	(.O(), .I(rtc_alarm_wakeup), .IO(X_rtc_wakeup), .E(1'b1), .PU(1'b0), .PD(1'b0));
	`endif	// !NDS_FPGA
`endif //AE350_RTC_SUPPORT

// Main power domain power enable output
`ifdef NDS_FPGA
`else	// !NDS_FPGA
nds_inout_pad mpd_pwr_off_pad	(.O(), .I(mpd_pwr_off), .IO(X_mpd_pwr_off), .E(1'b1), .PU(1'b0), .PD(1'b0));
`endif	// !NDS_FPGA

endmodule
