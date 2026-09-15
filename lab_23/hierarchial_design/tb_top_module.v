module tb_top_module;
reg clk = 0, rst = 1, en = 0;
reg [7:0] ext_input = 8'd10;
wire [7:0] result;

always #5 clk <= ~clk;
top_module dut( .clk(clk),.rst(rst),.en(en),.ext_input(ext_input),.result(result));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0,tb_top_module);
	#12 rst = 0;
	#5 en = 1;
	#100 en = 0;
	#20 $finish;
end
endmodule

