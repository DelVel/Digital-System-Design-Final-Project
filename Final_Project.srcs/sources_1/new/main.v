`timescale 1ns / 1ps

module main(
    // clock input
    input clk,

    //button input
    input btnL,
    input btnR,

    //led segment output
    output [6:0] seg,
    output dp,
    output [3:0] an
);
    reg [23:0] RAM_DATA_IN;                 //data input
    wire [23:0] RAM_DATA_OUT;               //data output
    reg WR;                                 //read-write mode
    reg [3:0] RAM_ADDR;                     //RAM address

    RAM ram(                                //RAM module
        .DATA(RAM_DATA_IN),
        .CLK(clk),
        .WR(WR),
        .ADDR(RAM_ADDR),
        .OUT(RAM_DATA_OUT)
    );

endmodule // main
