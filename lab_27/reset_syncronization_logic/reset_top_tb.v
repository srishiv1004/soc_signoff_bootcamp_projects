`timescale 1ns/1ps

module reset_top_tb;
reg clk = 0, arst_n = 1;
wire [7:0] count;
wire srst_n;
reset_top dut(
	.clk(clk), .arst_n(arst_n),.count(count),.srst_n(srst_n));always #5 clk <= ~clk;
initial begin
	$dumpfile("reset_stretch.vcd");
	$dumpvars(0,reset_top_tb);
	#7 arst_n = 0;
	#11 arst_n = 1;
	#120 $finish;
end
endmodule

