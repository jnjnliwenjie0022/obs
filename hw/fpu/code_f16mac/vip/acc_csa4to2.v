module acc_csa4to2 (
    in1,
    in2,
    in3,
    in4,
    sum,
    carry
);
parameter CSA_WIDTH = 32;
input [CSA_WIDTH - 1:0] in1;
input [CSA_WIDTH - 1:0] in2;
input [CSA_WIDTH - 1:0] in3;
input [CSA_WIDTH - 1:0] in4;
output [CSA_WIDTH:0] sum;
output [CSA_WIDTH - 1:0] carry;


wire [CSA_WIDTH - 1:0] carry_tmp;
assign carry_tmp = (in1 & in2) | (in1 & in3) | (in2 & in3);
assign sum = {carry_tmp[CSA_WIDTH - 1],in1 ^ in2 ^ in3 ^ in4 ^ {carry_tmp[CSA_WIDTH - 2:0],1'b0}};
assign carry = ((in1 ^ in2 ^ in3) & in4) | ((in1 ^ in2 ^ in3) & {carry_tmp[CSA_WIDTH - 2:0],1'b0}) | (in4 & {carry_tmp[CSA_WIDTH - 2:0],1'b0});
endmodule
