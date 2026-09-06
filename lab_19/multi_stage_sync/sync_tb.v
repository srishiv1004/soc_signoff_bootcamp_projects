module sync_tb;
reg clk = 0, async_in = 0;
wire sync_out2, sync_out3;

always #5 clk <= ~clk;
sync2_stage u_sync2( .clk(clk), .async_in(async_in), .sync_out(sync_out2));

sync3_stage u_sync3(.clk(clk), .async_in(async_in),.sync_out(sync_out3));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0, sync_tb);
	#7 async_in = 1;
	#13 async_in = 0;
	#8 async_in = 1;
	#12 async_in = 0;
	#50 $finish;
end
endmodule

