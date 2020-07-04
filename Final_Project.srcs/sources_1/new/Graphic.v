`timescale 1ns / 1ps

module Graphic(
    input clk,
    input [95:0] view,
    input [11:0] bar,
    output reg [11:0] row,
    output reg [7:0] col
    );
    ClockReducer_1_65536 c(clk, clk2);
    ClockReducer_1_2 d(clk2, red_clk);
    initial begin
        row = 12'b000000000000;
        col = 8'b01111111;
    end

    always @(posedge red_clk) begin
        case (col)
            8'b01111111: begin row <= view[95:84]; col <= 8'b11111110; end
            8'b11111110: begin row <= view[83:72]; col <= 8'b11111101; end
            8'b11111101: begin row <= view[71:60]; col <= 8'b11111011; end
            8'b11111011: begin row <= view[59:48]; col <= 8'b11110111; end
            8'b11110111: begin row <= view[47:36]; col <= 8'b11101111; end
            8'b11101111: begin row <= view[35:24]; col <= 8'b11011111; end
            8'b11011111: begin row <= view[23:12]; col <= 8'b10111111; end
            8'b10111111: begin row <= view[11:0] | bar; col <= 8'b01111111; end
        endcase
    end
endmodule
