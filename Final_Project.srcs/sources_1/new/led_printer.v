`timescale 1ns / 1ps

module BCD_7SEG_CONV(                                       //test passed
    input [3:0] in,
    output [7:0] seg                                        //0: up, 1: Rup, 2: Rdn, 3: dn, 4: Ldn, 5: Lup, 6: Ct, 7: dp
);
    assign seg[0] = ~(~in[3] & in[2] & in[0] |
~in[2] & ~in[1] & ~in[0] |
in[3] & ~in[2] & ~in[1] |
~in[3] & in[1]);
    assign seg[1] = ~(~in[3] & ~in[2] |
~in[2] & ~in[1] |
~in[3] & in[1] & in[0] |
~in[3] & ~in[1] & ~in[0]);
    assign seg[2] = ~(~in[3] & in[2] |
~in[2] & ~in[1] |
~in[3] & in[0]);
    assign seg[3] = ~(~in[3] & in[2] & ~in[1] & in[0] |
~in[3] & ~in[2] & in[1] |
~in[3] & in[1] & ~in[0] |
~in[2] & ~in[1] & ~in[0] |
in[3] & ~in[2] & ~in[1]);
    assign seg[4] = ~(~in[3] & in[1] & ~in[0] |
~in[2] & ~in[1] & ~in[0]);
    assign seg[5] = ~(~in[3] & ~in[1] & ~in[0] |
~in[3] & in[2] |
in[3] & ~in[2] & ~in[1]);
    assign seg[6] = ~(~in[3] & ~in[2] & in[1] |
~in[3] & in[2] & ~in[0] |
~in[3] & in[2] & ~in[1] |
in[3] & ~in[2] & ~in[1]);
    assign seg[7] = 1;
endmodule // BCD_7SEG_CONV
