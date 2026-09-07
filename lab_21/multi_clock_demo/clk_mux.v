module clk_mux(
	input clk0, clk1, sel,
	output clk_out
);

assign clk_out = (sel == 1'b0) ? clk0 : clk1;
endmodule


