# uarch

以下為RAM BANK的最基礎結構，所有延伸結構都是透過以下結構延伸。

![[ram.svg]]

step1:
1. RAM的read是完整的pipeline結構
2. RAM的write是不完整的pipeline結構  

step2:
1. 因為read和write都是pipeline結構，所以可以分成兩級pipeline stage，A Phase和D Phase

step3:
1. A Phase 同時有read address 和 write address行為，所以必然只有一個行為可以處理。
2. read的行為因為分成A Phase和D Phase所以ACCESS Signal和DATA必然會落後，永遠不可能同時，如果同時表示ACCESS兩次，此行為違反一件事情。

step4:
1. 違反FIFO的interface protocol，表示純粹的RAM無法實現FIFO的行為

設計概念:
1. RAM的protocol只能使用將A和D Channel分開的Interface
    1. AXI, TileLink
    2. Pipeline
2. 建議簡單的結構可以用pipeline結構思考
3. 建議困難的結構使用A和D Channel分開的結構，以及引入Master和Slave的方式思考