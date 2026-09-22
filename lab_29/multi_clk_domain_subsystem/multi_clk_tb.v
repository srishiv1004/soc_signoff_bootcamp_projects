module multi_clk_tb;
reg wr_clk, rd_clk;
reg wr_rst, rd_rst;

always #5 wr_clk <= ~wr_clk;
always #7 rd_clk <= ~rd_clk;

top_multi_clk dut (.wr_clk(wr_clk),.rd_clk(rd_clk),.wr_rst(wr_rst),.rd_rst(rd_rst));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0, multi_clk_tb);
	wr_clk = 0;
	rd_clk = 0;

	wr_rst = 1;
	rd_rst = 1;

	#10 wr_rst = 0;
	#15 rd_rst = 0;
	#500 $finish;
end
endmodule

