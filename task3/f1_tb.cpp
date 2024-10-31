#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1.h"
#include "vbuddy.cpp"     // include vbuddy code

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vf1* top = new Vf1;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("f1.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("L3T3 - F1 FSM");

  // initialize simulation input 
  top->clk = 1;
  top->rst = 0;
  top->en = vbdFlag();
  top->N = vbdValue(); //30 for 1 second delay

  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    vbdBar(top->data_out & 0xFF);
    top->en = vbdFlag();
    top->N = vbdValue();
    vbdCycle(simcyc);

    // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
      exit(0);
  }

  vbdClose();   
  tfp->close(); 
  printf("Exiting\n");
  exit(0);
}