

vlib work
vcom -93 ../src/banc.vhd
vcom -93 ../src/ALU.vhd
vcom -93 ../src/mux21.vhd
vcom -93 ../src/extensionSigne.vhd
vcom -93 ../src/memoireDonnees.vhd
vcom -93 ../src/top_trait_unit.vhd
vcom -93 top_trait_unit_tb.vhd

vsim -novopt top_trait_unit_tb

view signals
add wave -radix decimal *
add wave -position insertpoint  \
sim:/top_trait_unit_tb/C0/Banc_comp/Banc

run -all
