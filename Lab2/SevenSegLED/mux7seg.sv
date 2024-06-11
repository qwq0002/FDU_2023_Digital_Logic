`timescale 1ns / 1ps

module mux7seg( 
    input logic [15:0] x,
    input logic clk,
    input logic clr,
    output logic dp,
    output logic [3:0] an,
    output logic [6:0] a2g );
    
    logic [1:0] s;
    logic [3:0] digit;
    logic [19:0] clkdiv;
    
    assign DP =1;   //DP off
    assign s = clkdiv[19:18];   //count every 10.4ms
    
    //mux4
    always_comb
        case(s)
            0: digit = x[3:0];
            1: digit = x[7:4];
            2: digit = x[11:8];
            3: digit = x[15:12];
            default: digit = x[3:0];
        endcase;

    always_comb
        case(s)
           0: an = 4'b1110;
           1: an = 4'b1101;
           2: an = 4'b1011;
           3: an = 4'b0111;
           default: an = 4'b1110;
        endcase
    
    always @(posedge clk, posedge clr)
        if(clr == 1) clkdiv <= 0;
        else         clkdiv <= clkdiv + 1;
        
    Hex7Seg s7(.data(digit),.a2g(a2g) );
 
endmodule
