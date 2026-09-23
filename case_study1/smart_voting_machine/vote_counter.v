`timescale 1ns/1ps
module vote_counter(
	input wire clk, rst,
	input wire [3:0] v,
	output reg [2:0] count,
	output wire max_vote
);

localparam [2:0] MAX_COUNT = 3'd4;
wire vote_valid = |v;

always @(posedge clk or posedge rst) begin
	if(rst)
		count <= 3'd0;
	else if (vote_valid && (count < MAX_COUNT))
		count <= count + 3'd1;
end
assign max_vote = (count == MAX_COUNT);
endmodule


