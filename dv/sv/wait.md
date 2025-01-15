ref: https://stackoverflow.com/questions/43492429/how-to-write-uvm-monitor-in-systemverilog

![[Pasted image 20250115185221.png]]

如果wait(A)永遠為true，以forever wait(A)為例，則會lock

wait沒有時間的概念，不要使用wait處理signal (如果真要使用要非常小心)

```verilog
// wait(!vif.rst_n) P.S:這個就不是很好的做法
//{{{ reset_signals
    task reset_signals();
        $display("%0t Before reset ", $realtime);
        $display("rst_n:%0d ", vif.rst_n);

        wait(!vif.rst_n);
        $display("%0t Resetting interface ", $realtime);
        $display("rst_n:%0d ", vif.rst_n);

        vif.req_valid  <= 'b0;
        vif.resp_ready <= 'b0;

        @(posedge vif.rst_n);
        $display("%0t: Reset completed", $realtime);
    endtask : reset_signals
//}}}
```
