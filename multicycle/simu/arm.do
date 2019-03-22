vlib work

vcom -93 ../src/*.vhd
vcom -93 ../../monocycle/src/ALU.vhd
vcom -93 ../../monocycle/src/banc.vhd
vcom -93 ../../monocycle/src/extensionSigne.vhd
vcom -93 ../../monocycle/src/mux21.vhd
vcom -93 ../../monocycle/src/reg32load.vhd

vcom -93 test_arm.vhd

vsim -novopt test_arm(arc_test_arm)

view signals
add wave -radix decimal -position insertpoint sim:/test_arm/*
add wave -position insertpoint  \
sim:/test_arm/arm_1/MAE1/EtatPresent \
sim:/test_arm/arm_1/MAE1/EtatFutur \
sim:/test_arm/arm_1/MAE1/inst_mem_courante \
sim:/test_arm/arm_1/MAE1/inst_reg_courante

add wave -radix decimal -position insertpoint  \
sim:/test_arm/arm_1/DataPath1/PC \
sim:/test_arm/arm_1/DataPath1/PCIn

add wave -radix decimal -position insertpoint  \
sim:/test_arm/arm_1/DataPath1/BancReg/Banc

run 100 us
