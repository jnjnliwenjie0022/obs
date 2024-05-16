# ref
http://media.ee.ntu.edu.tw/courses/msoc/slide.html

SC_METHOD: combination logic
SC_THREAD: register
# ready_queue
wait (context switch point)
multiple process是由single process模擬
```
--wait-------------------------------------|
-------wait--------------------------------|--->ready_queue
------------wait---------------------------|
                                          ^
                                          |
-------------------------------------notify|
```
# race_condition
Andes arch team recommand:
1. wait(SC_ZERO_TIME); // wait delta time 0+ 
2. event trigger (Recommand !!)
# outstanding
[SystemC/TLM: blocking & non-blocking transport_target socket-CSDN博客](https://blog.csdn.net/zgcjaxj/article/details/126512927)
Andes arch team recommand:

non-blocking
ready behavior use wait and notify to implement
4 process
	us: (A,D)
	ds: (A,D)
![[Pasted image 20240510170535.png]]
blocking
![[Pasted image 20240510170505.png]]
# port
Andes arch team recommand:
只有用到simple_.*
![[Pasted image 20240510155959.png]]