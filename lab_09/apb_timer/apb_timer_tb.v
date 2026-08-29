`timescale 1ns/1ps
module apb_timer_tb;
 // APB interface signals
 reg PCLK;
 reg PRESETn = 0;
 reg PSEL = 0;
 reg PENABLE = 0;
 reg PWRITE = 0;
 reg [7:0] PADDR = 0;
 reg [31:0] PWDATA = 0;
 wire [31:0] PRDATA;
 wire timer_done;
 // DUT instance
 apb_timer uut (
 .PCLK(PCLK),
 .PRESETn(PRESETn),
 .PSEL(PSEL),
 .PENABLE(PENABLE),
 .PWRITE(PWRITE),
 .PADDR(PADDR),
 .PWDATA(PWDATA),
 .PRDATA(PRDATA),
 .timer_done(timer_done)
 );
 // Clock generation
 initial PCLK = 0;
 always #5 PCLK <= ~PCLK;
 // Monitor timer completion
 always @(posedge timer_done)
 $display("Time=%0t : TIMER DONE", $time);
 // APB write task
 task apb_write(input [7:0] addr, input [31:0] data);
 begin
 @(posedge PCLK);
PSEL = 1; PWRITE = 1; PENABLE = 0; PADDR = addr;
PWDATA = data;
 @(posedge PCLK);
 PENABLE = 1;
 @(posedge PCLK);
 PSEL = 0; PENABLE = 0; PWRITE = 0;
 end
 endtask
 // APB read task
 task apb_read(input [7:0] addr);
 begin
 @(posedge PCLK);
 PSEL = 1; PWRITE = 0; PENABLE = 0; PADDR = addr;
 @(posedge PCLK);
 PENABLE = 1;
 @(posedge PCLK);
 $display("Read [0x%0h] = %0d", addr, PRDATA);
 PSEL = 0; PENABLE = 0;
 end
 endtask
 // Test sequence
 initial begin
 $dumpfile("apb_timer.vcd");
 $dumpvars(0, apb_timer_tb);
 // Apply reset
 #10 PRESETn = 1;
 // Program load value = 5
 apb_write(8'h00, 5);
 // Start timer
 apb_write(8'h04, 1);
 // Wait and read status
 #80 apb_read(8'h08);
 // Program load value = 3
 apb_write(8'h00, 3);
 // Start timer again
 apb_write(8'h04, 1);
 // Read status delay
 #50 apb_read(8'h08);
 #50 $finish;
 end
endmodule
