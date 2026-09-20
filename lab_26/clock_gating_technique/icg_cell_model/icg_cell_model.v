module icg_cell_model(
	input wire clk, en, rst,
	output reg [3:0] count,
	output wire gated_clk,
	output reg en_latch_out
);

reg en_latch;
always @(clk or en) begin
	if(!clk)
		en_latch = en;
end
assign gated_clk = clk & en_latch;
always @(*) en_latch_out = en_latch;

always @(posedge gated_clk or posedge rst) begin
	if(rst)
		count <= 4'b0000;
	else
		count <= count + 1;
end
endmodule

