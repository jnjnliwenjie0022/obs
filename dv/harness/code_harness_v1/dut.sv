module dut(clk,
           rst_n, 
           rxd,
           rx_dv,
           txd,
           tx_en);
input clk;
input rst_n;
input[7:0] rxd;
input rx_dv;
output [7:0] txd;
output tx_en;

reg[7:0] txd;
reg tx_en;

always @(posedge clk) begin
   if(!rst_n) begin
      txd <= 8'b0;
      tx_en <= 1'b0;
   end
   else begin
      txd <= rxd;
      tx_en <= rx_dv;
   end
end
endmodule

//bind dut my_if rx_if (.data(rxd), .valid(rx_dv)); // bind module to virtual interface
//bind dut my_if tx_if (.data(txd), .valid(tx_en)); // bind module to virtual interface
bind dut dut_harness harness (); // bind the virtual interface to the module
