module ALU_Top(
    input logic CLK100MHZ,
    input logic [15:0] SW,
    input logic BTNC,
    output logic DP,
    output logic [7:0] AN,
    output logic [6:0] A2G);
    
    logic [2:0] alusel;
    logic [3:0] a, b, y;
    logic cin, cout;
    logic [39:0] x;     //������������Ϊ����5λdigit x���ܳ���Ϊ40λ
    
    assign alusel = SW[15:13];  //SW[15],SW[14],SW[13] �ֱ�ΪS1��S0��M
    assign a=SW[12:9];          //SW[12:9]��Ϊa��ֵ
    assign b=SW[8:5];           //SW[8:5]��Ϊb��ֵ
    assign cin=SW[4];           //SW[4]��Ϊcin��ֵ
    
    ALU alu(a,b,alusel,cin,y,cout);
    
    logic [4:0] ADD, SUB, EQU, OFF;
    assign ADD=5'b10000;
    assign SUB=5'b10001;
    assign EQU=5'b10010;
    assign OFF=5'b10011;
    
    always_comb
        case(alusel)    
            3'b000: x={{1'b0,a},{4{OFF}},EQU,OFF,{1'b0,y}};       //y=not a
            3'b010: x={{1'b0,a},OFF,{1'b0,b},OFF,OFF,EQU,OFF,{1'b0,y}};      //y=a and b
            3'b100: x={{1'b0,a},OFF,{1'b0,b},OFF,OFF,EQU,OFF,{1'b0,y}};       //y=a or b
            3'b110: x={{1'b0,a},OFF,{1'b0,b},OFF,OFF,EQU,OFF,{1'b0,y}};      //y=a^b;
            3'b001: x={{1'b0,a},ADD,{1'b0,b},ADD,{4'b0,cin},EQU,{4'b0,cout},{1'b0,y}};      //y=a+b+cin
            3'b011: x={{1'b0,a},SUB,{1'b0,b},SUB,{4'b0,cin},EQU,{4'b0,cout},{1'b0,y}};      //y=a-b-cin
            default:x={8{OFF}};
        //101 111δʹ��
        endcase
    
    mux7seg x7(x,CLK100MHZ,BTNC,DP,AN,A2G);
    
endmodule
