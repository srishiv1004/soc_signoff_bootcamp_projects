module and_gate_non_synth(
	input a,b,
	output reg y
);

initial begin
	y = 0;
end

always @(a or b) begin
	#5 y = a & b;
end

always @(y) begin
	$display("TIME = %0t : a = %b b = %b y = %b", $time,a,b,y);
end

initial begin
	$monitor("MONITOR :time= %0t a = 5b b = %b y = %b" ,$time,a,b,y);
end

initial begin
	#120;
	$display("simulation finished");
	$finish;
end
endmodule

