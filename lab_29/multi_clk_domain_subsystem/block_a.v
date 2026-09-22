module block_a(
	input wr_clk, wr_rst, wr_full,
	output reg wr_en,
	output reg [7:0] wr_data
);

reg [7:0] counter = 0;
always @(posedge wr_clk or posedge wr_rst) begin
	if(wr_rst) begin
		counter <= 0;
		wr_en <= 0;
	end else begin
		wr_en <= !wr_full;
		if(!wr_full) begin
			wr_data <= counter;
			counter <= counter + 1;
		end
	end
end
endmodule
