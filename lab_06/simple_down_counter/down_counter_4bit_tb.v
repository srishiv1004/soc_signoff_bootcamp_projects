module down_counter_4bit_tb;
reg clk,reset;
wire [3:0] count;

down_counter_4bit dut(.clk(clk), .reset(reset), .count(count));
always #5 clk <= ~clk;
initial begin
	clk = 0;
	$monitor("Time = %t | Reset = %b | Count = %b", $time,reset,count);
	reset = 1; #10;
	reset = 0;#200;
	$finish;
end

initial begin
	$dumpfile("down_counter_4bit.vcd");
	$dumpvars();
end
endmodule

