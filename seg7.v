module seg7 (
    input  wire [3:0] bcd,     //input of binary coded decimal
    output reg  [6:0] seg     //7-segment display outputput
);

 // Combinational logic for BCD to 7-segment conversion
    always @(*) begin
        case (bcd)
		// here 1 for OFF and 0 for ON
            4'd0: seg = 7'b1000000;       // which is represents 7-segment display which is a,b,c,d,e,f,g and same for all patterns
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;   //show/set display to zero
        endcase
    end
endmodule
