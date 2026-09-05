module reset_sync(
	input clk, async_reset,
	output reg sync_reset
);

reg sync_ff1;

always @(posedge clk or posedge async_reset) begin
	if(async_reset) begin
		sync_ff1 <= 1'b1;
		sync_reset <= 1'b1;
	end else begin
		sync_ff1 <= 1'b0;
		sync_reset <= sync_ff1;
	end
end
endmodule

