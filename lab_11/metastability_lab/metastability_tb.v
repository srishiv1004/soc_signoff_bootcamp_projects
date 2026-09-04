module metastability_tb;

reg clk = 0;
reg async_in = 0;
wire sampled;

always #5 clk <= ~clk;

metastability dut(.clk(clk), .async_in(async_in),.sampled(sampled));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0, metastability_tb);
	#12 async_in = 1;
	#7 async_in = 0;
	#6 async_in = 1;
	#9 async_in = 0;
	#50 $finish;
end
endmodule

