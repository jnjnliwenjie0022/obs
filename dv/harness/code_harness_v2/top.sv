module top (
     clk
    ,resetn
    ,i_data
    ,o_data0
    ,o_data1
    ,o_data2
    ,o_data3
);

input        clk;
input        resetn;
input  [7:0] i_data;
output [7:0] o_data0;
output [7:0] o_data1;
output [7:0] o_data2;
output [7:0] o_data3;

wire [7:0] i_data0 = i_data;
wire [7:0] i_data1 = i_data;
wire [7:0] i_data2 = i_data;
wire [7:0] i_data3 = i_data;

dut u_dut0 (
     .clk    (clk     )
    ,.resetn (resetn  )
    ,.i_data (i_data0 )
    ,.o_data (o_data0 )
);

dut u_dut1 (
     .clk    (clk     )
    ,.resetn (resetn  )
    ,.i_data (i_data1 )
    ,.o_data (o_data1 )
);

dut u_dut2 (
     .clk    (clk     )
    ,.resetn (resetn  )
    ,.i_data (i_data2 )
    ,.o_data (o_data2 )
);

dut u_dut3 (
     .clk    (clk     )
    ,.resetn (resetn  )
    ,.i_data (i_data3 )
    ,.o_data (o_data3 )
);

endmodule
