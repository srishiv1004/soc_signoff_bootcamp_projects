`timescale 1ns/1ps

module half_adder_gatelevel(
	input a,b,
	output sum,carry
);

xor u1(sum,a,b);
and u2(carry,a,b);
endmodule

