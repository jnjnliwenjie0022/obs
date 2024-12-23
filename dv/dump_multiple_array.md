# cadence

# Notice

1D value可以使用[+:]

2D array不可以使用[+:]，RTL compiler會有問題，MSB和LSB會顛倒
# ref
https://verificationguide.com/systemverilog/systemverilog-2d-array/
## method 1

>01
```
xrun -f flist
```
>flist
```
+access+rwc
-input run_batch.tcl
```
>run_batch.tcl
```
database -open waves -into waves.shm -default
probe -memories -create -shm <top_tb> -all -depth all
run
exit
```

## method2

https://blog.csdn.net/messi_cyc/article/details/109599872?spm=1001.2101.3001.4242.4&utm_relevant_index=8

> tb
```
initial begin
	$shm_open("waves.shm");
    $shm_probe(<top_tb>,"ACTM");
end
```