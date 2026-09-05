module async_reset_tb;
reg clk = 0, rst_n = 1, d= 0;
wire q;
async_reset_ff dut(.clk(clk),.rst_n(rst_n),.d(d),.q(q));
always #5 clk <= ~clk;
initial begin
	$dumpfile("async_reset.vcd");
	$dumpvars(0, async_reset_tb);
	d = 1; #8;
	rst_n = 0;
	#4;
	rst_n = 1;
	#20;
	$finish;
end
endmodule

