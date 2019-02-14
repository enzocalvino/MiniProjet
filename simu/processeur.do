vlib work
vcom -93 processeur_tb.vhd

vsim -novopt processeur_tb(tb)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal sim:/processeur_tb/Traitement/C1/Banc

run 100 ns