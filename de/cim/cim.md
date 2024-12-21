https://www.cnblogs.com/sasasatori/p/17973415

# algorithm

以4b * 4b為例子，要做4Cycle

![[dataflow.svg]]

# uarch

以4b(kr) * 1b(im)為例子，衍生推導8b(kr) * 1b(im)

架構特色
1. im(input)用serial，從MSB到LSB
2. im的精度可以隨意，但要知道什麽是Sign的位置
4. kr的精度的基礎是4b
5. krde

![[uarch.svg|1000]]