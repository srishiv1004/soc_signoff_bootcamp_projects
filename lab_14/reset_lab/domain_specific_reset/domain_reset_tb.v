module domain_reset_tb;
reg clk1 = 0, clk2 = 0, rst1 = 0, rst2 = 0, d1 = 1, d2 = 1;
wire q1, q2;

domain_reset dut(.clk1(clk1), .clk2(clk2), .rst1(rst1),.rst2(rst2), .d1(d1), .d2(d2), .q1(q1), .q2(q2));

always #4 clk1 <= ~clk1;
always #6 clk2 <= ~clk2;

initial begin
	$dumpfile("domain_reset.vcd");
	$dumpvars(0, domain_reset_tb);
	#10 rst1 = 1; #8; rst1 = 0;
	#15 rst2 = 1; #10; rst2 = 0;
	#30 $finish;
end
endmodule

