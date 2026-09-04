module apb_uart_bridge(
	input wire clk,
	input wire rst_n,
	input wire [31:0] PADDR,
	input wire [31:0] PWDATA,
	input wire PWRITE,
	input wire PSEL,
	input wire PENABLE,
	output reg [31:0] PRDATA,
	output reg PREADY
);

reg [7:0] tx_data;
reg tx_write;

wire [7:0] rx_data;
wire rx_ready;
wire tx_busy;

uart uart_inst(
	.clk(clk), .rst_n(rst_n),.tx_data(tx_data),.tx_write(tx_write),.rx_data(rx_data),.rx_ready(rx_ready),.tx_busy(tx_busy));

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		PREADY <= 1'b0;
		PRDATA <= 32'h0;
		tx_data <= 8'h00;
		tx_write <= 1'b0;
	end else begin
		PREADY <= 1'b0;
		tx_write <= 1'b0;

		if(PSEL && PENABLE) begin
			PREADY <= 1'b1;

			if(PWRITE) begin
				case(PADDR[7:0])
					8'h00: begin
						tx_data <= PWDATA[7:0];
						tx_write <= 1'b1;
					end
				endcase
			end else begin
				case(PADDR[7:0])
					8'h04: PRDATA <= {24'h0,rx_data};
					8'h08: PRDATA <= {30'h0, tx_busy, rx_ready};
					default : PRDATA <= 32'h0;
				endcase
			end
		end
	end
end
endmodule


