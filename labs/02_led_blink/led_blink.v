module led_blink #(
    parameter integer HALF_PERIOD_CYCLES = 100_000_000
) (
    input  wire sys_clk_p,
    input  wire sys_clk_n,
    input  wire rst_n,
    output reg  pl_led
);

    wire sys_clk;
    reg [26:0] counter = 27'd0;

    // 将板上的200 MHz差分时钟转换为FPGA内部时钟
    IBUFDS clk_buffer (
        .I  (sys_clk_p),
        .IB (sys_clk_n),
        .O  (sys_clk)
    );

    always @(posedge sys_clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 27'd0;
            pl_led  <= 1'b1;       // 实测：高电平时LED熄灭
        end
        else if (counter == HALF_PERIOD_CYCLES - 1) begin
            counter <= 27'd0;
            pl_led  <= ~pl_led;    // 每0.5秒翻转一次
        end
        else begin
            counter <= counter + 1'b1;
        end
    end

endmodule
