`timescale 1ns/1ps
module mux_4x1(
	input wire i0, i1, i2, i3,
	input wire [1:0] sel,
	output reg y
);

always @(*) begin
	case(sel)
		2'b00: y = i0;
		2'b01: y = i1;
		2'b10: y = i2;
		2'b11: y = i3;
	endcase
end
endmodule



