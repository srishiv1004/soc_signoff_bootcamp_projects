module sync_tb;
reg clk = 0, async_reset = 1, async_signal = 0;
wire synced_reset, synced_signal;

always #5 clk <= ~clk;
top_with_sync dut(
.clk(clk),
.async_reset(async_reset),
.async_signal(async_signal),
.synced_reset(synced_reset),
.synced_signal(synced_signal)
);

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0, sync_tb);
	#12 async_reset = 0;
	#15 async_signal = 1;
	#3 async_signal = 0;
	#20 async_signal = 1;
	#2 async_signal = 0;
	#40 $finish;
end
endmodule


