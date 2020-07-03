`timescale 1ns / 1ps

module HalfAdder(
    input a, b,
    output s, c
    );
    assign s = a ^ b;
    assign c = a & b;
endmodule // HalfAdder

module FullAdder(
    input a, b, c_in,
    output s, c_out
    );
    HalfAdder H1(a, b, _Ts, _Tc1);
    HalfAdder H2(c_in, _Ts, s, _Tc2);
    assign c_out = _Tc1 | _Tc2;
endmodule // FullAdder

module HalfSubtractor(
    input a, m,
    output s, b
    );
    assign s = a ^ m;
    assign b = ~a & m;
endmodule // HalfSubtractor

module FullSubtractor(
    input a, m, b_in,
    output s, b_out
    );
    HalfSubtractor H1(a, m, _Ts, _Tb1);
    HalfSubtractor H2(_Ts, b_in, s, _Tb2);
    assign b_out = _Tb1 | _Tb2;
endmodule // FullSubtractor

module Adder_2(
    input [1:0]a, b,
    input c_in,
    output [1:0]s,
    output c_out
    );
    FullAdder F1(a[0], b[0], c_in, s[0], _Tc);
    FullAdder F2(a[1], b[1], _Tc, s[1], c_out);
endmodule // Adder_2

module Adder_4(
    input [3:0]a, b,
    input c_in,
    output [3:0]s,
    output c_out
    );
    Adder_2 F1(a[1:0], b[1:0], c_in, s[1:0], _Tc);
    Adder_2 F2(a[3:2], b[3:2], _Tc, s[3:2], c_out);
endmodule // Adder_4

module Adder_WORD(
    input [7:0]a, b,
    input c_in,
    output [7:0]s,
    output c_out
    );
    Adder_4 F1(a[3:0], b[3:0], c_in, s[3:0], _Tc);
    Adder_4 F2(a[7:4], b[7:4], _Tc, s[7:4], c_out);
endmodule // Adder_WORD

module Subtractor_2(
    input [1:0]a, m,
    input b_in,
    output [1:0]s,
    output b_out
    );
    FullSubtractor F1(a[0],m[0],b_in,s[0],_Tb);
    FullSubtractor F2(a[1],m[1],_Tb,s[1],b_out);
endmodule // Subtractor_2

module Subtractor_4(
    input [3:0]a, m,
    input b_in,
    output [3:0]s,
    output b_out
    );
    Subtractor_2 F1(a[1:0],m[1:0],b_in,s[1:0],_Tb);
    Subtractor_2 F2(a[3:2],m[3:2],_Tb,s[3:2],b_out);
endmodule // Subtractor_4

module Subtractor_WORD(
    input [7:0]a, m,
    input b_in,
    output [7:0]s,
    output b_out
    );
    Subtractor_4 F1(a[3:0],m[3:0],b_in,s[3:0],_Tb);
    Subtractor_4 F2(a[7:4],m[7:4],_Tb,s[7:4],b_out);
endmodule // Subtractor_WORD

module Comparator(
    input a, b, enable,
    output a_g, eq, b_g
    );
    assign a_g = a & ~b & enable;
    assign eq = (~a ^ b) & enable;
    assign b_g = ~a & b & enable;
endmodule // Comparator

module Comparator_2(
    input [1:0]a, b,
    input enable,
    output a_g, eq, b_g
    );
    Comparator C1(a[1],b[1],enable,_Tag1,_Teq,_Tbg1);
    Comparator C2(a[0],b[0],_Teq,_Tag2,eq,_Tbg2);
    assign a_g = _Tag1 | _Tag2;
    assign b_g = _Tbg1 | _Tbg2;
endmodule // Comparator_2

module Comparator_4(
    input [3:0]a, b,
    input enable,
    output a_g, eq, b_g
    );
    Comparator_2 C1(a[3:2],b[3:2],enable,_Tag1,_Teq,_Tbg1);
    Comparator_2 C2(a[1:0],b[1:0],_Teq,_Tag2,eq,_Tbg2);
    assign a_g = _Tag1 | _Tag2;
    assign b_g = _Tbg1 | _Tbg2;
endmodule // Comparator_4

module Comparator_WORD(
    input [7:0]a, b,
    input enable,
    output a_g, eq, b_g
    );
    Comparator_4 C1(a[7:4],b[7:4],enable,_Tag1,_Teq,_Tbg1);
    Comparator_4 C2(a[3:0],b[3:0],_Teq,_Tag2,eq,_Tbg2);
    assign a_g = _Tag1 | _Tag2;
    assign b_g = _Tbg1 | _Tbg2;
endmodule // Comparator_WORD

module Bitwith_4_4x1_MUX(
    input [3:0]a,b,c,d,
    input [1:0]s,
    output[3:0]r
    );
    Bitwith_1_4x1_MUX aaa(a[0],b[0],c[0],d[0],s,r[0]);
    Bitwith_1_4x1_MUX aba(a[1],b[1],c[1],d[1],s,r[1]);
    Bitwith_1_4x1_MUX aca(a[2],b[2],c[2],d[2],s,r[2]);
    Bitwith_1_4x1_MUX ada(a[3],b[3],c[3],d[3],s,r[3]);
endmodule // Bitwith_4_4x1_MUX

module Bitwith_1_4x1_MUX(
    input a,b,c,d,
    input [1:0]s,
    output r
    );
    assign r = ~s[0] & ~s[1] & a | s[0] & ~s[1] & b | ~s[0] & s[1] & c | s[0] & s[1] & d;
endmodule // Bitwith_1_4x1_MUX

module Bitwith_1_4x1_MUX_3_4_meld(
    input a,b,c,
    input [1:0]s,
    output r
    );
    assign r = ~s[0] & ~s[1] & a | s[0] & ~s[1] & b | ~s[0] & s[1] & c | s[0] & s[1] & c;
endmodule // Bitwith_1_4x1_MUX_3_4_meld

module Bitwith_1_2x1_MUX (
    input a,b,
    input s,
    output r
);
    assign r = a & ~s | b & s;
endmodule // Bitwith_1_2x1_MUX

module Bitwith_4_2x1_MUX (
    input [3:0]a,b,
    input s,
    output [3:0] r
);
    Bitwith_1_2x1_MUX a(a[0],b[0],s,r[0]);
    Bitwith_1_2x1_MUX b(a[1],b[1],s,r[1]);
    Bitwith_1_2x1_MUX c(a[2],b[2],s,r[2]);
    Bitwith_1_2x1_MUX d(a[3],b[3],s,r[3]);
endmodule // Bitwith_4_2x1_MUX
