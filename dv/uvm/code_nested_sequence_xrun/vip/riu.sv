module riu(
    clk
    ,rst_n
    ,riu_wr
    ,riu_en
    ,riu_addr
    ,riu_wdata
    ,riu_rdata
    ,riu_ready
);

parameter RIU_ADDR_BITWIDTH = 16;
parameter RIU_DATA_BITWIDTH = 64;

input                          clk;
input                          rst_n;
input                          riu_wr;
input                          riu_en;
input  [RIU_ADDR_BITWIDTH-1:0] riu_addr;
input  [RIU_DATA_BITWIDTH-1:0] riu_wdata;
output reg [RIU_DATA_BITWIDTH-1:0] riu_rdata;
output reg                         riu_ready;

initial begin
    @(posedge rst_n);
    forever begin
        riu_rdata <= $urandom_range(10,0);
        riu_ready <= $urandom_range(1,1);
        @(posedge clk);
    end
end

endmodule
