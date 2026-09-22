module async_fifo #(
	parameter DEPTH = 8,
	parameter DATA_WIDTH = 8
)(
	input wr_clk, wr_rst,wr_en,
	input [DATA_WIDTH - 1 :0] wr_data,
	output reg wr_full,
	input rd_clk,rd_rst,rd_en,
	output reg [DATA_WIDTH - 1:0] rd_data,
	output reg rd_empty
);

reg [DATA_WIDTH - 1:0] mem [0:DEPTH - 1];
localparam PTR_WIDTH = $clog2(DEPTH);
reg [PTR_WIDTH - 1:0] wr_ptr = 0;
reg [PTR_WIDTH - 1:0] rd_ptr = 0;
always @(posedge wr_clk or posedge wr_rst) begin
	if(wr_rst) begin
		wr_ptr <= 0;
		wr_full <= 0;
	end else if (wr_en && !wr_full) begin
		mem[wr_ptr] <= wr_data;
		wr_ptr <= wr_ptr + 1;
		wr_full <= ((wr_ptr + 1) == rd_ptr);
	end else begin
		wr_full <= ((wr_ptr + 1) == rd_ptr);
	end
end

always @(posedge rd_clk or posedge rd_rst) begin
	if(rd_rst) begin
		rd_ptr <= 0;
		rd_empty <= 1;
		rd_data <= 0;
	end else if (rd_en && !rd_empty) begin
		rd_data <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
		rd_empty <= (rd_ptr + 1 == wr_ptr);
	end else begin
		rd_empty <= (rd_ptr == wr_ptr);
	end
end
endmodule

