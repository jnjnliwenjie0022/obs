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

reg [7:0] data;

wire [7:0] data_nx = data + 'd1;

always @ (posedge clk or negedge resetn) begin
    if (resetn)
        data <= 'd0;
    else
        data <= data_nx;
end

assign o_data = data;

endmodule
