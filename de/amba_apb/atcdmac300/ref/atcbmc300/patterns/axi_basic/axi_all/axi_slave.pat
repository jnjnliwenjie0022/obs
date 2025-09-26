parameter ERROR_PROBABILITY = 10;

event bch_return_error;
event rch_return_error;
event return_ok;

initial begin : error_resp
	integer	v1, v2;

	`NDS_BENCH.wait_reset_done;

	$display("%0t:%m: Error probability is %0d%", $realtime,
		ERROR_PROBABILITY);

	//$display("%0t:slave start for resp", $time);
	fork: error_resp
		// begin
		// 	`AXI_MASTER1.wait_program_done;
		// 	disable error_resp;
		// end

		// Random response
		// |<-----	  n%        ----->|	
		// |<----- ERROR_PROBABILITY ---->|
		// |<-----       resp        ---->|
		// |    SLVERR    ||    DECERR    |
		// |    (n/2)%    ||    (n/2)%    |

		forever begin
			v1 = {$random(seed)} % 100;

			// $display("%0t:%m: slave rresp random number v1=%0d", $realtime, v1);
			if (v1 < (ERROR_PROBABILITY/2)) begin: set_rresp_slverr
				set_rresp(RESP_SLVERR);
				-> rch_return_error;
				// $display("%0t:%m: slave rresp random number v1=%0d (RRESP_SLVERR)", $realtime, v1);
			end
			else if ((ERROR_PROBABILITY/2) <= v1 &&
				v1 < ERROR_PROBABILITY) begin: set_rresp_decerr
				set_rresp(RESP_DECERR);
				-> rch_return_error;
				// $display("%0t:%m: slave rresp random number v1=%0d (RRESP_DECERR)", $realtime, v1);
			end
			else begin: set_rresp_okay
				set_rresp(0);
				-> return_ok;
			end
		end
		forever begin
			v2 = {$random(seed)} % 100;

			// $display("%0t:%m: slave bresp random number v1=%0d", $realtime, v1);
			if (v2 < (ERROR_PROBABILITY/2)) begin: set_bresp_slverr
				set_bresp(RESP_SLVERR);
				-> bch_return_error;
				// $display("%0t:%m: slave bresp random number v2=%0d (BRESP_SLVERR)", $realtime, v2);
			end
			else if ((ERROR_PROBABILITY/2) <= v2 &&
				v2 < ERROR_PROBABILITY) begin: set_bresp_decerr
				set_bresp(RESP_DECERR);
				-> bch_return_error;
				// $display("%0t:%m: slave bresp random number v2=%0d (BRESP_DECERR)", $realtime, v2);
			end
			else begin: set_bresp_okay
				set_bresp(0);
				-> return_ok;
			end
		end
	join

end

