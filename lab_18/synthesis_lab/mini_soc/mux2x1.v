module mux2x1(
	input [1:0] in0, in1,
	input sel,
	output [1:0] out
);

assign out = sel ? in1 : in0;
endmodule

