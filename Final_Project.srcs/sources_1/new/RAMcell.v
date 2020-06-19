`timescale 1ns / 1ps

// active low
module SRlatch(
    input S,
    input R,
    output Q,
    output _Q
    );
    assign Q = ~(_Q & S);
    assign _Q = ~(Q & R);
endmodule

// active high
module Dlatch(
    input D,
    input EN,
    output Q,
    output _Q
    );
    SRlatch sr(~(D & EN), ~(~D & EN), Q, _Q); 
endmodule

module DFF(
    input D,
    input CLK,
    output reg Q
    );
    always @(posedge CLK) begin
        Q=D;
    end 
endmodule

module tristate_buffer(
    input in,
    input EN,
    output out
    );
	assign out = EN ? in : 1'bz;	
endmodule

module RAMcell(
    input DATA,
    input CLK,
    input WR,
    input CS,
    output OUT
    );
    DFF d(DATA, WR & CLK, T1);
    tristate_buffer bf(T1, CS, OUT);
endmodule
