vlib work

vcom -93 unite_gestion_tb.vhd

vsim -novopt unite_gestion_tb(TB)

view signals
add wave -radix hexadecimal *

add wave -radix decimal -position insertpoint  \
sim:/unite_gestion_tb/C0/C2/PC

run 100 ns
