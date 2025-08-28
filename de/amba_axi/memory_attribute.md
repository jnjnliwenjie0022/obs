# bufferable

| Type  | Bufferable | Modifiable | Allocate | Other Allocate | Response Description                                                     |
| ----- | ---------- | ---------- | -------- | -------------- | ------------------------------------------------------------------------ |
| Write | 0          | X          | X        | X              | final destination                                                        |
| Write | 1          | X          | X        | X              | intermediate point                                                       |
| Read  | 0          | 1          | 0        | 0              | final destination                                                        |
| Read  | 1          | 1          | 0        | 0              | intermediate point (write that is progressing to the final destination.) |
| Read  | X          | 0          | X        | X              | final destination                                                        |

# modifiable
