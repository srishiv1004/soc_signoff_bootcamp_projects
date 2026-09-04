module cdc_sync_tb;
reg clk = 0;
reg async_in = 0;
wire synced;

always #5 clk <= ~clk;
cdc_sync dut( .clk(clk), .async_in(async_in), .synced(synced));
initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0,cdc_sync_tb);
	#12 async_in = 1;
	#7 async_in = 0;
	#6 async_in = 1;
	#9 async_in = 0;
	#50 $finish;
end
endmodule


