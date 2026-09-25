module mux_2x1(
	input a, b,sel,
	output out
);

assign out = sel ? b : a;
endmodule


