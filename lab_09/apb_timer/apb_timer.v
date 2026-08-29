// APB-based countdown timer
// Register map:
// 0x00 -> Load register
// 0x04 -> Control register (bit[0] : start/stop)
// 0x08 -> Status register (bit[0] : timer_done)
`timescale 1ns/1ps
module apb_timer #(
 parameter WIDTH = 8 // Counter width
)(
 // APB interface
 input wire PCLK, // APB clock
 input wire PRESETn, // Active-low reset
 input wire PSEL, // Peripheral select
 input wire PENABLE, // Access phase indicator
 input wire PWRITE, // 1 = write, 0 = read
 input wire [7:0] PADDR, // Register address
 input wire [31:0] PWDATA, // Write data
 output reg [31:0] PRDATA, // Read data
 // Timer status output
 output reg timer_done
);
 // Internal timer registers
 reg [WIDTH-1:0] load_val; // Programmed timer value
 reg [WIDTH-1:0] count; // Active counter
 reg running; // Timer enable

 // APB write path
 // Valid write: PSEL=1, PENABLE=1, PWRITE=1
 always @(posedge PCLK or negedge PRESETn) begin
 if (!PRESETn) begin
 load_val <= 0;
 running <= 0;
 end
 else if (PSEL && PENABLE && PWRITE) begin
 case (PADDR)
 8'h00: load_val <= PWDATA[WIDTH-1:0];
 8'h04: running <= PWDATA[0];
 default : ;
 endcase
 end
 end
 // APB read path
 // Valid read: PSEL=1, PWRITE=0
 always @(*) begin
 PRDATA = 32'h0;
 if (PSEL && !PWRITE) begin
 case (PADDR)
 8'h00: PRDATA = {{(32-WIDTH){1'b0}}, load_val};
 8'h04: PRDATA = {31'b0, running};
 8'h08: PRDATA = {31'b0, timer_done};
 default: PRDATA = 32'h0;
 endcase
 end
 end
 // Timer logic
 // Counter decrements while running
 // On reaching zero, timer_done is asserted
 always @(posedge PCLK or negedge PRESETn) begin
 if (!PRESETn) begin
 count <= 0;
 timer_done <= 0;
 end
 else if (running) begin
 if (count == 0) begin
 count <= load_val;
 timer_done <= 1;
 running <= 0;
 end
 else begin
 count <= count - 1;
 timer_done <= 0;
 end
 end
 end
endmodule
