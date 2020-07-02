`timescale 1ns / 1ps

module ROM(
    input [63:0]addr,
    output [11:0]instruction
    );
    reg [11:0] instr [63:0];
endmodule
