

vlib work
vcom -93 ../src/top_trait_unit.vhd
vcom -93 top_trait_unit_tb.vhd

vsim -novopt top_trait_unit_tb(TB)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal sim:/unite_trait_tb/C0/C0/Banc
run 100 ns
