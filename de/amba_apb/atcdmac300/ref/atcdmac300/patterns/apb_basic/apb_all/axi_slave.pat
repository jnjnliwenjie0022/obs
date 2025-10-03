event bch_return_error;
event rch_return_error;
event return_ok;

initial begin : error_resp
integer	v;

	`NDS_BENCH.wait_reset_done;

	$display("%0t:%m:Error probability is %0d%", $realtime, `NDS_ERROR_PROBABILITY);

	//$display("%0t:slave start for resp", $time);
	fork: error_resp
		begin
			`APB_MASTER1.wait_program_done;
			disable error_resp;
		end
		forever begin
			v = {$random(seed)} % 100;

			// random response

			// |<-----	  n%        ----->|	
			// |<----- ERROR_PROBABILITY ---->|
			// |<---SLVERR--->||<---DECERR--->|
			// |<---(n/2)%--->||<---(n/2)%--->|

			// $display("DBG: slave1 resp random number v=%0d", v);
			if (v < (`NDS_ERROR_PROBABILITY/2)) begin: set_rresp_slverr
				set_rresp(RESP_SLVERR);
				-> rch_return_error;
				 $display("DBG: slave1 resp random number v=%0d 0 < v < %0d (RRESP_SLVERR)", v, `NDS_ERROR_PROBABILITY/2);
			end
			else if (((`NDS_ERROR_PROBABILITY/2) < v) && (v < `NDS_ERROR_PROBABILITY)) begin: set_rresp_decerr
				set_rresp(RESP_DECERR);
				-> rch_return_error;
				 $display("DBG: slave1 resp random number v=%0d %0d < v < %0d (RRESP_DECERR)", v, `NDS_ERROR_PROBABILITY/2, `NDS_ERROR_PROBABILITY);
			end
			else begin: set_rresp_okay
				set_rresp(0);
				-> return_ok;
			end

			if (v < (`NDS_ERROR_PROBABILITY/2)) begin: set_bresp_slverr
				set_bresp(RESP_SLVERR);
				-> bch_return_error;
				 $display("DBG: slave1 resp random number v=%0d 0 < v < %0d (BRESP_SLVERR)", v, `NDS_ERROR_PROBABILITY/2);
			end
			else if (((`NDS_ERROR_PROBABILITY/2) < v) && (v < `NDS_ERROR_PROBABILITY)) begin: set_bresp_decerr
				set_bresp(RESP_DECERR);
				-> bch_return_error;
				 $display("DBG: slave1 resp random number v=%0d %0d < v < %0d (BRESP_DECERR)", v, `NDS_ERROR_PROBABILITY/2, `NDS_ERROR_PROBABILITY);
			end
			else begin: set_bresp_okay
				set_bresp(0);
				-> return_ok;
			end
		end
	join

end

