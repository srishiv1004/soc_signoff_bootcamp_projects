module async_reset_ff(
	input clk,rst_n,d,
	output reg q
);

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		q <= 0;
	else
		q <= d;
end
endmodule


