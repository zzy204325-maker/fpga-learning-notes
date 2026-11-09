`timescale 1ns / 1ps

module tb_led_blink;
    reg  sys_clk_p = 1'b0;
    wire sys_clk_n = ~sys_clk_p;
    reg  rst_n = 1'b0;
    wire pl_led;

    // 5 ns 一个周期，相当于 200 MHz 时钟
    always #2.5 sys_clk_p = ~sys_clk_p;

    led_blink #(
        .HALF_PERIOD_CYCLES(10)
    ) dut (
        .sys_clk_p(sys_clk_p),
        .sys_clk_n(sys_clk_n),
        .rst_n(rst_n),
        .pl_led(pl_led)
    );

    initial begin
        #12 rst_n = 1'b1;  // 松开按键，结束复位
        #120;
        $finish;
    end
endmodule
