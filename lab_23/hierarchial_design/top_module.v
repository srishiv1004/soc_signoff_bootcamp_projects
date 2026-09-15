module top_module (
	input clk, rst, en,
	input [7:0] ext_input,
	output [7:0] result
);

wire [7:0] count;

counter u_counter( .clk(clk),.rst(rst),.en(en),.count(count));
adder u_adder (.a(count),.b(ext_input),.sum(result));
endmodule


