`timescale 1ns / 1ps

module DFF(
    input D,
    input CLK,
    input reset,
    output reg Q
    );
    initial begin
        Q <= 0;
    end
    
    // if reset == Low -> reset to 0
    always @(posedge CLK or negedge reset) begin
        if (reset == 0)
            Q <= 0;
        else
            Q <= D;
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
    DFF d(DATA, WR & CLK, 1, T1);
    TRI_BUF bf(T1, CS, OUT);
endmodule
