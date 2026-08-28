module and_gate_tb;
reg A,B;
wire Y;
and_gate_design dut(.A(A),.B(B),.Y(Y));
initial begin
	$display("time = %t A = %0b | B = %0b | Y = %0b",$time,A,B,Y);
	$monitor("time = %t A = %0b | B = %0b | Y = %0b",$time, A,B,Y);
	#10;
	A = 1'b0; B = 1'b0; #10;
	A = 1'b0; B= 1'b1; #10;
	A = 1'b1; B = 1'b0; #10;
	A = 1'b1; B = 1'b1; #10;
	$finish;
end
initial begin
	$dumpfile("and_gate_dump.vcd");
	$dumpvars();
end
endmodule


