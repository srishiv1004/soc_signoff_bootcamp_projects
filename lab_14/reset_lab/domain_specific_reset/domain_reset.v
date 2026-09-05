module domain_reset(
	input clk1,clk2,rst1,rst2,d1,d2,
	output reg q1, q2
);

always @(posedge clk1) begin
	if(rst1)
		q1 <= 0;
	else
		q1 <= d1;
end
always @(posedge clk2) begin
	if(rst2)
		q2 <= 0;
	else
		q2 <= d2;
end
endmodule


