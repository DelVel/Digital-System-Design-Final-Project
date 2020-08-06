`timescale 1ns / 1ps

module Bitwith_4_4x1_MUX(
    input [3:0]a,b,c,d,
    input [1:0]s,
    output[3:0]r
    );
    Bitwith_1_4x1_MUX aaa(a[0],b[0],c[0],d[0],s,r[0]);
    Bitwith_1_4x1_MUX aba(a[1],b[1],c[1],d[1],s,r[1]);
    Bitwith_1_4x1_MUX aca(a[2],b[2],c[2],d[2],s,r[2]);
    Bitwith_1_4x1_MUX ada(a[3],b[3],c[3],d[3],s,r[3]);
endmodule // Bitwith_4_4x1_MUX

module Bitwith_1_4x1_MUX(
    input a,b,c,d,
    input [1:0]s,
    output r
    );
    assign r = ~s[0] & ~s[1] & a | s[0] & ~s[1] & b | ~s[0] & s[1] & c | s[0] & s[1] & d;
endmodule // Bitwith_1_4x1_MUX

module Bitwith_1_4x1_MUX_3_4_meld(
    input a,b,c,
    input [1:0]s,
    output r
    );
    assign r = ~s[0] & ~s[1] & a | s[0] & ~s[1] & b | ~s[0] & s[1] & c | s[0] & s[1] & c;
endmodule // Bitwith_1_4x1_MUX_3_4_meld

module Bitwith_4_4x1_MUX_3_4_meld (
    input [3:0]a,b,c,
    input [1:0]s,
    output [3:0]r
    );
    Bitwith_1_4x1_MUX_3_4_meld b5(a[3],b[3],c[3],s,r[3]);
    Bitwith_1_4x1_MUX_3_4_meld be(a[2],b[2],c[2],s,r[2]);
    Bitwith_1_4x1_MUX_3_4_meld ae(a[1],b[1],c[1],s,r[1]);
    Bitwith_1_4x1_MUX_3_4_meld b4(a[0],b[0],c[0],s,r[0]);
endmodule

module Bitwith_3_4x1_MUX_3_4_meld (
    input [2:0]a,b,c,
    input [1:0]s,
    output [2:0]r
    );
    Bitwith_1_4x1_MUX_3_4_meld be(a[2],b[2],c[2],s,r[2]);
    Bitwith_1_4x1_MUX_3_4_meld ae(a[1],b[1],c[1],s,r[1]);
    Bitwith_1_4x1_MUX_3_4_meld b4(a[0],b[0],c[0],s,r[0]);
endmodule

module Bitwith_1_2x1_MUX (
    input a,b,
    input s,
    output r
    );
    assign r = a & ~s | b & s;
endmodule // Bitwith_1_2x1_MUX

module Bitwith_96_2x1_MUX (
    input [95:0]a,b,
    input s,
    output [95:0]r
    );
    Bitwith_1_2x1_MUX B0(a[0],b[0],s,r[0]);
    Bitwith_1_2x1_MUX B1(a[1],b[1],s,r[1]);
    Bitwith_1_2x1_MUX B2(a[2],b[2],s,r[2]);
    Bitwith_1_2x1_MUX B3(a[3],b[3],s,r[3]);
    Bitwith_1_2x1_MUX B4(a[4],b[4],s,r[4]);
    Bitwith_1_2x1_MUX B5(a[5],b[5],s,r[5]);
    Bitwith_1_2x1_MUX B6(a[6],b[6],s,r[6]);
    Bitwith_1_2x1_MUX B7(a[7],b[7],s,r[7]);
    Bitwith_1_2x1_MUX B8(a[8],b[8],s,r[8]);
    Bitwith_1_2x1_MUX B9(a[9],b[9],s,r[9]);
    Bitwith_1_2x1_MUX B10(a[10],b[10],s,r[10]);
    Bitwith_1_2x1_MUX B11(a[11],b[11],s,r[11]);
    Bitwith_1_2x1_MUX B12(a[12],b[12],s,r[12]);
    Bitwith_1_2x1_MUX B13(a[13],b[13],s,r[13]);
    Bitwith_1_2x1_MUX B14(a[14],b[14],s,r[14]);
    Bitwith_1_2x1_MUX B15(a[15],b[15],s,r[15]);
    Bitwith_1_2x1_MUX B16(a[16],b[16],s,r[16]);
    Bitwith_1_2x1_MUX B17(a[17],b[17],s,r[17]);
    Bitwith_1_2x1_MUX B18(a[18],b[18],s,r[18]);
    Bitwith_1_2x1_MUX B19(a[19],b[19],s,r[19]);
    Bitwith_1_2x1_MUX B20(a[20],b[20],s,r[20]);
    Bitwith_1_2x1_MUX B21(a[21],b[21],s,r[21]);
    Bitwith_1_2x1_MUX B22(a[22],b[22],s,r[22]);
    Bitwith_1_2x1_MUX B23(a[23],b[23],s,r[23]);
    Bitwith_1_2x1_MUX B24(a[24],b[24],s,r[24]);
    Bitwith_1_2x1_MUX B25(a[25],b[25],s,r[25]);
    Bitwith_1_2x1_MUX B26(a[26],b[26],s,r[26]);
    Bitwith_1_2x1_MUX B27(a[27],b[27],s,r[27]);
    Bitwith_1_2x1_MUX B28(a[28],b[28],s,r[28]);
    Bitwith_1_2x1_MUX B29(a[29],b[29],s,r[29]);
    Bitwith_1_2x1_MUX B30(a[30],b[30],s,r[30]);
    Bitwith_1_2x1_MUX B31(a[31],b[31],s,r[31]);
    Bitwith_1_2x1_MUX B32(a[32],b[32],s,r[32]);
    Bitwith_1_2x1_MUX B33(a[33],b[33],s,r[33]);
    Bitwith_1_2x1_MUX B34(a[34],b[34],s,r[34]);
    Bitwith_1_2x1_MUX B35(a[35],b[35],s,r[35]);
    Bitwith_1_2x1_MUX B36(a[36],b[36],s,r[36]);
    Bitwith_1_2x1_MUX B37(a[37],b[37],s,r[37]);
    Bitwith_1_2x1_MUX B38(a[38],b[38],s,r[38]);
    Bitwith_1_2x1_MUX B39(a[39],b[39],s,r[39]);
    Bitwith_1_2x1_MUX B40(a[40],b[40],s,r[40]);
    Bitwith_1_2x1_MUX B41(a[41],b[41],s,r[41]);
    Bitwith_1_2x1_MUX B42(a[42],b[42],s,r[42]);
    Bitwith_1_2x1_MUX B43(a[43],b[43],s,r[43]);
    Bitwith_1_2x1_MUX B44(a[44],b[44],s,r[44]);
    Bitwith_1_2x1_MUX B45(a[45],b[45],s,r[45]);
    Bitwith_1_2x1_MUX B46(a[46],b[46],s,r[46]);
    Bitwith_1_2x1_MUX B47(a[47],b[47],s,r[47]);
    Bitwith_1_2x1_MUX B48(a[48],b[48],s,r[48]);
    Bitwith_1_2x1_MUX B49(a[49],b[49],s,r[49]);
    Bitwith_1_2x1_MUX B50(a[50],b[50],s,r[50]);
    Bitwith_1_2x1_MUX B51(a[51],b[51],s,r[51]);
    Bitwith_1_2x1_MUX B52(a[52],b[52],s,r[52]);
    Bitwith_1_2x1_MUX B53(a[53],b[53],s,r[53]);
    Bitwith_1_2x1_MUX B54(a[54],b[54],s,r[54]);
    Bitwith_1_2x1_MUX B55(a[55],b[55],s,r[55]);
    Bitwith_1_2x1_MUX B56(a[56],b[56],s,r[56]);
    Bitwith_1_2x1_MUX B57(a[57],b[57],s,r[57]);
    Bitwith_1_2x1_MUX B58(a[58],b[58],s,r[58]);
    Bitwith_1_2x1_MUX B59(a[59],b[59],s,r[59]);
    Bitwith_1_2x1_MUX B60(a[60],b[60],s,r[60]);
    Bitwith_1_2x1_MUX B61(a[61],b[61],s,r[61]);
    Bitwith_1_2x1_MUX B62(a[62],b[62],s,r[62]);
    Bitwith_1_2x1_MUX B63(a[63],b[63],s,r[63]);
    Bitwith_1_2x1_MUX B64(a[64],b[64],s,r[64]);
    Bitwith_1_2x1_MUX B65(a[65],b[65],s,r[65]);
    Bitwith_1_2x1_MUX B66(a[66],b[66],s,r[66]);
    Bitwith_1_2x1_MUX B67(a[67],b[67],s,r[67]);
    Bitwith_1_2x1_MUX B68(a[68],b[68],s,r[68]);
    Bitwith_1_2x1_MUX B69(a[69],b[69],s,r[69]);
    Bitwith_1_2x1_MUX B70(a[70],b[70],s,r[70]);
    Bitwith_1_2x1_MUX B71(a[71],b[71],s,r[71]);
    Bitwith_1_2x1_MUX B72(a[72],b[72],s,r[72]);
    Bitwith_1_2x1_MUX B73(a[73],b[73],s,r[73]);
    Bitwith_1_2x1_MUX B74(a[74],b[74],s,r[74]);
    Bitwith_1_2x1_MUX B75(a[75],b[75],s,r[75]);
    Bitwith_1_2x1_MUX B76(a[76],b[76],s,r[76]);
    Bitwith_1_2x1_MUX B77(a[77],b[77],s,r[77]);
    Bitwith_1_2x1_MUX B78(a[78],b[78],s,r[78]);
    Bitwith_1_2x1_MUX B79(a[79],b[79],s,r[79]);
    Bitwith_1_2x1_MUX B80(a[80],b[80],s,r[80]);
    Bitwith_1_2x1_MUX B81(a[81],b[81],s,r[81]);
    Bitwith_1_2x1_MUX B82(a[82],b[82],s,r[82]);
    Bitwith_1_2x1_MUX B83(a[83],b[83],s,r[83]);
    Bitwith_1_2x1_MUX B84(a[84],b[84],s,r[84]);
    Bitwith_1_2x1_MUX B85(a[85],b[85],s,r[85]);
    Bitwith_1_2x1_MUX B86(a[86],b[86],s,r[86]);
    Bitwith_1_2x1_MUX B87(a[87],b[87],s,r[87]);
    Bitwith_1_2x1_MUX B88(a[88],b[88],s,r[88]);
    Bitwith_1_2x1_MUX B89(a[89],b[89],s,r[89]);
    Bitwith_1_2x1_MUX B90(a[90],b[90],s,r[90]);
    Bitwith_1_2x1_MUX B91(a[91],b[91],s,r[91]);
    Bitwith_1_2x1_MUX B92(a[92],b[92],s,r[92]);
    Bitwith_1_2x1_MUX B93(a[93],b[93],s,r[93]);
    Bitwith_1_2x1_MUX B94(a[94],b[94],s,r[94]);
    Bitwith_1_2x1_MUX B95(a[95],b[95],s,r[95]);
endmodule
