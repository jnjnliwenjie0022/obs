
| 功能 / 訊號                 | APB2        | APB3                     | APB4                           | APB5 / APB-E                           |
| ----------------------- | ----------- | ------------------------ | ------------------------------ | -------------------------------------- |
| 最少傳輸週期                  | 固定 2 cycle  | ≥2 cycle (支援 wait state) | ≥2 cycle (支援 wait state)       | ≥2 cycle (支援 wait state)               |
| Wait state 支援           | ❌           | ✅ `PREADY`               | ✅                              | ✅                                      |
| Error response          | ❌           | ✅ `PSLVERR`              | ✅                              | ✅                                      |
| Byte strobe             | ❌           | ❌                        | ✅ `PSTRB`                      | ✅                                      |
| Protection 訊號           | ❌           | ❌                        | ✅ `PPROT`                      | ✅ (更強化，支援安全/非安全 realm)                 |
| 資料寬度                    | 8/16/32 bit | 8/16/32 bit              | 32/64 bit                      | 32/64 bit                              |
| 典型用途                    | 基本低頻週邊      | 加入 wait/error 的週邊        | 更細緻控制（byte write / protection） | 加入 **安全、功能安全、RME 支援**                  |
| 功能安全 (parity / wake-up) | ❌           | ❌                        | ❌                              | ✅ Interface parity / Wake-up signaling |
| Realm / 安全擴展 (RME)      | ❌           | ❌                        | ❌                              | ✅ 新訊號（如 PNSE），支援 ARMv9 Realm 管理        |


![[ahb2apb_async_detail.svg]]

- 在async_clk中
	- AHB基本上都需要有3個FIFO分別是: address, wdata, rdata
- 在sync_clk中
	- AHB速度快於APB
	- APB需要apb_clk_en
	- 如果APB要response給AHB則
		- 如果有FIFO,總共有3個FIFO, 則問題不大
		- 如果沒FIFO,總共有2個FIFO, 則AHB也需要apb_clk_en

![[ahb2apb_async.svg|500]]