module alu16bit(
	input [15:0] A,B,
	input [3:0] ALU_Sel,
	output reg [15:0] ALU_Out,
	output reg CarryOut
);

reg [16:0] tmp;
always @(*) begin
	tmp = 17'h00000;
	ALU_OUt = 16'h0000;
	CarryOUt = 1'b0;

	case(ALU_Sel)
		4'b0000 : tmp = A + B;
		4'b0001 : tmp = A - B;
		4'b0010 : tmp = A & B;
		4'b0011 : tmp = A | B;
		4'b0100 : tmp = A ^ B;
		4'b0101 : tmp = ~(A | B);
		4'b0110 : tmp = ~(A & B);
		4'b0111 : tmp = ~(A ^ B);
		4'b1000 : tmp = A << 1;
		
		4'b1001 : tmp = A >> 1;
		4'b1010 : tmp = {A[14:0], A[15]};
		4'b1011 : tmp = {A[0], A[15:1]};
		4'b1100 : tmp = (A > B) ? 16'd1 : 16'd0;
		4'b1101 : tmp = (A == B) ? 16'd1 : 16'd0;
		default : tmp = 17'h00000;
	endcase
	ALU_Out = tmp[15:0];
	CarryOut = tmp[16];
end
endmodule

