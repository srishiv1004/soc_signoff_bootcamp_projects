module fsm_tb;
reg clk = 0, rst = 1, start = 0;
wire [1:0] state_inefficient, state_optimized;
wire done_inefficient, done_optimized;

always #5 clk <= ~clk;

inefficient_fsm u_bad( .clk(clk), .rst(rst), .start(start), .state(state_inefficient), .done(done_inefficient));

optimized_fsm u_opt(.clk(clk),.rst(rst),.start(start),.state(state_optimized), .done(done_optimized));

initial begin
	$dumpfile("dump.vcd");
	$dumpvars(0,fsm_tb);

	#12 rst = 0;
	#10 start = 1;
	#20 start = 0;
	#100 $finish;
end
endmodule

