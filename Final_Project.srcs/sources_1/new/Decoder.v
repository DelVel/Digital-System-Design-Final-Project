`timescale 1ns / 1ps

module Decoder_4_16(
    input[3:0] S,
    input en,
    output[15:0] Q
    );
    assign Q[0] = ~S[0] & ~S[1] & ~S[2] & ~S[3] & en;
    assign Q[1] = S[0] & ~S[1] & ~S[2] & ~S[3] & en;
    assign Q[2] = ~S[0] & S[1] & ~S[2] & ~S[3] & en;
    assign Q[3] = S[0] & S[1] & ~S[2] & ~S[3] & en;
    assign Q[4] = ~S[0] & ~S[1] & S[2] & ~S[3] & en;
    assign Q[5] = S[0] & ~S[1] & S[2] & ~S[3] & en;
    assign Q[6] = ~S[0] & S[1] & S[2] & ~S[3] & en;
    assign Q[7] = S[0] & S[1] & S[2] & ~S[3] & en;
    assign Q[8] = ~S[0] & ~S[1] & ~S[2] & S[3] & en;
    assign Q[9] = S[0] & ~S[1] & ~S[2] & S[3] & en;
    assign Q[10] = ~S[0] & S[1] & ~S[2] & S[3] & en;
    assign Q[11] = S[0] & S[1] & ~S[2] & S[3] & en;
    assign Q[12] = ~S[0] & ~S[1] & S[2] & S[3] & en;
    assign Q[13] = S[0] & ~S[1] & S[2] & S[3] & en;
    assign Q[14] = ~S[0] & S[1] & S[2] & S[3] & en;
    assign Q[15] = S[0] & S[1] & S[2] & S[3] & en;
endmodule

module Decoder_5_32(
    input [4:0] S,
    input en,
    output [31:0] Q
    );
    Decoder_4_16 D1(S[3:0], ~S[4] & en, Q[15:0]);
    Decoder_4_16 D2(S[3:0], S[4] & en, Q[31:16]);
endmodule // Decoder_5_32

module Decoder_6_64(
    input [5:0] S,
    input en,
    output [63:0] Q
    );
    Decoder_5_32 D1(S[4:0], ~S[5] & en, Q[31:0]);
    Decoder_5_32 D2(S[4:0], S[5] & en, Q[63:32]);
endmodule // Decoder_6_64
