module inefficient_fsm(
	input clk, rst,start,
	output reg [1:0] state,
	output reg done
);

always @(posedge clk or posedge rst) begin
	if(rst) begin
		state <= 0;
		done <= 0;
	end else begin
		state <= state + 1;
		if (state == 2)
			done <= 1;
	end
end
endmodule

