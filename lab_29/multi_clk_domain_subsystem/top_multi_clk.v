module top_multi_clk(wr_clk, rd_clk,wr_rst,rd_rst);
input wr_clk, rd_clk, wr_rst, rd_rst;
wire [7:0] wr_data, rd_data;
wire wr_en, wr_full;
wire rd_en, rd_empty;

block_a producer(
	.wr_clk(wr_clk),
	.wr_rst(wr_rst),
	.wr_full(wr_full),
	.wr_en(wr_en),
	.wr_data(wr_data));
block_b consumer(
	.rd_clk(rd_clk),
	.rd_rst(rd_rst),
	.rd_empty(rd_empty),
	.rd_data(rd_data),
	.rd_en(rd_en));

async_fifo #(
	.DEPTH(8),
	.DATA_WIDTH(8)
) cdc_fifo (
	.wr_clk(wr_clk),
	.wr_rst(wr_rst),
	.wr_en(wr_en),
	.wr_data(wr_data),
	.wr_full(wr_full),
	.rd_clk(rd_clk),
	.rd_rst(rd_rst),
	.rd_en(rd_en),
	.rd_data(rd_data),
	.rd_empty(rd_empty)
);

endmodule

