module global_reset(
	input clk, global_rst, d1,d2,
	output reg q1, q2
);

always @(posedge clk) begin
	if(global_rst) begin
		q1 <= 0;
		q2 <= 0;
	end else begin
		q1 <= d1;
		q2 <= d2;
	end
end
endmodule

