module apb_uart_top(
	input wire clk,
	input wire rst_n,
	input wire [31:0] PADDR,
	input wire [31:0] PWDATA,
	input wire PWRITE,
	input wire PSEL,
	input wire PENABLE,
	output wire [31:0] PRDATA,
	output wire PREADY
);

apb_uart_bridge dut(
	.clk(clk),.rst_n(rst_n),.PADDR(PADDR),.PWDATA(PWDATA),.PWRITE(PWRITE),.PSEL(PSEL),.PENABLE(PENABLE),.PRDATA(PRDATA),.PREADY(PREADY));
endmodule

