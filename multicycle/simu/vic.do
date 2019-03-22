vlib work

vcom -93 ../src/VIC.vhd

vcom -93 VIC_tb.vhd

vsim -novopt VIC_tb(tb)

view signals
add wave -radix hexadecimal -position insertpoint sim:/VIC_tb/*

run 150 ns
