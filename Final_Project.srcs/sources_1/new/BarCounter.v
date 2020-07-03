`timescale 1ns / 1ps

module BarCounter(
    input [11:0] in,
    input [1:0] button,
    output [11:0] res
    );
    wire T1, T2;
    assign T1 = in[0] & in[1] & in[2];
    assign T2 = in[9] & in[10] & in[11];
    Bitwith_1_4x1_MUX_3_4_meld T01(in[0],      in[1] | T1,   1'b0,   button, res[0] );
    Bitwith_1_4x1_MUX_3_4_meld T02(in[1],      in[2] | T1,  in[0],   button, res[1] );
    Bitwith_1_4x1_MUX_3_4_meld T03(in[2],      in[3] | T1,  in[1],   button, res[2] );
    Bitwith_1_4x1_MUX_3_4_meld T04(in[3],           in[4],  in[2],   button, res[3] );
    Bitwith_1_4x1_MUX_3_4_meld T05(in[4],           in[5],  in[3],   button, res[4] );
    Bitwith_1_4x1_MUX_3_4_meld T06(in[5],           in[6],  in[4],   button, res[5] );
    Bitwith_1_4x1_MUX_3_4_meld T07(in[6],           in[7],  in[5],   button, res[6] );
    Bitwith_1_4x1_MUX_3_4_meld T08(in[7],           in[8],  in[6],   button, res[7] );
    Bitwith_1_4x1_MUX_3_4_meld T09(in[8],           in[9],  in[7],   button, res[8] );
    Bitwith_1_4x1_MUX_3_4_meld T10(in[9],    in[10],  in[8]  | T2,   button, res[9] );
    Bitwith_1_4x1_MUX_3_4_meld T11(in[10],    in[11], in[9]  | T2,   button, res[10]);
    Bitwith_1_4x1_MUX_3_4_meld T12(in[11],      1'b0, in[10] | T2,   button, res[11]);
endmodule
