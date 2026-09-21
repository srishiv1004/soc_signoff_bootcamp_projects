module reset_top(
	input wire clk, arst_n,
	output wire [7:0] count,
	output wire srst_n
);

reset_stretch u_rst( .clk(clk), .arst_n(arst_n),.srst_n(srst_n));
reg [7:0] cnt_q;
always @(posedge clk or negedge srst_n) begin
	if (!srst_n)
		cnt_q <= 8'h00;
	else
		cnt_q <= cnt_q + 1;
end
assign count = cnt_q;
endmodule

