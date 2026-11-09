# 实验 02：定时闪烁 PL LED

## 目标

使用板上 200 MHz PL 时钟，让 D16 每约 0.5 秒翻转一次；按住 PL 用户按键时熄灭，松开后重新计时并闪烁。

## 文件

- `led_blink.v`：差分时钟输入缓冲、计数器、低有效异步复位与 LED 翻转。默认 `HALF_PERIOD_CYCLES = 100_000_000`。
- `led_blink.xdc`：差分时钟 AE5 / AF5、PL 按键 AE14、PL LED AE15；时钟周期约束 5 ns。
- `tb_led_blink.v`：行为仿真测试文件，将半周期临时设为 10 个时钟周期。

## 实际观察与仿真结果

- 板上：D16 闪烁；按住 PL 按键时熄灭，松开后继续闪烁。这是改成参数化源码之前、但计数终值同为 99,999,999 时观察到的结果。
- Vivado 行为仿真：`rst_n` 在 12 ns 解除复位；`counter` 从 0 数到 9 后回到 0；`pl_led` 约在 57.5 ns 和 107.5 ns 翻转，间隔 50 ns。这验证了参数取 10 时的 RTL 行为。

## 计算与知识点

- 200 MHz 时钟周期为 `1 / 200 MHz = 5 ns`。
- 默认每 100,000,000 个周期翻转一次：`100,000,000 × 5 ns = 0.5 s`；完整亮灭周期约 1 s。
- 仿真覆盖参数为 10：`10 × 5 ns = 50 ns`，所以能很快看到波形。
- `always @(posedge sys_clk or negedge rst_n)` 描述时序逻辑和低电平有效的异步复位。
- `<=` 是非阻塞赋值：计数器归零与 LED 翻转在同一时钟沿更新。
- 行为仿真验证 RTL 逻辑；实现后的时序报告检查所设时钟约束是否满足。此次实现 DRC 为 0 个错误，布线后 WNS 为 +3.307 ns。

## 在 Vivado 重建

新建 RTL 工程，器件选 `xczu4ev-sfvc784-1-i`。将 `led_blink.v` 加入 Design Sources，`led_blink.xdc` 加入 Constraints，`tb_led_blink.v` 加入 Simulation Sources。运行 Behavioral Simulation 可观察 `counter` 与 `pl_led`；上板前再执行综合、实现与生成比特流。JTAG 下载后可按一下并松开 PL 用户按键，重新开始计时。
