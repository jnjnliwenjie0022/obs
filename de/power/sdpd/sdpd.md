# internal_power_cell

| case | when(A,B,C,...,etc) | related_pin(X) | pin(Y) | Table             |
| ---- | ------------------- | -------------- | ------ | ----------------- |
| #1   | 1                   | 0->1           | 0->1   | rise_power        |
| #2   | 1                   | 0->1           | 1->0   | rise_power        |
| #3   | 1                   | 1->0           | 0->1   | fall_power        |
| #4   | 1                   | 1->0           | 1->0   | fall_power        |
| #5   | 1                   | none           | 0->0   | No Internal Power |
| #6   | 1                   | none           | 1->1   | No Internal Power |
| #7   | 1                   | 0->0           | none   | No Internal Power |
| #8   | 1                   | 1->1           | none   | No Internal Power |
- #1 - #4 暗示 input 和 output 都要改變才有 internal power
- #5 and #6 暗示 output 如果不改變，只有input改變，對internal power影響不大
- #7 and #8 表示 input 不改改變，就不會有internal power
# internal_power_reg

| case | related_pin(D) | pin(CLK) | Table             | value             |
| ---- | -------------- | -------- | ----------------- | ----------------- |
| #1   | 0->1           | 0->1     | fall_power        | data_toggle       |
| #2   | 0->1           | 1->0     | rise_power        | data_toggle       |
| #3   | 1->0           | 0->1     | fall_power        | data_toggle       |
| #4   | 1->0           | 1->0     | rise_power        | data_toggle       |
| #5   | none           | 0->0     | No Internal Power | No Internal Power |
| #6   | none           | 1->1     | No Internal Power | No Internal Power |
| #7   | 0->0           | 0->1     | fall_power        | no_data_toggle    |
| #8   | 0->0           | 1->0     | rise_power        | no_data_toggle    |
| #9   | 1->1           | 0->1     | fall_power        | no_data_toggle    |
| #10  | 1->1           | 1->0     | rise_power        | no_data_toggle    |
- Q與internal power完全無關，Q只有switch power有關
- CLK只要有變動就有internal power
