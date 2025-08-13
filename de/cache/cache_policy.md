- ref: https://www.cnblogs.com/arnoldlu/p/14522564.html

- Read / Write Policy: 

|       | When | Policy            |                                                            |
| ----- | ---- | ----------------- | ---------------------------------------------------------- |
| Read  | Hit  |                   | Register directly read from cache                          |
| Read  | Miss | Read Through      | Register directly read from memory                         |
| Read  | Miss | Read Allocate     | First Cache read from memory then register read from cache |
| Write | Hit  | Write Through     | Register write to both cache and memory                    |
| Write | Hit  | Write Back        | Register directly write to cache                           |
| Write | Miss | Write Allocate    | First Cache read from memory then register write to cache  |
| Write | Miss | Write No Allocate | Register directly write to memory                          |
- Write Policy Combination

| Write Policy Combination | Write Hit Policy | Write Miss Policy | Remark |
| ------------------------ | ---------------- | ----------------- | ------ |
| Not usual                | Write Through    | Write Allocate    |        |
|                          | Write Through    | Write No Allocate |        |
|                          | Write Back       | Write Allocate    |        |
| Not usual                | Write Back       | Write No Allocate |        |
