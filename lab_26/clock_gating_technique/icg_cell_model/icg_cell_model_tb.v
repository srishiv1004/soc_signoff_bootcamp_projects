module icg_cell_model_tb;
reg clk = 0, en = 0, rst = 1;
wire [3:0] count;
wire gated_clk;
wire en_latch_out;
icg_cell_model uut(
	.clk(clk), .en(en), .rst(rst),.count(count),.gated_clk(gated_clk),.en_latch_out(en_latch_out));

always #5 clk <= ~clk;
initial begin
	$dumpfile("icg_cell_model.vcd");
	$dumpvars(0, icg_cell_model_tb);
	#12 rst = 0;
	#10 en = 1; #30 en = 0;
	#5 en = 1; #3 en = 0;
	#40 en = 1; #20 en = 0;
	#30 $finish;
end
endmodule

