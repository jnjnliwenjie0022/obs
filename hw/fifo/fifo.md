# uarch

FIFO有兩種實作方式
1. Depth: Timing比較好
2. Entry: Latency比較好
    1. 在處理empty fifo read的時候同時write，可以bypass fifo write
FIFO的empty和full如果想register out，用使用wr_ptr_nx和rd_ptr_nx去assign full_nx和empty_nx


![[fifo.svg]]