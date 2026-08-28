module jk_ff_tb;
reg preset,clk,j,k;
wire q,qn;

jk_ff dut(.preset(preset),.clk(clk),.j(j),.k(k),.q(q),.qn(qn));
always #5 clk <= ~clk;
initial begin
	$monitor("%0t|preset = %b j = %b k = %b | q = %b qn = %b",$time, preset, j, k, q, qn);
end

initial begin
	clk = 0;
	preset = 1;
	j = 0;
	k = 0;

	#7;
	preset = 0;
	#10 j = 0; k = 0;
	#10 j = 0; k = 1;
	#10 j = 1; k = 0;
	#10 j = 1; k = 1;
	#10 j = 1; k = 1;

	#3 preset = 1;
	#4 preset = 0;
	#20 $finish;
end

initial begin
	$dumpfile("jk_ff_async.vcd");
	$dumpvars(0,jk_ff_tb);
end
endmodule

