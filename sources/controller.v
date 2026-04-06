`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2026 08:18:36
// Design Name: 
// Module Name: controller
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


module controller(
    input [7:0]  Ea,Eb,             //exponent terms
    input [22:0] M1, M2,
    input        Sa, Sb,
    output reg [1:0] add_ctrl,
    output m1,
    output [7:0] shift,
    output [7:0] E,
    output S,
    output exp_eq, exp_zero_a, exp_zero_b,
    output inf, nan,
    output zero1, zero2
    );
    wire exp_ls,exp_gt;  // wires for comparing of exponent
    wire M_ls,M_gt,M_eq;
    wire S1,S2;
    wire [7:0] E1,E2;
    wire inf_1, inf_2;
    wire nan_1, nan_2;
    wire exp_eq1;
    reg S_reg;
    wire exp_zero_not_both;
    assign exp_zero_not_both = (exp_zero_a ^ exp_zero_b);
    assign exp_eq = ~exp_eq1& exp_zero_not_both? (Ea == 8'b1)|(Eb == 8'b1):exp_eq1;
    comparator comp0(.A({15'b0,Ea}), .B({15'b0,Eb}), .ls(exp_ls), .eq(exp_eq1), .gt(exp_gt));
    comparator comp1(.A(M1), .B(M2), .ls(M_ls), .eq(M_eq), .gt(M_gt));
    assign S1 = m1 ? Sa : Sb;
    assign S2 = m1 ? Sb : Sa;
    assign E1 = m1 ? Ea : Eb;
    assign E2 = m1 ? Eb : Ea;
    assign m1 = (~|Ea)&(~|Eb[7:1] & Eb[0]) ? 1'b0:(~|Eb)&(~|Ea[7:1] & Ea[0])?1'b1:exp_ls;
    assign shift = exp_zero_not_both ? (exp_ls ? Eb - Ea - 8'b1: Ea - Eb - 8'b1) :(exp_ls ? Eb - Ea: Ea - Eb);
    assign E = (~|Ea)&(~|Eb[7:1] & Eb[0])|(~|Eb)&(~|Ea[7:1] & Ea[0])|(exp_eq&(~|Ea[7:1] & Ea[0]))?8'b0:exp_ls? Eb : Ea;
    assign exp_zero_a = |E1;
    assign exp_zero_b = |E2; 
    always @(*) begin
        if(Sa^Sb) begin
            add_ctrl = exp_eq?(M_ls&~exp_zero_not_both?2'b11:2'b01):2'b10;
            S_reg = exp_ls ? Sb : exp_gt?Sa: M_ls?S2:S1;
        end
        else begin
            add_ctrl = 2'b00;
            S_reg = Sa;
        end
    end
    assign zero1 = (~exp_zero_a)&(~|M1);
    assign zero2 = (~exp_zero_b)&(~|M2);
    assign S = inf_1 ? S1 : inf_2 ? S2 : S_reg; 
    assign inf_1 = &E1;
    assign inf_2 = &E2;
    assign nan_1 = inf_1 & (|M1);
    assign nan_2 = inf_2 & (|M2);
    assign inf = inf_1 | inf_2;
    assign nan = nan_1 | nan_2 | (inf_1 & inf_2 & (S1^S2)); 
    
endmodule
