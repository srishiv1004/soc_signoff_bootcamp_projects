module cdc_sync(
	input clk,async_in,
	output reg sync_out
);

reg stage1;
always @(posedge clk) begin
	stage1 <= async_in;
	sync_out <= stage1;
end
endmodule

