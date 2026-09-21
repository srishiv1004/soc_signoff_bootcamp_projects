module optimized_fsm(
	input clk, rst,start,
	output reg [1:0] state,
	output reg done
);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		state <= 0;
		done <= 0;
	end else begin
		case (state)
			0: if (start) state <= 1;
			1: state <= 2;
			2: begin
				done <= 1;
				state <=3;
			end
		endcase
	end
end
endmodule

