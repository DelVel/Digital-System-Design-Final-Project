`timescale 1ns / 1ps

module LED_PRINTER(
    input clk,
    input [15:0] input_short,
    output [6:0] seg,
    output [3:0] an,
    output dp                                               //dot point
);
    assign dp = 0;                                          //dot point is always off
    DFF D0(
        .D((~| an) | an[3] & ~an[0]),
        .CLK(clk),
        .Q(an[0])
    );
    DFF D1(
        .D(an[0] & ~an[1]),
        .CLK(clk),
        .Q(an[1])
    );
    DFF D2(
        .D(an[1] & ~an[2]),
        .CLK(clk),
        .Q(an[2])
    );
    DFF D3(
        .D(an[2] & ~an[3]),
        .CLK(clk),
        .Q(an[3])
    );

endmodule // LED_PRINTER

module BCD_7SEG_CONV(                                       //test passed
    input [3:0] in,
    output [6:0] seg                                        //0: up, 1: Rup, 2: Rdn, 3: dn, 4: Ldn, 5: Lup, 6: Ct
);
    assign seg[0] = ~in[3] & in[2] & in[0] |
~in[2] & ~in[1] & ~in[0] |
in[3] & ~in[2] & ~in[1] |
~in[3] & in[1];
    assign seg[1] = ~in[3] & ~in[2] |
~in[2] & ~in[1] |
~in[3] & in[1] & in[0] |
~in[3] & ~in[1] & ~in[0];
    assign seg[2] = ~in[3] & in[2] |
~in[2] & ~in[1] |
~in[3] & in[0];
    assign seg[3] = ~in[3] & in[2] & ~in[1] & in[0] |
~in[3] & ~in[2] & in[1] |
~in[3] & in[1] & ~in[0] |
~in[2] & ~in[1] & ~in[0] |
in[3] & ~in[2] & ~in[1];
    assign seg[4] = ~in[3] & in[1] & ~in[0] |
~in[2] & ~in[1] & ~in[0];
    assign seg[5] = ~in[3] & ~in[1] & ~in[0] |
~in[3] & in[2] |
in[3] & ~in[2] & ~in[1];
    assign seg[6] = ~in[3] & ~in[2] & in[1] |
~in[3] & in[2] & ~in[0] |
~in[3] & in[2] & ~in[1] |
in[3] & ~in[2] & ~in[1];
endmodule // BCD_7SEG_CONV
