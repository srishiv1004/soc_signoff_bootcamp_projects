`timescale 1ns/1ps

module half_adder_gatelevel_tb;
reg a,b;
wire sum,carry;

half_adder_gatelevel dut(.a(a),.b(b),.sum(sum),.carry(carry));

initial begin
	$display("Gate Level Half Adder Test");
	$display("A B| Sum Carry");
	$display("---------------");

	a = 0; b = 0; #10 $display("%b %b | %b %b",a,b,sum,carry);
	a = 0; b = 1; #10 $display("%b %b | %b %b",a,b,sum,carry);
	a = 1; b = 0; #10 $display("%b %b | %b %b",a,b,sum,carry);
	a = 1; b = 1; #10 $display("%b %b | %b %b",a,b,sum,carry);
	$finish;
end

initial begin
	$dumpfile("half_adder_gatelevel.vcd");
	$dumpvars(0,half_adder_gatelevel_tb);
end
endmodule
