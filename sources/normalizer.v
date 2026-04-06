module normalizer(
    input [7:0]E,
    input [22:0] M,
    input S,
    input sub,
    output [31:0] out
    );
    reg [7:0] shift;
    reg zero;
    always @(*) begin
        if(~|E) begin
            shift = 8'd0;
            zero = |M?1'b0:1'b1;
        end
        else if(sub) begin
            casex (M)
                23'b1xxxxxxxxxxxxxxxxxxxxxx: begin  shift = 8'd1;  zero = 1'b0; end
                23'b01xxxxxxxxxxxxxxxxxxxxx: begin  shift = 8'd2;  zero = 1'b0; end
                23'b001xxxxxxxxxxxxxxxxxxxx: begin  shift = 8'd3;  zero = 1'b0; end
                23'b0001xxxxxxxxxxxxxxxxxxx: begin  shift = 8'd4;  zero = 1'b0; end
                23'b00001xxxxxxxxxxxxxxxxxx: begin  shift = 8'd5;  zero = 1'b0; end
                23'b000001xxxxxxxxxxxxxxxxx: begin  shift = 8'd6;  zero = 1'b0; end
                23'b0000001xxxxxxxxxxxxxxxx: begin  shift = 8'd7;  zero = 1'b0; end
                23'b00000001xxxxxxxxxxxxxxx: begin  shift = 8'd8;  zero = 1'b0; end
                23'b000000001xxxxxxxxxxxxxx: begin  shift = 8'd9;  zero = 1'b0; end
                23'b0000000001xxxxxxxxxxxxx: begin  shift = 8'd10; zero = 1'b0; end
                23'b00000000001xxxxxxxxxxxx: begin  shift = 8'd11; zero = 1'b0; end
                23'b000000000001xxxxxxxxxxx: begin  shift = 8'd12; zero = 1'b0; end
                23'b0000000000001xxxxxxxxxx: begin  shift = 8'd13; zero = 1'b0; end
                23'b00000000000001xxxxxxxxx: begin  shift = 8'd14; zero = 1'b0; end
                23'b000000000000001xxxxxxxx: begin  shift = 8'd15; zero = 1'b0; end
                23'b0000000000000001xxxxxxx: begin  shift = 8'd16; zero = 1'b0; end
                23'b00000000000000001xxxxxx: begin  shift = 8'd17; zero = 1'b0; end
                23'b000000000000000001xxxxx: begin  shift = 8'd18; zero = 1'b0; end
                23'b0000000000000000001xxxx: begin  shift = 8'd19; zero = 1'b0; end
                23'b00000000000000000001xxx: begin  shift = 8'd20; zero = 1'b0; end
                23'b000000000000000000001xx: begin  shift = 8'd21; zero = 1'b0; end
                23'b0000000000000000000001x: begin  shift = 8'd22; zero = 1'b0; end
                23'b00000000000000000000001: begin  shift = 8'd23; zero = 1'b0; end
                23'b00000000000000000000000: begin  shift = 8'd0;  zero = 1'b1; end
                default: begin shift = 8'd0; zero = 1'b1; end
            endcase
        end
        else begin shift = 0 ; zero = 1'b0; end
    end
    assign out = ~zero ?({S, (E-shift), (M<<shift)} ) : 32'b0;
endmodule
