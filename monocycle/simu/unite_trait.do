

vlib work
vcom -93 ../src/banc.vhd
vcom -93 ../src/ALU.vhd
vcom -93 ../src/unite_trait.vhd
vcom -93 unite_trait_tb.vhd

vsim -novopt unite_trait_tb(TB)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal sim:/unite_trait_tb/C0/C0/Banc
run 100 ns
