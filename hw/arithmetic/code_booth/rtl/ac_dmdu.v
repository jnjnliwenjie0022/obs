module ac_dmdu(
    req_en
    ,req_sign
    ,req_16b
    ,req_op0
    ,req_op1
    ,resp_result
);

input req_en;
input req_sign;
input req_16b;
input [15:0] req_op0;
input [15:0] req_op1;
output [31:0] resp_result;

wire [17:0] pp_x0  = recode_pp_x0( req_en, req_sign, req_16b, {req_op1[1:0], 1'b0                }, req_op0);
wire [17:0] pp_x2  = recode_pp_x2( req_en, req_sign, req_16b, {req_op1[3:1]                      }, req_op0);
wire [17:0] pp_x4  = recode_pp_x4( req_en, req_sign, req_16b, {req_op1[5:3]                      }, req_op0);
wire [17:0] pp_x6  = recode_pp_x6( req_en, req_sign, req_16b, {req_op1[7:5]                      }, req_op0);
wire [17:0] pp_x8  = recode_pp_x8( req_en, req_sign, req_16b, {req_op1[9:8], req_16b & req_op1[7]}, req_op0);
wire [17:0] pp_x10 = recode_pp_x10(req_en, req_sign, req_16b, {req_op1[11:9]                     }, req_op0);
wire [17:0] pp_x12 = recode_pp_x12(req_en, req_sign, req_16b, {req_op1[13:11]                    }, req_op0);
wire [17:0] pp_x14 = recode_pp_x14(req_en, req_sign, req_16b, {req_op1[15:13]                    }, req_op0);
wire [23:0] pp_x16 = recode_pp_x16(req_en, req_sign, req_16b, {req_op1[15], req_op1[7]           }, req_op0);

wire ci0  = recode_cin(req_en, {req_op1[1:0], 1'b0                 }); // 16, 8 
wire ci2  = recode_cin(req_en, {req_op1[3:1]                       }); // 16, 8
wire ci4  = recode_cin(req_en, {req_op1[5:3]                       }); // 16, 8
wire ci6  = recode_cin(req_en, {req_op1[7:5]                       }); // 16, 8
wire ci8  = recode_cin(req_en, {req_op1[9:8], req_16b & req_op1[7] }); // 16 
wire ci10 = recode_cin(req_en, {req_op1[11:9]                      }); // 16
wire ci12 = recode_cin(req_en, {req_op1[13:11]                     }); // 16
wire ci14 = recode_cin(req_en, {req_op1[15:13]                     }); // 16

wire [31:0] ci;

assign ci[0]  = ci0;
assign ci[1]  = 1'b0;
assign ci[2]  = ci2;
assign ci[3]  = 1'b0;
assign ci[4]  = ci4;
assign ci[5]  = 1'b0;
assign ci[6]  = ci6;
assign ci[7]  = 1'b0;
assign ci[8]  = req_16b & ci8;
assign ci[9]  = ~req_16b;
assign ci[10] = ~req_16b | ci10;
assign ci[11] = 1'b0;
assign ci[12] = ~req_16b | ci12;
assign ci[13] = 1'b0;
assign ci[14] = ~req_16b | ci14;
assign ci[15] = 1'b0;
assign ci[16] = ~req_16b &  ci8;
assign ci[17] = req_16b;
assign ci[18] = req_16b | ci10;
assign ci[19] = 1'b0;
assign ci[20] = req_16b | ci12;
assign ci[21] = 1'b0;
assign ci[22] = req_16b | ci14;
assign ci[23] = 1'b0;
assign ci[24] = req_16b;
assign ci[25] = ~req_16b;
assign ci[26] = 1'd1;
assign ci[27] = 1'b0;
assign ci[28] = 1'd1;
assign ci[29] = 1'b0;
assign ci[30] = 1'd1;
assign ci[31] = 1'b0;

wire [31:0] csa_00_s;
wire [31:0] csa_01_s;
wire [31:0] csa_02_s;
wire [31:0] csa_00_c;
wire [31:0] csa_01_c;
wire [31:0] csa_02_c;

assign {csa_00_c, csa_00_s} = csa32(
    {14'b0, pp_x0       },
    {12'b0, pp_x2,  2'b0},
    {10'b0, pp_x4,  4'b0});
assign {csa_01_c, csa_01_s} = csa32(
    {8'b0,  pp_x6,  6'b0},
    {6'b0,  pp_x8,  8'b0},
    {4'b0,  pp_x10, 10'b0});
assign {csa_02_c, csa_02_s} = csa32(
    {2'b0,  pp_x12, 12'b0},
    {       pp_x14, 14'b0},
    {       pp_x16, 8'b0});

wire [31:0] csa_10_s; 
wire [31:0] csa_11_s; 
wire [31:0] csa_10_c; 
wire [31:0] csa_11_c; 

assign {csa_10_c, csa_10_s} = csa32(
    csa_00_s,
    csa_01_s,
    csa_02_s);
assign {csa_11_c, csa_11_s} = csa32(
    {csa_00_c[30:16], csa_00_c[15] & req_16b, csa_00_c[14:0], 1'b0},
    {csa_01_c[30:16], csa_01_c[15] & req_16b, csa_01_c[14:0], 1'b0},
    {csa_02_c[30:16], csa_02_c[15] & req_16b, csa_02_c[14:0], 1'b0});

wire [31:0] csa_20_s;
wire [31:0] csa_20_c;

assign {csa_20_c, csa_20_s} = csa32(
    csa_10_s,
    csa_11_s,
    {csa_10_c[30:16], csa_10_c[15] & req_16b, csa_10_c[14:0], 1'b0});

wire [31:0] csa_30_s;
wire [31:0] csa_30_c;

assign {csa_30_c, csa_30_s} = csa32(
    csa_20_s,
    {csa_11_c[30:16], csa_11_c[15] & req_16b, csa_11_c[14:0], 1'b0},
    {csa_20_c[30:16], csa_20_c[15] & req_16b, csa_20_c[14:0], 1'b0});

wire [31:0] csa_40_s;
wire [31:0] csa_40_c;

assign {csa_40_c, csa_40_s} = csa32(
    csa_30_s,
    {csa_30_c[30:16], csa_30_c[15] & req_16b, csa_30_c[14:0], 1'b0},
    ci);

wire [32:0] csa_50_s;

assign csa_50_s = 
    {csa_40_s[31:16]                       , req_16b, csa_40_s[15:0]} +
    {csa_40_c[30:16],csa_40_c[15] & req_16b,   1'b0 , csa_40_c[14:0], 1'b0};

assign resp_result = {csa_50_s[32:17], csa_50_s[15:0]};


function [17:0] recode_pp_x0;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg        signed_ext8;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];
    signed_ext8 = sign & in0[7];

    recode_pp_x0 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; //0
        3'b001: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b010: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:9]                , (b16_en ?  in0[8]   :  ~signed_ext8               ),  in0[7:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:9]                , (b16_en ? ~in0[8]   :   signed_ext8               ), ~in0[7:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b111: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; // 0
        endcase
        recode_pp_x0 = recode_pp & {{8{b16_en}}, ~10'b0};
    end
end
endfunction

function [17:0] recode_pp_x2;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg        signed_ext8;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];
    signed_ext8 = sign & in0[7];

    recode_pp_x2 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; //0
        3'b001: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b010: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:9]                , (b16_en ?  in0[8]   :  ~signed_ext8               ),  in0[7:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:9]                , (b16_en ? ~in0[8]   :   signed_ext8               ), ~in0[7:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b111: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; // 0
        endcase
        recode_pp_x2 = recode_pp & {{8{b16_en}}, ~10'b0};
    end
end
endfunction

function [17:0] recode_pp_x4;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg        signed_ext8;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];
    signed_ext8 = sign & in0[7];

    recode_pp_x4 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; //0
        3'b001: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b010: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:9]                , (b16_en ?  in0[8]   :  ~signed_ext8               ),  in0[7:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:9]                , (b16_en ? ~in0[8]   :   signed_ext8               ), ~in0[7:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b111: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; // 0
        endcase
        recode_pp_x4 = recode_pp & {{8{b16_en}}, ~10'b0};
    end
end
endfunction

function [17:0] recode_pp_x6;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg        signed_ext8;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];
    signed_ext8 = sign & in0[7];

    recode_pp_x6 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; //0
        3'b001: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b010: recode_pp = {~signed_ext16, signed_ext16,   in0[15:10], (b16_en ?  in0[9:8] : {~signed_ext8,  signed_ext8}),  in0[7:0]      }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:9]                , (b16_en ?  in0[8]   :  ~signed_ext8               ),  in0[7:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:9]                , (b16_en ? ~in0[8]   :   signed_ext8               ), ~in0[7:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:10], (b16_en ? ~in0[9:8] : { signed_ext8, ~signed_ext8}), ~in0[7:0]      }; //-X
        3'b111: recode_pp = {1'b1         , 7'b0                      , (b16_en ?  1'b0     : 1'b1                        ),  9'b0          }; // 0
        endcase
        recode_pp_x6 = recode_pp & {{8{b16_en}}, ~10'b0};
    end
end
endfunction

function [17:0] recode_pp_x8;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];

    recode_pp_x8 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'd1         ,  17'b0                                                   }; //0
        3'b001: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b010: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:8]   , (b16_en ?  in0[7] : 1'b0),  in0[6:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:8]   , (b16_en ? ~in0[7] : 1'b1), ~in0[6:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b111: recode_pp = {1'd1         ,  17'b0                                                   }; // 0
        endcase
        recode_pp_x8 = recode_pp & {~10'b0, {8{b16_en}}};
    end
end
endfunction

function [17:0] recode_pp_x10;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];

    recode_pp_x10 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'd1         ,  17'b0                                                   }; //0
        3'b001: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b010: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:8]   , (b16_en ?  in0[7] : 1'b0),  in0[6:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:8]   , (b16_en ? ~in0[7] : 1'b1), ~in0[6:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b111: recode_pp = {1'd1         ,  17'b0                                                   }; // 0
        endcase
        recode_pp_x10 = recode_pp & {~10'b0, {8{b16_en}}};
    end
end
endfunction

function [17:0] recode_pp_x12;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];

    recode_pp_x12 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'd1         ,  17'b0                                                   }; //0
        3'b001: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b010: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:8]   , (b16_en ?  in0[7] : 1'b0),  in0[6:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:8]   , (b16_en ? ~in0[7] : 1'b1), ~in0[6:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b111: recode_pp = {1'd1         ,  17'b0                                                   }; // 0
        endcase
        recode_pp_x12 = recode_pp & {~10'b0, {8{b16_en}}};
    end
end
endfunction

function [17:0] recode_pp_x14;
input en;
input sign;
input b16_en;
input [2:0] partial_y;
input [15:0] in0;

reg        signed_ext16;
reg [17:0] recode_pp;

begin
    signed_ext16 = sign & in0[15];

    recode_pp_x14 = 18'b0;
    if(en)begin
        case(partial_y)
        3'b000: recode_pp = {1'd1         ,  17'b0                                                   }; //0
        3'b001: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b010: recode_pp = {~signed_ext16,  signed_ext16, in0[15:0]                                 }; //X
        3'b011: recode_pp = {~signed_ext16,  in0[15:8]   , (b16_en ?  in0[7] : 1'b0),  in0[6:0], 1'b0}; //2X
        3'b100: recode_pp = { signed_ext16, ~in0[15:8]   , (b16_en ? ~in0[7] : 1'b1), ~in0[6:0], 1'b1}; //-2X
        3'b101: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b110: recode_pp = { signed_ext16, ~signed_ext16, ~in0[15:0]                                }; //-X
        3'b111: recode_pp = {1'd1         ,  17'b0                                                   }; // 0
        endcase
        recode_pp_x14 = recode_pp & {~10'b0, {8{b16_en}}};
    end
end
endfunction

function [23:0] recode_pp_x16;
input en;
input sign;
input b16_en;
input [1:0] partial_y;
input [15:0] in0;

reg [23:0] recode_pp;

// 000 signed   0
// 001 unsigned X
// 111 signed   0
begin
    recode_pp[23:8] = ~sign && partial_y[1] ? in0[15:0] : 16'b0;
    recode_pp[7:0]  = ~sign && partial_y[0] ? in0[7:0]  : 8'b0;
    recode_pp_x16[23:16] = recode_pp[23:16];
    recode_pp_x16[15:8]  = recode_pp[15:8] & {8{b16_en}};
    recode_pp_x16[7:0]   = recode_pp[7:0]  & {8{~b16_en}};
end
endfunction

function recode_cin;
input       en;
input [2:0] partial_y;

begin
    recode_cin = en & (partial_y == 3'b100 || partial_y == 3'b101 || partial_y == 3'b110);
end
endfunction

function [63:0] csa32; // {carry, sum}
input [31:0] in0;
input [31:0] in1;
input [31:0] in2;

reg [31:0] sum;
reg [31:0] carry;

begin
    sum = in0 ^ in1 ^ in2;
    carry = in0 & in1 | in1 & in2 | in0 & in2;
    csa32 = {carry, sum};
end
endfunction

endmodule
