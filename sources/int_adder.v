`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:35:44
// Design Name: 
// Module Name: int_adder
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


module int_adder(
    input [22:0] A,B,
    input [1:0] sub,
    input eq, exp_zero_a, exp_zero_b,
    output reg [24:0] C 
    );
    wire [23:0] A1, B1;
    assign A1 = ~exp_zero_a | ~eq ? {1'b0, A} : {1'b1,A};
    assign B1 = ~exp_zero_b ? {1'b0, B} : {1'b1,B};
    always @(*) begin
        case(sub)
            2'b00: C = A1 + B1;
            2'b01: C = A1 - B1;
            2'b10: C = B1 - A1;
            2'b11: C = B - A;
            default: C = A + B;
        endcase
    end
endmodule
