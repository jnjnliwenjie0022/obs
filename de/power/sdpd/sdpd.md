


| when(A,B,C,...,etc) | related_pin(X) | pin(Y) | Table             |
| ------------------- | -------------- | ------ | ----------------- |
| 1                   | 0->1           | 0->1   |                   |
|                     | 0->1           | 1->0   |                   |
|                     | 1->0           | 0->1   |                   |
|                     | 1->0           | 1->0   |                   |
|                     | none           | 0->0   | No Internal Power |
|                     | none           | 1->1   | No Internal Power |
|                     | 0->0           | none   | No Internal Power |
|                     | 1->1           | none   | No Internal Power |
