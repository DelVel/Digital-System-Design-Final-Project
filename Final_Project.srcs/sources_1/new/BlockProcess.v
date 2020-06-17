`timescale 1ns / 1ps

// to count level
module Decoder_2(
    input EN,
    input[1:0] S,
    output[3:0] Q
    );
    assign Q[0] = ~S[0] & ~S[1] & EN;
    assign Q[1] = S[0] & ~S[1] & EN;
    assign Q[2] = ~S[0] & S[1] & EN;
    assign Q[3] = S[0] & S[1] & EN;
endmodule

module BlockProcess(

    );
    wire[23:0] lev1[0:15], lev2[0:15], lev3[0:15];
endmodule
