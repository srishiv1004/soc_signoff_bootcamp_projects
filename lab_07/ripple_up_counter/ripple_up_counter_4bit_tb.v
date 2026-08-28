module ripple_up_counter_4bit_tb;
reg clk,reset;
wire [3:0] q;

ripple_up_counter_4bit dut (.clk(clk), .reset(reset),.q(q));

always #5 clk <= ~clk;
initial begin
	clk = 0;
	reset = 1;
	$display("Time\treset\tq");
	$monitor("%0dns\t%b\t%b",$time,reset,q);
	#10;
	reset = 0;
	#200;
	$finish;
end
initial begin
	$dumpfile("up_counter_dump.vcd");
	$dumpvars();
end
endmodule

