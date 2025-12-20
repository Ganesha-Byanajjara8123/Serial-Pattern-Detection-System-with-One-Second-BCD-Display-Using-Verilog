module serial_transmitter (
    input  wire i_clk,
    input  wire i_rst,
    input  wire en,
    input  wire [9:0] pdata,             //for parallel data transmitting
    output reg  sdata,                  //for serial data
    output reg  ready                   //after every 10 bits (0-9) ready going to 1 then it start again from 0
);

    reg [3:0] bit_cnt;                  //bit_cnt which is counts from 0-9

    always @(posedge i_clk) begin
        if (i_rst) begin
            bit_cnt <= 4'd0;            //Initially set to zero(bit_cnt, sdata, ready)
            sdata   <= 1'b0;
            ready   <= 1'b0;
        end else if (en) begin
            sdata <= pdata[bit_cnt];     //pdata take random bits from bit_cnt then send to sdata 
            ready <= 1'b0;               //ready should be zero untill 9-bits complets

            if (bit_cnt == 4'd9) begin   //when bit_cnt reach 9-bits then
                bit_cnt <= 4'd0;         //it again set to zero
                ready   <= 1'b1;         //Now only ready set to 1 & this is called one-cycle pulse
            end else begin
                bit_cnt <= bit_cnt + 1'b1;  //otherwise bit_cnt start to count untill it reaches 9
            end
        end else begin
            ready <= 1'b0;                  //then again ready going to be zero
        end
    end

endmodule

