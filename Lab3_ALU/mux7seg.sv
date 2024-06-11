module mux7seg( 
    input logic [39:0] x,
    input logic clk,
    input logic clr,    //clear
    output logic dp,
    output logic [7:0] an,    
    output logic [6:0] a2g );
    
    logic [2:0] s;  
    logic [4:0] digit;
    logic [20:0] clkdiv; 
    
    assign dp = 1;       //DP off
    assign s = clkdiv[20:18];
    
    always_comb
        case(s)
            0: digit = x[4:0]; 
            1: digit = x[9:5];
            2: digit = x[14:10];
            3: digit = x[19:15];
            4: digit = x[24:20];
            5: digit = x[29:25];
            6: digit = x[34:30];
            7: digit = x[39:35];
            default: digit = 5'b0;
        endcase

    always_comb
        case(s)
           0: an = 8'b1111_1110;
           1: an = 8'b1111_1101;
           2: an = 8'b1111_1011;
           3: an = 8'b1111_0111;
           4: an = 8'b1110_1111;
           5: an = 8'b1101_1111;
           6: an = 8'b1011_1111;
           7: an = 8'b0111_1111;
           default: an = 8'b1111_1111;   //off
        endcase
    
    always @(posedge clk, posedge clr)
        if(clr == 1) clkdiv <= 0;
        else         clkdiv <= clkdiv + 1;
        
    hex7seg s7(.data(digit),.a2g(a2g) );
 
endmodule
