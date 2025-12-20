module tb_serial_system;

    reg i_clk;
    reg i_rst;
    reg i_tx_ena_n;

    wire o_serial_out;
    wire o_hit;

    // -------- CLOCK: 10 kHz -----
    initial begin
        i_clk = 1'b1;
        forever #50000 i_clk = ~i_clk; // 100 us period
    end

    // -----top module instantiation as dut --------
    top_module DUT (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_tx_ena_n(i_tx_ena_n),
        .o_serial_out(o_serial_out),
        .o_hit(o_hit)
    );

    // ------- Stimulus--------
    initial begin
        // Initial state
        i_rst      = 1'b1;
        i_tx_ena_n = 1'b1;

        // Hold reset for 2 clock cycles
        #200000;            // 200 us
        i_rst = 1'b0;

        // Enable transmission
        #100000;            // 100 us
        i_tx_ena_n = 1'b0;

        // Run long enough to see activity
        #2000000;           // 2 ms (many frames)
        $stop;
    end

endmodule

