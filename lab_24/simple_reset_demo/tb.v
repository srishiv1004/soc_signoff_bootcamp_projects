module tb;
reg clk = 0, rst = 0;
wire [3:0] cnt_async, cnt_sync;
wire rst_sync;

always #5 clk <= ~clk;

counter_async u_sync(.clk(clk), .rst(rst),.count(cnt_async));
reset_sync u_sync1 (.clk(clk), .rst_async(rst),.rst_sync(rst_sync));
counter_sync u_syncc (.clk(clk),.rst_sync(rst_sync),.count(cnt_sync));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0,tb);
	rst = 1;
	#25;
	rst = 0;
	#100;
	rst = 1;
	#20;
	rst = 0;
	#50;
	$finish;
end
endmodule

