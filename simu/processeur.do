vlib work
vcom -93 processeur_tb.vhd

vsim -novopt processeur_tb(tb)

view signals
add wave -radix decimal *

add wave -radix hexadecimal -position insertpoint  \
sim:/processeur_tb/Proc_TB/instruction
add wave -radix decimal -position insertpoint  \
sim:/processeur_tb/Proc_TB/Decode_instruction/instr_courante \

add wave -radix decimal -position insertpoint  \
sim:/processeur_tb/Proc_TB/Unite_Traitement/Banc_comp/Banc \
sim:/processeur_tb/Proc_TB/Unite_Traitement/Data_Memory_comp/Memoire

add wave -radix decimal -position insertpoint  \
sim:/processeur_tb/Proc_TB/Gestion_instruct/PC 

add wave -position insertpoint  \
sim:/processeur_tb/Proc_TB/PSR_reg/WE \
sim:/processeur_tb/Proc_TB/PSR_reg/DataOut \
sim:/processeur_tb/Proc_TB/PSR_reg/DataIn 

add wave -position insertpoint  \
sim:/processeur_tb/Proc_TB/Unite_Traitement/Data_Memory_comp/Addr

run 1100 ns
