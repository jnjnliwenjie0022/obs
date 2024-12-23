# cadence
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

> tb
```
initial begin
	$shm_open("waves.shm");
    $shm_probe(<top_tb>,"ACTM");
end
```