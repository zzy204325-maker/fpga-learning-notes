# 实验 01：按键控制 PL LED

## 目标

按住 PL 用户按键时，D16 点亮；松开时，D16 熄灭。

## 文件

- `led_button.v`：组合逻辑，`assign pl_led = pl_key;`
- `led_button.xdc`：PL 按键 AE14、PL LED AE15，均为 `LVCMOS33`。

## 实际观察

最初使用反相表达式时，按住按键 LED 灭、松开 LED 亮。改为 `assign pl_led = pl_key;` 后，按住亮、松开灭。由这次板上实验推断，D16 的控制信号为低电平点亮；按键按下时也为低电平。

## 学到的知识

1. `assign` 描述组合逻辑：输出随输入变化，没有寄存器保存状态。
2. XDC 把 Verilog 顶层端口对应到芯片实际引脚，并指定 I/O 电平标准。
3. “有效高 / 有效低”应结合板卡电路与实际现象确认。
4. 综合、实现、生成比特流、JTAG 下载是从源码到板上验证的基本流程。

## 在 Vivado 重建

新建 RTL 工程，器件选 `xczu4ev-sfvc784-1-i`。将 `.v` 加入 Design Sources，将 `.xdc` 加入 Constraints。生成比特流后，通过 Hardware Manager 给 `xczu4_0` 下载。
