module uart_receiver 
#( 
	parameter integer CLKS_PER_BIT = 217
)
( 
	input wire clk, rst_n,serial_in,
	output reg [7:0] data_out,
	output reg data_ready
);

localparam IDLE = 2'd0;
localparam START = 2'd1;
localparam RECV = 2'd2;
localparam STOP = 2'd3;

reg [1:0] state;
reg [7:0] clk_count;
reg [2:0] bit_index;
reg [7:0] data_buf;

reg rx_meta;
reg rx_sync;

//Synchronizer for asynchronous UART input
 
always @(posedge clk) begin
	rx_meta <= serial_in;
	rx_sync <= rx_meta;
end

// UART Receiver FSM

always @(posedge clk) begin
	if(!rst_n) begin
		state <= IDLE;
		clk_count <= 8'd0;
		bit_index <= 3'd0;
		data_buf <= 8'd0;
		data_out <= 8'd0;
		data_ready <= 1'b0;
	end
	else begin
		data_ready <= 1'b0;
		case(state)
			IDLE : begin
				clk_count <= 8'd0;
				bit_index <= 3'd0;
				if (rx_sync == 1'b0)
					state <= START;
			end

			START : begin
				if(clk_count == (CLKS_PER_BIT >> 1)) begin
					clk_count <= 8'd0;
					if(rx_sync == 1'b0)
						state <= RECV;
					else
						state <= IDLE;
				end
				else begin
					clk_count <= clk_count + 1'b1;
				end
			end

			RECV : begin
				if(clk_count == CLKS_PER_BIT -1) begin
					clk_count <= 8'd0;
					data_buf[bit_index] <= rx_sync;
					if(bit_index == 3'd7) begin
						bit_index <= 3'd0;
						state <= STOP;
					end
					else begin
						bit_index <= bit_index + 1'b1;
					end
				end
				else begin
					clk_count <= clk_count + 1'b1;
				end
			end

			STOP: begin
				if(clk_count == CLKS_PER_BIT - 1) begin
					clk_count <= 8'd0;
					data_out <= data_buf;
					data_ready <= 1'b1;
					state <= IDLE;
				end
				else begin
					clk_count <= clk_count + 1'b1;
				end
			end
			
			default : begin
				state <= IDLE;
			end
		endcase
	end
end
endmodule

