module metastability(
	input clk, async_in, 
	output reg sampled
);

always @(posedge clk) begin
	sampled <= async_in;
end
endmodule

