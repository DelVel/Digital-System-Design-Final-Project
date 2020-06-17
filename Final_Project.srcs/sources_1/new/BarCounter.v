`timescale 1ns / 1ps

module BarCounter(
    input LR,
    output[23:0] OUT
    );
    wire[23:0] bar;
    RAM Rram(0, 0, 1, 4'b1110, bar);
    
    wire[23:0] temp1, temp2;
    assign temp1 = bar >> 1;
    assign temp2 = bar << 1;
    assign OUT = (~bar[0] & temp1 & LR) | (~bar[23] & temp2 & ~LR) | (bar[0] & bar & LR) | (bar[23] & bar & ~LR);
endmodule
