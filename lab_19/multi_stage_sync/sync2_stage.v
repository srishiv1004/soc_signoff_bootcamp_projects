module sync2_stage(
	input wire clk, async_in,
	output reg sync_out
);

reg sync_ff1;
always @(posedge clk) begin
	sync_ff1 <= async_in;
	sync_out <= sync_ff1;
end
endmodule


