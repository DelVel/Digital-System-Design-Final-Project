`timescale 1ns / 1ps

module BCD_Counter(
    input CLK,
    input reset,
    output [3:0] Q
    );
    DFF D0(~Q[0], CLK, reset, Q[0]);
    DFF D1(~Q[1], ~Q[0], reset, Q[1]);
    DFF D2(~Q[2], ~Q[1], reset, Q[2]);
    DFF D3(~Q[3], ~Q[2], reset, Q[3]);
endmodule
