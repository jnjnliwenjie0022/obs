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

| Write Policy Combination | Write Hit Policy | Write Miss Policy | Remark                                                                                                                                                                                                 |
| ------------------------ | ---------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Not usual                | Write Through    | Write Allocate    | When write hit: Register write to both cache and memory<br>When write miss: First Cache read from memory then register write to cache and **memory**<br>當miss的時候，需要從memory讀，更新寫回memory，memory bound很嚴重 |
|                          | Write Through    | Write No Allocate | When write hit: Register write to both cache and memory<br>When write miss: Register directly write to memory<br>                                                                                      |
|                          | Write Back       | Write Allocate    | When write hit: Register directly write to cache<br>When write miss: First Cache read from memory then register write to cache<br>當miss的時候，需要從memory讀，更新寫回cache                                        |
| Not usual                | Write Back       | Write No Allocate | When write hit: Register directly write to cache<br>When write miss: Register directly write to memory<br>永遠不會在cache中，write back policy多餘                                                              |
