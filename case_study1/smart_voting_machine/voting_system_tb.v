`timescale 1ns/1ps
// Testbench for the Smart Voting Machine
module voting_system_tb;

    reg        clk;
    reg        rst;
    reg        en_global;
    reg        d0, d1, d2, d3;
    reg  [1:0] sel;
    wire [3:0] v;
    wire [2:0] count;
    wire       max_vote;

    integer errors = 0;

    voting_system dut (
        .clk(clk), .rst(rst), .en_global(en_global),
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .sel(sel),
        .v(v), .count(count), .max_vote(max_vote)
    );

    // 100 MHz clock (10 ns period)
    initial clk = 1'b0;
    /* verilator lint_off BLKSEQ */
    always #5 clk = ~clk;
    /* verilator lint_on BLKSEQ */

    // Waveform dump for GTKWave
    initial begin
        $dumpfile("voting_system.vcd");
        $dumpvars(0, tb_voting_system);
    end

    // Drive one vote: press button 'btn' with SEL = 's' for one clock cycle.
    // Inputs change on the falling edge so they are stable at the rising edge.
    task cast_vote(input [1:0] btn, input [1:0] s);
        begin
            @(negedge clk);
            sel = s;
            d0  = (btn == 2'd0);
            d1  = (btn == 2'd1);
            d2  = (btn == 2'd2);
            d3  = (btn == 2'd3);
            @(negedge clk);              // vote register captured at posedge
            {d0, d1, d2, d3} = 4'b0000;
            @(negedge clk);              // counter updated at next posedge
        end
    endtask

    task check(input [2:0] exp_count, input exp_max, input [8*40-1:0] msg);
        begin
            if (count !== exp_count || max_vote !== exp_max) begin
                $display("[FAIL] %0s : count=%0d max_vote=%b (expected %0d, %b)",
                         msg, count, max_vote, exp_count, exp_max);
                errors = errors + 1;
            end else begin
                $display("[PASS] %0s : count=%0d max_vote=%b",
                         msg, count, max_vote);
            end
        end
    endtask

    initial begin
        // Initial values
        rst = 1'b1; en_global = 1'b0;
        {d0, d1, d2, d3} = 4'b0000;
        sel = 2'b00;

        // Hold reset for a few cycles
        repeat (3) @(posedge clk);
        @(negedge clk) rst = 1'b0;
        check(3'd0, 1'b0, "After reset");

        // 1) Vote while machine disabled -> must be ignored
        cast_vote(2'd0, 2'd0);
        check(3'd0, 1'b0, "Vote with EN_GLOBAL=0");

        // Enable the machine
        @(negedge clk) en_global = 1'b1;

        // 2) Button and SEL mismatch -> MUX output 0 -> ignored
        cast_vote(2'd1, 2'd2);
        check(3'd0, 1'b0, "Button D1 but SEL=2");

        // 3) Valid votes for each candidate
        cast_vote(2'd0, 2'd0);
        check(3'd1, 1'b0, "Vote candidate 0");
        cast_vote(2'd1, 2'd1);
        check(3'd2, 1'b0, "Vote candidate 1");
        cast_vote(2'd2, 2'd2);
        check(3'd3, 1'b0, "Vote candidate 2");
        cast_vote(2'd3, 2'd3);
        check(3'd4, 1'b1, "Vote candidate 3 (MAX)");

        // 4) Extra vote -> counter must saturate at 4
        cast_vote(2'd1, 2'd1);
        check(3'd4, 1'b1, "Extra vote (saturate)");

        // 5) Reset in the middle of operation
        @(negedge clk) rst = 1'b1;
        @(negedge clk) rst = 1'b0;
        check(3'd0, 1'b0, "Reset after MAX");

        // 6) Vote again after reset
        cast_vote(2'd2, 2'd2);
        check(3'd1, 1'b0, "Vote after reset");

        repeat (3) @(posedge clk);

        if (errors == 0) $display("\n*** ALL TESTS PASSED ***\n");
        else             $display("\n*** %0d TEST(S) FAILED ***\n", errors);
        $finish;
    end

    // Print every change on the monitored outputs
    initial
        $monitor("t=%0t rst=%b en=%b sel=%0d D=%b%b%b%b | V=%b count=%0d max=%b",
                 $time, rst, en_global, sel, d3, d2, d1, d0, v, count, max_vote);

endmodule
