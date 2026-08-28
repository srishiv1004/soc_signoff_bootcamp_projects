`timescale 1ns/1ps

module mux4x1_gatelevel(
	input [3:0] in,
	input [1:0] sel,
	output out
);

wire not_s0, not_s1;
wire and0,and1,and2,and3;

not(not_s0,sel[0]);
not(not_s1,sel[1]);

and(and0,not_s1,not_s0,in[0]);
and(and1,not_s1,sel[0],in[1]);
and(and2,sel[1],not_s0,in[2]);
and(and3,sel[1],sel[0],in[3]);
or(out,and0,and1,and2,and3);
endmodule

