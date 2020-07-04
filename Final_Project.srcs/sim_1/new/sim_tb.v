`timescale 1ns / 1ps

module sim_tb();
    wire[3:0]a;
    wire[2:0]b;
    assign a = 4'b0110;
    assign b = 3'b010;
    wire[95:0]c;
    assign c = 96'b101010010101010101010010100101001010101001010101010010101001010100001010100101010100101001101010;
    wire [95:0]temp;
    assign temp = (1 << a + 12*b) | c;
endmodule
