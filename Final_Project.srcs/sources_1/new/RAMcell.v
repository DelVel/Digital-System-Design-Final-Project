`timescale 1ns / 1ps

module DFF(
    input D,
    input CLK,
    output reg Q
    );
    always @(posedge CLK) begin
        Q = D;
    end
endmodule

module TRI_BUF(
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
    TRI_BUF bf(T1, CS, OUT);
endmodule
