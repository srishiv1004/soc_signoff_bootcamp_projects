`timescale 1ns/1ps

module apb_uart_tb;
reg clk = 0;
reg rst_n;
reg [31:0] PADDR;
reg [31:0] PWDATA;
reg PWRITE;
reg PSEL;
reg PENABLE;
wire [31:0] PRDATA;
wire PREADY;

apb_uart_top dut(
	.clk(clk),.rst_n(rst_n),.PADDR(PADDR),.PWDATA(PWDATA),.PWRITE(PWRITE),.PSEL(PSEL),.PENABLE(PENABLE),.PRDATA(PRDATA),.PREADY(PREADY));

always #10 clk <= ~clk;
initial begin
	rst_n = 0;
	PADDR = 0;
	PWDATA = 0;
	PWRITE = 0;
	PSEL = 0;
	PENABLE = 0;

	#100;
	rst_n = 1;

	apb_write(32'h00,32'hA5);
	apb_read(32'h04);
	apb_read(32'h08);
	apb_write(32'h00,32'h3C);
	apb_read(32'h04);
	apb_read(32'h08);

	#100;
	$finish;
end

task apb_write(input [31:0] addr, input [31:0] data);
	begin
		@(posedge clk);
		PADDR = addr;
		PWDATA = data;
		PWRITE = 1;
		PSEL = 1;
		PENABLE = 0;

		@(posedge clk);
		PENABLE = 1;
		@(posedge clk);
		PSEL = 0;
		PENABLE = 0;
		$display("APB WRITE : ADDR = %h DATA = %h",addr,data);
	end
endtask

task apb_read(input [31:0] addr);
	begin
		@(posedge clk);
		PADDR = addr;
		PWRITE = 0;
		PSEL = 1;
		PENABLE = 0;

		@(posedge clk);
		PENABLE = 1;

		@(posedge clk);
		@(posedge clk);

		$display("APB READ : ADDR = %h DATA = %h", addr, PRDATA);
		PSEL = 0;
		PENABLE = 0;
	end
endtask

initial begin
	$dumpfile("apb_uart_dump.vcd");
	$dumpvars();
end
endmodule



