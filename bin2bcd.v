module bin2bcd (
    input  wire [9:0] bin,      
    output reg  [3:0] hundreds,    
    output reg  [3:0] tens,         
    output reg  [3:0] ones         
);

    integer i;                     
    reg [19:0] shift;               
                                    

    // Combinational logic for binary to BCD conversion
    always @(*) begin
        shift = 20'd0;              // Initialize shift register set to zero
        shift[9:0] = bin;           // To load binary value into LSBs of shift register

       
        // Runs once for each bit of the binary input (10 bits)
        for (i = 0; i < 10; i = i + 1) begin

            // If any BCD digit is 5 or more, add 3 before shifting
            // This prevents invalid BCD values after shifting
            if (shift[11:8]  >= 5) shift[11:8]  = shift[11:8]  + 3; // Ones digit correction
            if (shift[15:12] >= 5) shift[15:12] = shift[15:12] + 3; // Tens digit correction
            if (shift[19:16] >= 5) shift[19:16] = shift[19:16] + 3; // Hundreds digit correction

            shift = shift << 1;     // Left shift to bring in next binary bit(from LSB)
        end

        // Extract final BCD digits from shift register
        hundreds = shift[19:16];    
        tens     = shift[15:12];    
        ones     = shift[11:8];    
    end

endmodule

