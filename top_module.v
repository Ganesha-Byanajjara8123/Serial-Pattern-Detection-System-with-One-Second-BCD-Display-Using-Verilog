module top_module (
    input  wire i_clk,        // 10 kHz clock
    input  wire i_rst,
    input  wire i_tx_ena_n,    // active-low TX enable

    // Core outputs
    output wire o_serial_out,
    output wire o_hit,

    // BONUS outputs
    output wire [9:0] o_hit_count,
    output wire o_hit_count_valid,
    output wire [6:0] seg_hundreds,
    output wire [6:0] seg_tens,
    output wire [6:0] seg_ones
);

    // -------- INTERNAL SIGNALS -------
    wire [9:0] count;
    wire ready;
    wire hit;

    wire tx_enable = ~i_tx_ena_n;   //Convert active-low enable to active-high

    // --------- TRANSMITTER-------------
	// ----module tx_counter instantialtion----
    tx_counter U_COUNTER (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .en(ready & tx_enable),
        .count(count)
    );
	// ----module serial_transmitter instantialtion----
    serial_transmitter U_transmitter (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .en(tx_enable),
        .pdata(count),
        .sdata(o_serial_out),
        .ready(ready)
    );

    // --------- RECEIVER ----------
	//----module  serial_detector instantiation-----
    serial_detector U_DETECT (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .sdata(o_serial_out),
        .hit(hit)
    );

    assign o_hit = hit;                             // Connect internal hit to output

    // --------- 1-SECOND TIMER --------
    reg [13:0] sec_cnt;
    reg one_sec_pulse;

    always @(posedge i_clk) begin
        if (i_rst) begin
            sec_cnt <= 14'd0;
            one_sec_pulse <= 1'b0;
        end else if (sec_cnt == 14'd9999) begin
            sec_cnt <= 14'd0;
            one_sec_pulse <= 1'b1;
        end else begin
            sec_cnt <= sec_cnt + 1'b1;
            one_sec_pulse <= 1'b0;
        end
    end

    // ------- HIT COUNTER -------
    reg [9:0] hit_count;                          // hit_count counts from 0-9
    reg [9:0] hit_count_latched;                 //To store binary values

    always @(posedge i_clk) begin
        if (i_rst) begin                         //initially set to zero
            hit_count <= 10'd0;
            hit_count_latched <= 10'd0;
        end else begin
            if (hit)
                hit_count <= hit_count + 1'b1;   //hit_count start to count from 0-9

            if (one_sec_pulse) begin
                hit_count_latched <= hit_count;  // when hit_count_latched = hit_count then
                hit_count <= 10'd0;              // hit_count become zero and hit_count again start from 0-9
            end
        end
    end

    // -------- BINARY → BCD ---------
    wire [3:0] bcd_h, bcd_t, bcd_o;              //To show BCD valus of hundreds,tens,ones        

    //---module   bin2bcd instantialtion---
    bin2bcd U_B2B (
        .bin(hit_count_latched),
        .hundreds(bcd_h),
        .tens(bcd_t),
        .ones(bcd_o)
    );

    // ------Convert each BCD digit into 7-segment pattern-------
    seg7 U_SEG_H (.bcd(bcd_h), .seg(seg_hundreds));
    seg7 U_SEG_T (.bcd(bcd_t), .seg(seg_tens));
    seg7 U_SEG_O (.bcd(bcd_o), .seg(seg_ones));

    // -------- OUTPUTS --------
    assign o_hit_count       = hit_count_latched;    // Stable hit count per second
    assign o_hit_count_valid = one_sec_pulse;        // Display update indicator for every 1-second

endmodule
