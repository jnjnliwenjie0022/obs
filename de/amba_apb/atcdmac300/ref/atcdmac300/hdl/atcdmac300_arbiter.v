`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_arbiter ( //VPERL: &PORTLIST;
                            // VPERL_GENERATED_BEGIN
                            	  ch_request,
                            	  ch_level, 
                            	  current_channel,
                            	  granted_channel 
                            // VPERL_GENERATED_END
);

input	[7:0]	ch_request;
input	[7:0]	ch_level;
input	[2:0]	current_channel;	

output 	[2:0]	granted_channel;
wire	[2:0]	granted_channel;
reg	[2:0]	l0_granted_channel;
reg	[2:0]	l1_granted_channel;
wire	[7:0]	l0_ch_request;
wire	[7:0]	l1_ch_request;
wire		l1_ch_request_exist;

assign	l1_ch_request_exist = |l1_ch_request;
assign	l1_ch_request = ch_request & ch_level;
assign	l0_ch_request = ch_request & ~ch_level;
assign	granted_channel = l1_ch_request_exist ? l1_granted_channel : l0_granted_channel;	

// VPERL_BEGIN
// :always @(*) begin
// :	case(current_channel)
// my $ch_num = 8;
// for ($i=1; $i<$ch_num; $i++) {
// :		3'h${i}: begin
// 	for($j=0; $j<$ch_num; $j++) {
// 		if ($j==0) {
// :			if (l0_ch_request[%d]) l0_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 		} else  {
// 			if ($j == $ch_num-1) {
// :			else l0_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num
// 			} else {
// :			else if (l0_ch_request[%d]) l0_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 			}
// 		}
// 	}
// :		end
// }
// :		default: begin //channel 0
// 	for($i=0; $i<$ch_num; $i++) {
// 		if ($i==0) {
// :			if (l0_ch_request[%d]) l0_granted_channel = 3'h%d; :: ($i+1)%$ch_num, ($i+1)%$ch_num
// 		} else { 
// 			if ($i == $ch_num-1) {
// :			else l0_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num
// 			} else {
// :			else if (l0_ch_request[%d]) l0_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 			}
// 		}
// 	}
// :		end
// :	endcase
// :end
// :always @(*) begin
// :	case(current_channel)
// my $ch_num = 8;
// for ($i=1; $i<$ch_num; $i++) {
// :		3'h${i}: begin
// 	for($j=0; $j<$ch_num; $j++) {
// 		if ($j==0) {
// :			if (l1_ch_request[%d]) l1_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 		} else  {
// 			if ($j == $ch_num-1) {
// :			else l1_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num
// 			} else {
// :			else if (l1_ch_request[%d]) l1_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 			}
// 		}
// 	}
// :		end
// }
// :		default: begin //channel 0
// 	for($i=0; $i<$ch_num; $i++) {
// 		if ($i==0) {
// :			if (l1_ch_request[%d]) l1_granted_channel = 3'h%d; :: ($i+1)%$ch_num, ($i+1)%$ch_num
// 		} else { 
// 			if ($i == $ch_num-1) {
// :			else l1_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num
// 			} else {
// :			else if (l1_ch_request[%d]) l1_granted_channel = 3'h%d; :: ($i+$j+1)%$ch_num, ($i+$j+1)%$ch_num
// 			}
// 		}
// 	}
// :		end
// :	endcase
// :end
// VPERL_END

// VPERL_GENERATED_BEGIN
always @(*) begin
	case(current_channel)
		3'h1: begin
			if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else l0_granted_channel = 3'h1;
		end
		3'h2: begin
			if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else l0_granted_channel = 3'h2;
		end
		3'h3: begin
			if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else l0_granted_channel = 3'h3;
		end
		3'h4: begin
			if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else l0_granted_channel = 3'h4;
		end
		3'h5: begin
			if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else l0_granted_channel = 3'h5;
		end
		3'h6: begin
			if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else l0_granted_channel = 3'h6;
		end
		3'h7: begin
			if (l0_ch_request[0]) l0_granted_channel = 3'h0;
			else if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else l0_granted_channel = 3'h7;
		end
		default: begin //channel 0
			if (l0_ch_request[1]) l0_granted_channel = 3'h1;
			else if (l0_ch_request[2]) l0_granted_channel = 3'h2;
			else if (l0_ch_request[3]) l0_granted_channel = 3'h3;
			else if (l0_ch_request[4]) l0_granted_channel = 3'h4;
			else if (l0_ch_request[5]) l0_granted_channel = 3'h5;
			else if (l0_ch_request[6]) l0_granted_channel = 3'h6;
			else if (l0_ch_request[7]) l0_granted_channel = 3'h7;
			else l0_granted_channel = 3'h0;
		end
	endcase
end
always @(*) begin
	case(current_channel)
		3'h1: begin
			if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else l1_granted_channel = 3'h1;
		end
		3'h2: begin
			if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else l1_granted_channel = 3'h2;
		end
		3'h3: begin
			if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else l1_granted_channel = 3'h3;
		end
		3'h4: begin
			if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else l1_granted_channel = 3'h4;
		end
		3'h5: begin
			if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else l1_granted_channel = 3'h5;
		end
		3'h6: begin
			if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else l1_granted_channel = 3'h6;
		end
		3'h7: begin
			if (l1_ch_request[0]) l1_granted_channel = 3'h0;
			else if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else l1_granted_channel = 3'h7;
		end
		default: begin //channel 0
			if (l1_ch_request[1]) l1_granted_channel = 3'h1;
			else if (l1_ch_request[2]) l1_granted_channel = 3'h2;
			else if (l1_ch_request[3]) l1_granted_channel = 3'h3;
			else if (l1_ch_request[4]) l1_granted_channel = 3'h4;
			else if (l1_ch_request[5]) l1_granted_channel = 3'h5;
			else if (l1_ch_request[6]) l1_granted_channel = 3'h6;
			else if (l1_ch_request[7]) l1_granted_channel = 3'h7;
			else l1_granted_channel = 3'h0;
		end
	endcase
end
// VPERL_GENERATED_END

endmodule
