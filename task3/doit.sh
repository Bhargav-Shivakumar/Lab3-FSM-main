#!/bin/sh

~/Documents/iac/lab0-devtools/tools/attach_usb.sh

rm -rf obj_dir
rm -f f1.vcd

verilator -Wall --cc --trace f1.sv f1_fsm.sv clktick.sv --exe f1_tb.cpp

make -j -C obj_dir/ -f Vf1.mk Vf1

obj_dir/Vf1
