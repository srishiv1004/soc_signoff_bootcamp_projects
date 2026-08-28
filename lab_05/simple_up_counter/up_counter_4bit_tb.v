module up_counter_4bit_tb;
reg clk, reset;
wire [3:0] count;

up_counter_4bit dut(
	.clk(clk), .reset(reset),.count(count));
always #5 clk <= ~clk;
initial begin
	$monitor("TIme = %t | Reset = %b | count = %b",$time,reset,count);
	reset = 1; #10;
	reset = 0; #200;
	$finish;
end

initial begin
	$dumpfile("up_counter_4bit.vcd");
	$dumpvars();
end
endmodule

