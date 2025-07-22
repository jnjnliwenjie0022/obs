
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
- #5 and #6 暗示 output 如果不改變，只有input改變，對internal power影響不大
- #7 and #8 表示 input 不改改變，就不會有internal power


| case | related_pin(D) | pin(CLK) | Table             |
| ---- | -------------- | -------- | ----------------- |
| #1   | 0->1           | 0->1     | rise_power        |
| #2   | 0->1           | 1->0     | rise_power        |
| #3   | 1->0           | 0->1     | fall_power        |
| #4   | 1->0           | 1->0     | fall_power        |
| #5   | none           | 0->0     | No Internal Power |
| #6   | none           | 1->1     | No Internal Power |
| #7   | 0->0           | none     | No Internal Power |
| #8   | 1->1           | none     | No Internal Power |
