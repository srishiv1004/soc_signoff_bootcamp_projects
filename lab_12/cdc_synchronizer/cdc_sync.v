module cdc_sync(
	input clk, async_in,
	output reg synced
);

reg stage1; // First-stage FF

always @(posedge clk) begin
	stage1 <= async_in;
	synced <= stage1;
end
endmodule


