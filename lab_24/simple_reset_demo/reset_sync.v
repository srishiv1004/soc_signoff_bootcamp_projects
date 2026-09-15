module reset_sync(
	input wire clk, rst_async,
	output reg rst_sync
);

reg stage1;

always @(posedge clk or posedge rst_async) begin
	if(rst_async) begin
		stage1 <= 1'b1;
		rst_sync <= 1'b1;
	end else begin
		stage1 <= 1'b0;
		rst_sync <= stage1;
	end
end
endmodule


