`timescale 1ns / 1ps

module SRlatch(
    input S,
    input R,
    output Q,
    output _Q
    );
    assign Q = ~(_Q & S);
    assign _Q = ~(Q & R);
endmodule

module Dlatch(
    input D,
    input E,
    output Q,
    output _Q
    );
    SRlatch sr(~(D & E), ~(~D & E), Q, _Q); 
endmodule

module tristate_buffer(
    input in,
    input E,
    output out
    );
	assign out = E ? in : 1'bz;	
endmodule

module RAM(
    input DATA,
    input WR,
    input CS,
    output OUT
    );
    reg temp[0:1];
    Dlatch d(DATA, WR & CS, temp[0], temp[1]);
    tristate_buffer bf(temp[0], CS, OUT);
endmodule
