module dut (
     clk
    ,resetn
    ,i_data
    ,o_data
);

input        clk;
input        resetn;
input  [7:0] i_data;
output [7:0] o_data:

assign o_data = i_data;

endmodule
