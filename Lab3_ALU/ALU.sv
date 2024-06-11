module ALU( 
    input logic [3:0] a, b,
    input logic [2:0] alusel,   //alusel={S1,S0,M}
    input logic cin,
    output logic [3:0] y,
    output logic cout);
    
    logic [4:0] temp; 
    always_comb
    begin
        temp=5'b00000;
        cout=0;
        case(alusel)    
            3'b000: y=~a;       //y=not a
            3'b010: y=a&b;      //y=a and b
            3'b100: y=a|b;      //y=a or b
            3'b110: y=a^b;       //y=a^b;
            3'b001: 
                begin
                    temp={1'b0,a}+{1'b0,b}+cin;
                    cout=temp[4];
                    y=temp[3:0];
                end      
            3'b011: 
                begin
                    temp={1'b0,a}-{1'b0,b}-cin;
                    cout=temp[4];                   //if a<b cout=1
                    y=temp[3:0];
                end      
            default:y=4'b0000;
        endcase
    end
    
endmodule
