module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out
);

//define the states
typedef enum {s0, s1, s2, s3, s4, s5, s6, s7, s8} my_state;
my_state current_state, next_state;

//next state logic
always_comb
    case (current_state)
        s0: if(en) next_state = s1;
            else next_state = current_state;
        s1: if(en) next_state = s2;
            else next_state = current_state;
        s2: if(en) next_state = s3;
            else next_state = current_state;
        s3: if(en) next_state = s4;
            else next_state = current_state;
        s4: if(en) next_state = s5;
            else next_state = current_state;
        s5: if(en) next_state = s6;
            else next_state = current_state;
        s6: if(en) next_state = s7;
            else next_state = current_state;
        s7: if(en) next_state = s8;
            else next_state = current_state;
        s8: if(en) next_state = s0;
            else next_state = current_state;
        default: next_state = s0;
    endcase

//state transition
always_ff @(posedge clk)
    if (rst) current_state <= s0;
    else current_state <= next_state;

//output logic
always_comb
    case (current_state)
        s0: data_out = 8'b0;
        s1: data_out = 8'b00000001;
        s2: data_out = 8'b00000011;
        s3: data_out = 8'b00000111;
        s4: data_out = 8'b00001111;
        s5: data_out = 8'b00011111;
        s6: data_out = 8'b00111111;
        s7: data_out = 8'b01111111;
        s8: data_out = 8'b11111111;
        default: data_out = 8'b0;
    endcase
endmodule
