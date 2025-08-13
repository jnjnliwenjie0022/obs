- ref: https://www.cnblogs.com/arnoldlu/p/14522564.html


|       | When | Policy        |                                                          |
| ----- | ---- | ------------- | -------------------------------------------------------- |
| Read  | Hit  |               | Register directly access from cache                      |
| Read  | Miss | Read Through  | Register directly access from memory                     |
| Read  | Miss | Read Allocate | Cache access from memory then register access from cache |
| Write | Hit  | Write Through | Write to                                                 |
| Write | Hit  | Write Back    |                                                          |
