module serial_detector (
    input  wire i_clk,
    input  wire i_rst,
    input  wire sdata,                            //serial data at reciever side
    output reg  hit                               //hit when My BDAY(110010100) matched
);

    reg [8:0] shift_reg;                          // to store 9-bits
    localparam [8:0] PATTERN = 9'b110010100;      // My BDAY 12/20

    always @(posedge i_clk) begin
        if (i_rst) begin
            shift_reg <= 9'd0;                    //initally shift_reg set to zero                
            hit       <= 1'b0;                    //hit also set to zero
        end else begin
            shift_reg <= {sdata, shift_reg[8:1]}; // new 1-bit and old bit is 8. 
            hit <= (shift_reg == PATTERN);        // hit will becomes 1 when shift_reg equally matched with PATTERN(BDAY)
        end
    end

endmodule

