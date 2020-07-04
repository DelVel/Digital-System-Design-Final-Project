`timescale 1ns / 1ps

module Decoder_3_8 (
    input[2:0]S,
    output [7:0] Q
    );
    assign Q[0] = ~S[0] & ~S[1] & ~S[2];
    assign Q[1] = S[0] & ~S[1] & ~S[2];
    assign Q[2] = ~S[0] & S[1] & ~S[2];
    assign Q[3] = S[0] & S[1] & ~S[2];
    assign Q[4] = ~S[0] & ~S[1] & S[2];
    assign Q[5] = S[0] & ~S[1] & S[2];
    assign Q[6] = ~S[0] & S[1] & S[2];
    assign Q[7] = S[0] & S[1] & S[2];
endmodule

module Decoder_4_16(
    input[3:0] S,
    output[15:0] Q
    );
    assign Q[0] = ~S[0] & ~S[1] & ~S[2] & ~S[3];
    assign Q[1] = S[0] & ~S[1] & ~S[2] & ~S[3];
    assign Q[2] = ~S[0] & S[1] & ~S[2] & ~S[3];
    assign Q[3] = S[0] & S[1] & ~S[2] & ~S[3];
    assign Q[4] = ~S[0] & ~S[1] & S[2] & ~S[3];
    assign Q[5] = S[0] & ~S[1] & S[2] & ~S[3];
    assign Q[6] = ~S[0] & S[1] & S[2] & ~S[3];
    assign Q[7] = S[0] & S[1] & S[2] & ~S[3];
    assign Q[8] = ~S[0] & ~S[1] & ~S[2] & S[3];
    assign Q[9] = S[0] & ~S[1] & ~S[2] & S[3];
    assign Q[10] = ~S[0] & S[1] & ~S[2] & S[3];
    assign Q[11] = S[0] & S[1] & ~S[2] & S[3];
    assign Q[12] = ~S[0] & ~S[1] & S[2] & S[3];
    assign Q[13] = S[0] & ~S[1] & S[2] & S[3];
    assign Q[14] = ~S[0] & S[1] & S[2] & S[3];
    assign Q[15] = S[0] & S[1] & S[2] & S[3];
endmodule
