`timescale 1ns/1ps
module uart_receiver_tb;
    localparam CLK_PERIOD   = 40;
    localparam CLKS_PER_BIT = 217;
    localparam BIT_TIME     = CLK_PERIOD * CLKS_PER_BIT;

    reg clk, rst_n, serial_in;
    wire [7:0] data_out;
    wire data_ready;
    integer rx_count;

    uart_receiver #(.CLKS_PER_BIT(CLKS_PER_BIT)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .data_out(data_out),
        .data_ready(data_ready)
    );

    always #(CLK_PERIOD/2) clk <= ~clk;

    // UART frame transmitter
    task send_uart_frame(input [7:0] payload);
        integer i;
        begin
            serial_in = 1'b0; #(BIT_TIME); // start bit
            for (i = 0; i < 8; i = i + 1) begin
                serial_in = payload[i];
                #(BIT_TIME);
            end
            serial_in = 1'b1; #(BIT_TIME); // stop bit
        end
    endtask

    // Monitor every received byte
    always @(posedge clk) begin
        if (data_ready) begin
            rx_count = rx_count + 1;
            $display("RX[%0d] @%0t ns = %h", rx_count, $time, data_out);
        end
    end

    initial begin
        clk       = 1'b0;
        rst_n     = 1'b0;
        serial_in = 1'b1;
        rx_count  = 0;

        // Reset
        #(10 * CLK_PERIOD);
        rst_n = 1'b1;
        #(5 * CLK_PERIOD);

        send_uart_frame(8'h3C);
        #(BIT_TIME);
        send_uart_frame(8'h2F);
        #(3 * BIT_TIME);

        $display("Final data_out = %h", data_out);
        if (rx_count == 2)
            $display("PASS : Two bytes received successfully");
        else
            $display("FAIL : Expected 2 bytes, received %0d", rx_count);

        #(5 * CLK_PERIOD);
        $finish;
    end

    initial begin
        $dumpfile("uart_receiver_tb.vcd");
        $dumpvars(0, uart_receiver_tb);
    end
endmodule
