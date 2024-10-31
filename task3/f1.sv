module f1 #(
    parameter   WIDTH = 16,
                D_WIDTH = 8

)(
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    input   logic [WIDTH-1:0] N,
    output  logic       tick,
    output  logic [D_WIDTH-1:0] data_out
);

clktick clock(
    .clk (clk),
    .en (en),
    .rst (rst),
    .tick (tick),
    .N (N)
);

f1_fsm fsm(
    .clk (clk),
    .en (tick),
    .rst (rst),
    .data_out (data_out)
);
endmodule
