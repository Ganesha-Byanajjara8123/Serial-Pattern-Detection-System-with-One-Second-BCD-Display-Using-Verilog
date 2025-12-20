
module tx_counter (
    input  wire i_clk,
    input  wire i_rst,
    input  wire en,
    output reg  [9:0] count   // counter which is count from 0-9
);

    always @(posedge i_clk) begin
        if (i_rst)
            count <= 10'd0; //initially count set to zero
        else if (en)
            count <= count + 1'b1;  // count start when it enabled
    end

endmodule



