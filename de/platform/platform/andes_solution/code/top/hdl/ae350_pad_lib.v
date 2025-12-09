//---------------------------------------------------//
// INOUT PAD
//---------------------------------------------------//
module nds_inout_pad (O, I, IO, E, PU, PD);
output  O;
input   I;
inout   IO;
input   E;
input   PU;
input   PD;

`ifdef NDS_SYN

//PDB08DGZ_25 bipad4m (.I(I), .OEN(~E), .PAD(IO), .C(O));
PRWDWUWHWSWDGE_H_G bipad (.PAD(IO), 
                          .PE(1'b0), 
                          .IE(~E), 
                          .C(O), 
                          .DS0(1'b0), 
                          .DS1(1'b0), 
                          .I(I), 
                          .OEN(~E), 
                          .PS(1'b0), 
                          .SL(1'b0), 
                          .ST0(1'b0), 
                          .ST1(1'b0), 
                          .HE(1'b0) 
                         );

`elsif NDS_XILINX

IOBUF #(.DRIVE(8) // Specify the output drive strength
       )
iobuf (.O(O),     // Buffer output
       .IO(IO),   // Buffer inout port (connect directly to top-level port)
       .I(I),     // Buffer input
       .T(~E)     // 3-state enable input, high=input, low=output
      );

`elsif NDS_FPGA

assign  IO     = E ? I : 1'bz;
assign  O      = IO;

`else

assign  IO	= E ? I : 1'bz;
assign  O	= IO;
assign  (pull0, pull1) IO = PU ? 1'b1 :
                            PD ? 1'b0 : 1'bz;
`endif

endmodule

//---------------------------------------------------//
// OSC PAD
//---------------------------------------------------//
module nds_osc_pad (O, I, IO);
inout	IO;
input	I;
output	O;

`ifdef NDS_SYN
//PDXO01DG_25 osc (.XIN(I), .XOUT(IO), .XC(O));

PDXOEDG8E_H_G osc (.DS0(1'b0), 
                   .DS1(1'b0), 
                   .DS2(1'b0), 
                   .XE(1'b1), 
                   .XIN(I), 
                   .XOUT(IO), 
                   .XC(O));

`else

assign	O	= I;
assign	IO	= ~I;

`endif

endmodule
