`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 17:53:30
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder(
    input [31:0] A,B,
    input  sub,
    output reg [31:0] C
    );
    wire [7:0] Ea, Eb;
    wire [22:0] Ma, Mb;
    wire B_31 = sub?~B[31]:B[31];
    assign {Ea,Ma} = A[30:0];
    assign {Eb,Mb} = B[30:0];
    wire [31:0] C1;
    wire m1,m2; // for mux
    wire [22:0] M1, M2;
    reg [22:0] M;
    wire [24:0] Mc; 
    assign M1 = m1? Ma : Mb;
    assign M2 = m1? Mb : Ma;
    wire [22:0] shift_M1;
    wire [7:0] shift;
    wire [1:0] add_ctrl;
    wire [7:0] E;
    reg [7:0] E1;
    wire S;
    wire eq;
    wire exp_zero_a,exp_zero_b;
    wire inf,nan;
    wire zero1,zero2;
    wire sign_same_or_not;
    assign sign_same_or_not = (A[31] ^ B_31);
    assign shift_M1 = (~exp_zero_a | ~exp_zero_b)?({1'b0,M1})>>shift:({1'b1,M1})>>shift;
    int_adder ad(.A(shift_M1), .B(M2), .sub(add_ctrl), .C(Mc), .eq(eq), .exp_zero_a(exp_zero_a), .exp_zero_b(exp_zero_b));
    
    always @(*) begin
        if(|E) begin
            M = (Mc[24])&~sign_same_or_not?((Mc[23:0])>>1):Mc[22:0];
            E1 = Mc[24]&~sign_same_or_not?E+1:E;
        end
        else begin
            M = Mc[22:0];//(Mc[23])&~(A[31] ^ B[31])?(Mc[22:0]):Mc[22:0];
            E1 = Mc[23]&~sign_same_or_not?E+1:E;
        end
    end
    controller ctrl(.Ea(Ea), .Eb(Eb), 
                    .M1(shift_M1), .M2(M2), 
                    .Sa(A[31]), .Sb(B_31), 
                    .add_ctrl(add_ctrl),
                    .m1(m1),
                    .shift(shift),
                    .E(E), .S(S),
                    .exp_eq(eq),
                    .exp_zero_a(exp_zero_a),.exp_zero_b(exp_zero_b),
                    .inf(inf), .nan(nan),
                    .zero1(zero1), .zero2(zero2));    
    normalizer nom(E1,M,S,(~Mc[24]&sign_same_or_not),C1);
    always @(*) begin
        if(nan)
            C = 32'b0_11111111_11111111111111111111111;
        else if(inf)
            C = {S, 31'b11111111_00000000000000000000000};
        else if(zero1)
            C = m1?B:A;
        else if(zero2)
            C = m1?A:B;
        else
            C = C1;
    end
endmodule
