module voting_system(
	input wire clk,rst,en_global,d0,d1,d2,d3,
	input wire [1:0] sel,
	output wire [3:0] v,
	output wire [2:0] count,
	output wire max_vote
);

wire mux_y;
wire dec_en;
wire [3:0] dec_y;


 mux_4x1 u_mux (
        .i0(d0), .i1(d1), .i2(d2), .i3(d3),
        .sel(sel),
        .y(mux_y)
    );
 
    // Vote is valid only if the system is enabled AND the selected input is high
    assign dec_en = en_global & mux_y;
 
    // Block 2 : decode which candidate
    decoder2to4 u_dec (
        .a(sel),
        .en(dec_en),
        .y(dec_y)
    );
 
    // Block 3 : register the vote
    vote_register u_reg (
        .clk(clk),
        .rst(rst),
        .d(dec_y),
        .q(v)
    );
 
    // Block 4 : count total votes
    vote_counter u_cnt (
        .clk(clk),
        .rst(rst),
        .v(v),
        .count(count),
        .max_vote(max_vote)
    );
    endmodule

