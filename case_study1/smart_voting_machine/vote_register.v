`timescale 1ns/1ps
module vote_register (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] d,
    output reg  [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else
            q <= d;
    end
endmodule
