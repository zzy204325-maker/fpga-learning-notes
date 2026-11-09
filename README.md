# FPGA 学习记录

使用 ALINX AXU4EVB-P V3.0（Zynq UltraScale+ MPSoC）学习 FPGA 的实验记录。开发环境为 Vivado 2025.2 ML Standard；现有工程选择的器件为 `xczu4ev-sfvc784-1-i`。

## 实验索引

| 序号 | 实验 | 主要知识 | 记录 |
| --- | --- | --- | --- |
| 01 | 按键控制 PL LED | 组合逻辑、引脚约束、电平极性、JTAG 下载 | [实验记录](labs/01_button_led/README.md) |
| 02 | 定时闪烁 PL LED | 差分时钟、计数器、时序逻辑、复位、仿真、参数 | [实验记录](labs/02_led_blink/README.md) |

每个实验目录保存手写的 Verilog、XDC 和必要的测试文件。Vivado 自动生成的缓存、运行目录和比特流不纳入版本控制；在 Vivado 中按实验记录重新建立工程即可。

## 板卡信息与注意点

- PL 差分时钟：200 MHz，`sys_clk_p` 为 AE5，`sys_clk_n` 为 AF5。
- PL 用户按键：AE14，按下为低电平。
- PL 用户 LED：AE15。本板实际实验中，输出低电平时 D16 亮，高电平时灭；这条极性结论来自板上观察。
- 厂商资料：[AXU4EVB-P 用户手册](https://www.alinx.com/public/upload/file/AXU4EVB-P_UG.pdf)。引脚使用前应与实际板卡版本和手册核对。

## 回顾方法

先读实验目录中的目标、硬件现象与关键知识，再阅读 `.v` 和 `.xdc` 文件。想重新上板时，在 Vivado 中新建对应器件的 RTL 工程，添加设计源与约束，依次执行综合、实现、生成比特流，并通过 Hardware Manager 下载。实验 02 还可以添加测试文件并运行 Behavioral Simulation。
