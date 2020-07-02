`timescale 1ns / 1ps

module BCD_Adder(
    input[3:0] A,
    input[3:0] B,
    input Cin,
    output[3:0] S,
    output Cout
    );
    wire[3:0] _S, _Cin;
    wire _Cout;
    Adder_4 add1(A, B, Cin, _S, _Cout);
    assign Cout = _Cout | (_S[1] & _S[3]) | (_S[2] & _S[3]);

    assign _Cin[0] = 0;
    assign _Cin[1] = Cout;
    assign _Cin[2] = Cout;
    assign _Cin[3] = 0;

    reg temp;
    Adder_4 add2(_S, _Cin, 0, S, temp);
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
    input clk, increment, reset,
    output [0:7]seg,
    output [3:0]an
    );
    RAM_4 first(DAT,CLK,WR,CS,OUT);
    RAM_4 second(DAT,CLK,WR,CS,OUT);
    RAM_4 third(DAT,CLK,WR,CS,OUT);
    RAM_4 fourth(DAT,CLK,WR,CS,OUT);
endmodule
