module shift_reg(
	input wire clk, rst, 
	input wire [7:0] data_in,
	output reg [7:0] q
);

always @(posedge clk or posedge rst) begin
	if(rst) begin
		q <= 8'b00000000;
	end else begin
		q <= {q[6:0], data_in[7]};
	end
end
endmodule

