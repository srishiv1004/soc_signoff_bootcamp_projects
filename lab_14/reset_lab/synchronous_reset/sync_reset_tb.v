module sync_reset_tb;
reg clk = 0, rst = 0, d = 0;
wire q;
sync_reset_ff dut(.clk(clk), .rst(rst),.d(d),.q(q));
always #5 clk <= ~clk;
initial begin
	$dumpfile("sync_reset.vcd");
	$dumpvars(0, sync_reset_tb);
	d = 1; #3;
	rst = 1; #7;
	rst = 0; #20;
	$finish;
end
endmodule

