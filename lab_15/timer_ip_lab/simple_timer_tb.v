`timescale 1ns/1ps

module simple_timer_tb;
reg clk = 0, rst = 1, start = 0;
reg [7 : 0] load_val = 0;
wire done;

simple_timer #(.WIDTH(8)) uut(
	.clk(clk), .rst(rst),.start(start),.load_val(load_val),.done(done));

always #5 clk <= ~clk;
initial begin
	$dumpfile("simple_timer.vcd");
	$dumpvars(0, simple_timer_tb);
	#10 rst = 0;
	#5 load_val = 8'd5; start = 1;
	#10 start = 0;
	#100;
	#5 load_val = 8'd3; start = 1;
	#10 start = 0;
	#50 $finish;
end
endmodule

