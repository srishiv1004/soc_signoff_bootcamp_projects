module sync3_stage(
	input wire clk, async_in,
	output reg sync_out
);

reg sync_ff1, sync_ff2;
always @(posedge clk) begin
	sync_ff1 <= async_in;
	sync_ff2 <= sync_ff1;
	sync_out <= sync_ff2;
end
endmodule


