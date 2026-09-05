module global_reset_tb;
reg clk = 0, global_rst = 0;
reg d1 = 1,  d2 = 1;
wire q1, q2;

global_reset uut(.clk(clk), .global_rst(global_rst),.d1(d1),.d2(d2),.q1(q1),.q2(q2));

always #5 clk <= ~clk;
initial begin
	$dumpfile ("global_reset.vcd");
	$dumpvars (0, global_reset_tb);
	#10 global_rst = 1;
	#10 global_rst = 0;
	#20 $finish;
end
endmodule


