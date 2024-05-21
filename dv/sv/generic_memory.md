個人建議使用associative array作為generic memory的memory implementation
```verilog
int mem[longint]; // longint index (is better)
//int mem[*]; // wildcard index
longint index;

index = 2**33;
mem[index] = 1;

$display("%x, a_array[%x] = %x",mem.exists(index),index,mem[index]);
```