module reset_stretch(
	input wire clk, arst_n,
	output wire srst_n
);

reg [1:0] hold_cnt;
reg hold;
always @(posedge clk or negedge arst_n) begin
	if(!arst_n) begin
		hold <= 1'b1;
		hold_cnt <= 2'd0;
	end else if (hold) begin
		if(hold_cnt == 2)
			hold <= 1'b0;
		else
			hold_cnt <= hold_cnt + 1'b1;
	end
end
assign srst_b = ~hold;
endmodule

