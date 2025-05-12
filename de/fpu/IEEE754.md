- ref: https://gregstoll.dyndns.org/~gregstoll/floattohex/
- ref: https://grouper.ieee.org/groups/msc/ANSI_IEEE-Std-754-2019/background/
- ref: https://zhuanlan.zhihu.com/p/480834719

| 類型                   | 符號位 | 指數位  | 尾數位 (MSB) | 尾數其他位   |
| -------------------- | --- | ---- | --------- | ------- |
| 正常數值                 | 任意  | 非全 1 | 任意        | 任意      |
| 無窮大                  | 任意  | 全 1  | 0         | 全 0     |
| QNAN (Quiet NaN)     | 任意  | 全 1  | **1**     | 任意      |
| SNAN (Signaling NaN) | 任意  | 全 1  | **0**     | 至少有一個 1 |

|                                             | IEEE754-2008                                                        | IEEE754-2019                                                                                                                                                                |
| ------------------------------------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Subnorm                                     | 次正規範圍不被完整記錄<br>1.會引發高誤差<br>2.次正規範圍直接視爲0 or 捨去<br>3.不同的運算對次正規範圍的方法不同 | 次正規範圍被完整記錄<br>1.無誤差<br>2.不同的運算對次正規範圍的方法相同                                                                                                                                   |
| Round to Nearest                            | 不作用在subnorm                                                         | 作用在subnorm                                                                                                                                                                  |
| Round to Nearest,<br>Ties to Away from Zero | Not Support                                                         | Support                                                                                                                                                                     |
| Underflow                                   | 定義不完整                                                               | 1.結果進入次正規範圍且無法完整表達結果(R!=0 or S!=0)，Underflow Flag必須設置<br>2.定義tininess，當是tininess，Underflow Flag機制視爲次正規範圍，反之為正規範圍<br>3.正規範圍無Underflow Flag<br>P.S: {R, S}專指IEEE754格式下，而不是數學上 |
| Inexact                                     | 定義不完整                                                               | 只要(R!=0 or S!=0)，Inexact Flag就必須設置                                                                                                                                          |
| Overflow                                    | 定義不完整                                                               | 明確要求表示進入無窮大，Overflow Flag必須設置                                                                                                                                               |
| Compare                                     | 次正規範圍直接視爲0 or 捨去<br>1.會引發高誤差                                        | 次正規範圍被完成記錄<br>1.無誤差<br>                                                                                                                                                     |
| NaN                                         | 定義不完整                                                               | 對NaN的行爲定義更完整<br>1.在排序時，NaN 被認為是「無序的」，不大於、不小於、也不等於任何其他數，包括自己                                                                                                                 |
