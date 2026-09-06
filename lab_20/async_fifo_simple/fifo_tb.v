module fifo_tb;
reg wr_clk = 0, rd_clk = 0, wr_rst = 1, rd_rst = 1, wr_en = 0, rd_en = 0;
reg [7:0] wr_data = 8'd0;
wire [7:0] rd_data;
wire wr_full, rd_empty;

always #5 wr_clk <= ~wr_clk;
always #7 rd_clk <= ~rd_clk;

fifo uut(
.wr_clk(wr_clk), .rd_clk(rd_clk),
 .wr_rst(wr_rst), .rd_rst(rd_rst),
 .wr_en(wr_en), .rd_en(rd_en),
 .wr_data(wr_data), .rd_data(rd_data),
 .wr_full(wr_full), .rd_empty(rd_empty)
 );

 initial begin
	 $dumpfile ("dump.vcd");
	 $dumpvars (0, fifo_tb);

	 #10 wr_rst = 0;
	 #10 rd_rst = 0;

	 repeat (4) begin
		 @(posedge wr_clk);
		 wr_en = 1;
		 wr_data <= wr_data + 1;
	 end

	 wr_en = 0;

	 #30;

	 repeat (4) begin
		 @(posedge rd_clk);
		 rd_en = 1;
	 end

	 rd_en = 0;

	 #50 $finish;
 end
 endmodule


