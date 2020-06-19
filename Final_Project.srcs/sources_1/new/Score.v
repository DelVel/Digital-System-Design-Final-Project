`timescale 1ns / 1ps

// for ripple adder
module FA(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );
    assign S = A ^ B ^ Cin;
    assign Cout = ((A ^ B) & Cin) | (A & B);
endmodule

module Adder(
    input[3:0] A,
    input[3:0] B,
    input Cin,
    output[3:0] S,
    output Cout
    );
    wire[3:0] cout;
    FA fa0(A[0], B[0], Cin, S[0], cout[0]);
    FA fa1(A[1], B[1], cout[0], S[1], cout[1]);
    FA fa2(A[2], B[2], cout[1], S[2], cout[2]);
    FA fa3(A[3], B[3], cout[2], S[3], cout[3]);
endmodule

module BCD_Adder(
    input[3:0] A,
    input[3:0] B,
    input Cin,
    output[3:0] S,
    output Cout
    );
    wire[3:0] _S, _Cin;
    wire _Cout;
    Adder add1(A, B, Cin, _S, _Cout);
    assign Cout = _Cout | (_S[1] & _S[3]) | (_S[2] & _S[3]);

    assign _Cin[0] = 0;
    assign _Cin[1] = Cout;
    assign _Cin[2] = Cout;
    assign _Cin[3] = 0;

    reg temp;
    Adder add2(_S, _Cin, 0, S, temp);
endmodule

module Segmentation(
    input[3:0] IN,
    output[6:0] OUT
    );
    assign OUT[0] = (IN[1] & IN[3]) | (~IN[1] & ~IN[3]) | IN[0] | IN[3];
    assign OUT[1] = (IN[2] & IN[3]) | (~IN[2] & ~IN[3]) | ~IN[1];
    assign OUT[2] = IN[1] | ~IN[2] | IN[3];
    assign OUT[3] = (IN[2] & ~IN[3]) | (~IN[1] & ~IN[3]) | (~IN[1] & IN[2]) |
    (IN[1] & ~IN[2] & IN[3]) | IN[0];
    assign OUT[4] = (IN[2] & IN[3]) | (~IN[1] & ~IN[3]);
    assign OUT[5] = (IN[1] & ~IN[3]) | (~IN[1] & ~IN[3]) | (IN[1] & ~IN[2]) | IN[0];
    assign OUT[6] = (IN[2] & ~IN[3]) | (IN[2] & ~IN[2]) | IN[0] | (~IN[1] & IN[2]);
endmodule

module Score(
    input S
    );
    wire[7:0] sum;
    assign sum[0] = 1;
    assign sum[1] = 0;
    assign sum[2] = 0;
    assign sum[3] = S;
    assign sum[4] = S;
    assign sum[5] = 0;
    assign sum[6] = 0;
    assign sum[7] = 0;

    wire[23:0] memo;
    RAM Rram(0, 0, 1, 4'b1111, memo);

    wire[23:0] score;
    wire[5:0] cout;
    BCD_Adder bcd0(memo[3:0], sum[3:0], 0, score[3:0], cout[0]);
    BCD_Adder bcd1(memo[7:4], sum[7:4], cout[0], score[7:4], cout[1]);
    BCD_Adder bcd2(memo[11:8], 0, cout[1], score[11:8], cout[2]);
    BCD_Adder bcd3(memo[15:12], 0, cout[2], score[15:12], cout[3]);
    BCD_Adder bcd4(memo[19:16], 0, cout[3], score[19:16], cout[4]);
    BCD_Adder bcd5(memo[23:20], 0, cout[4], score[23:20], cout[5]);

    wire[23:0] temp;
    RAM Wram(score, 1, 1, 4'b1111, temp);
endmodule
