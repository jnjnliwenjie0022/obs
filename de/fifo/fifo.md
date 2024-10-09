# uarch

FIFO有兩種實作方式
1. Depth: Timing比較好
2. Entry: Latency比較好
    1. 在處理empty fifo read的時候同時write，可以bypass fifo write
    
FIFO的empty和full如果想register out，用使用wr_ptr_nx和rd_ptr_nx去assign full_nx和empty_nx

![[fifo.svg]]

# coding_style
```verilog
wire d1_fifo_wr;
wire d1_fifo_rd;
wire d1_fifo_empty;
wire d1_fifo_full;
wire d1_fifo_wrdy;
wire d1_fifo_rrdy;
wire [UBMC_DATA_BITWIDTH-1:0] d1_fifo_wdata;
wire [UBMC_DATA_BITWIDTH-1:0] d1_fifo_rdata;

assign fme_imacu_d_ready = d1_fifo_wrdy;
assign d1_fifo_wr = d1_fifo_wrdy & fme_imacu_d_ready & fme_imacu_d_valid;
assign d1_fifo_wrdy = ~d1_fifo_full;
assign d1_fifo_rrdy = ~d1_fifo_empty;
assign d1_fifo_wdata = fme_bsacu_d_data;

acc_fifo # (
     .DATA_WIDTH (UBMC_DATA_BITWIDTH )
    ,.FIFO_DEPTH (OUTSTANDING_DEPTH  )
) d1_fifo (
     .reset_n      (aresetn       )
    ,.clk          (aclk          )
    ,.wr           (d1_fifo_wr    )
    ,.wr_data      (d1_fifo_wdata )
    ,.rd           (d1_fifo_rd    )
    ,.rd_data      (d1_fifo_rdata )
    ,.almost_empty (              )
    ,.almost_full  (              )
    ,.empty        (d1_fifo_empty )
    ,.full         (d1_fifo_full  )
);

```