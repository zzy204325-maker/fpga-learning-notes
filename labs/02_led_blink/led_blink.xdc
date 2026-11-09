set_property PACKAGE_PIN AE5 [get_ports sys_clk_p]
set_property PACKAGE_PIN AF5 [get_ports sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {sys_clk_p sys_clk_n}]
create_clock -name sys_clk_200m -period 5.000 [get_ports sys_clk_p]

set_property PACKAGE_PIN AE14 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

set_property PACKAGE_PIN AE15 [get_ports pl_led]
set_property IOSTANDARD LVCMOS33 [get_ports pl_led]
