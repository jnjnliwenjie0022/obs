https://www.cnblogs.com/sasasatori/p/17973415
# ref
[[ESSCIRC.2019.8902824.pdf#page=1&selection=0,0,2,60|ESSCIRC.2019.8902824, page 1]]

# algorithm

以4b * 4b為例子，要做4Cycle

![[dataflow.svg]]

# uarch

## basic

以4b(kr) * 1b(im)為例子，衍生推導8b(kr) * 1b(im)

架構特色
1. im(input)用serial，從MSB到LSB
2. im的精度可以隨意，但要知道什麽是Sign的位置
3. im的Sign要特殊處理
4. im的精度如果為1則，Cycle為1，如果為N，Cycle為N
5. pm的signed extension和精度擴張在accumulator處理
6. kr的精度的基礎是4b
7. kr的精度要調整，需要跟臨近的column做處理
8. kr的精度只要調整，就需要一個新的adder和accumulator機制

![[uarch.svg|1000]]

## reconfiguration

下圖是説明這個機制kr精度4b/8b/12b reconfiguration

![[CIM技术经典导读之数字SRAM CIM技术 - sasasatori - 博客园.pdf#page=25&rect=60,40,715,585|CIM技术经典导读之数字SRAM CIM技术 - sasasatori - 博客园, p.25|1000]]