module fifo(
	input wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en,
	input [7:0] wr_data,
	output reg [7:0] rd_data,
	output reg wr_full, rd_empty
);

reg [7:0] mem [0:7];
reg [2:0] wr_ptr = 0, rd_ptr = 0;

always @(posedge wr_clk or posedge wr_rst) begin
	if(wr_rst)
		wr_ptr <= 0;
	else if (wr_en && !wr_full) begin
		mem[wr_ptr] <= wr_data;
		wr_ptr <= wr_ptr + 1;
	end
end

always @(posedge rd_clk or posedge rd_rst) begin
	if (rd_rst)
		rd_ptr <= 0;
	else if (rd_en && !rd_empty) begin
		rd_data <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
end

always @(*) begin
	wr_full = ((wr_ptr + 1) % 8 == rd_ptr);
	rd_empty = (wr_ptr == rd_ptr);
end
endmodule



