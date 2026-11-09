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
        .I  (sys_clk_p),   //差分正端 P（sys_clk_p）
        .IB (sys_clk_n),   //Bar（反相）,差分负端 N（sys_clk_n）
        .O  (sys_clk)      //FPGA 内部时钟（sys_clk）
    );

    always @(posedge sys_clk or negedge rst_n) begin     //在 sys_clk 的上升沿，或者 rst_n 的下降沿到来时，执行 begin ... end 内的电路行为
        if (!rst_n) begin           //!rst_n 表示 rst_n == 0
            counter <= 27'd0;
            pl_led  <= 1'b1;       // 实测：高电平时LED熄灭
        end
        else if (counter == HALF_PERIOD_CYCLES - 1) begin
            counter <= 27'd0;
            pl_led  <= ~pl_led;    // 每0.5秒翻转一次
        end
        else begin
            counter <= counter + 1'b1;//每个时钟上升沿让计数器加 1
        end
    end

endmodule
/*触发 always
    │
    ├─ rst_n = 0？
    │    └─ 是：计数器清零，LED 熄灭
    │
    ├─ 计数器数满？
    │    └─ 是：计数器清零，LED 状态翻转
    │
    └─ 都不是：计数器加 1*/
