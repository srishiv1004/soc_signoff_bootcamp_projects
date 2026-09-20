module pos_edge_gating_tb;
reg clk = 0, en = 0, rst = 1;
wire [3:0] count;
wire gated_clk;
pos_edge_gating uut(
	.clk(clk),.en(en),.rst(rst),.count(count),.gated_clk(gated_clk));

always #5 clk <= ~clk;
initial begin
	$dumpfile("pos_edge_gating.vcd");
	$dumpvars(0,pos_edge_gating_tb);

	#12 rst = 0;
	#10 en = 1; #30 en = 0;
	#5 en = 1; #3 en = 0;
	#40 en = 1; #20 en = 0;
	#30 $finish;
end
endmodule

