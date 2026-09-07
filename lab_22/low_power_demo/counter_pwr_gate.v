module counter_pwr_gate(
	input wire clk, reset, power_on,
	output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
	if(reset)
		count <= 0;
	else if (power_on)
		count <= count + 1;
end
endmodule


