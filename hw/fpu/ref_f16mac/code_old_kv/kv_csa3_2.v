// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_csa3_2 (
    in0,
    in1,
    cin,
    sum,
    cout
);
parameter CSA_WIDTH = 32;
input [CSA_WIDTH - 1:0] in0;
input [CSA_WIDTH - 1:0] in1;
input [CSA_WIDTH - 1:0] cin;
output [CSA_WIDTH - 1:0] sum;
output [CSA_WIDTH - 1:0] cout;


integer i;
reg [CSA_WIDTH - 1:0] sum;
reg [CSA_WIDTH - 1:0] cout;
always @(in0 or in1 or cin) begin
    for (i = 0; i < CSA_WIDTH; i = i + 1) begin
        {cout[i],sum[i]} = {1'b0,in0[i]} + {1'b0,in1[i]} + {1'b0,cin[i]};
    end
end

endmodule

