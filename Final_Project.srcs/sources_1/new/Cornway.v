`timescale 1ns / 1ps

module CornWay (
    // clock input
    input clk,
    //button input
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    input btnD,
    //switch input
    input [3:0]sw,
    //led output
    output [3:0]led,
    //display output
    output [11:0] row,
    output [7:0] col,
    //7seg output
    output [7:0]seg,
    output [3:0]an
    );
    ClockReducer_1_100 miSec(clk,tmpclk1);
    ClockReducer_1_100 hundMiSec(tmpclk1,tmpclk2);
    ClockReducer_1_100 tenMilSec(tmpclk2,tmpclk3);
    ClockReducer_1_4 fourtymilSec(tmpclk3,tmpclk5);
    ClockReducer_1_16 hundsixMilSec(tmpclk3,tmpclk4);
    ClockReducer_1_4 Mil_640sec(tmpclk4,milCLK);
    Bitwith_1_2x1_MUX CLKchooser(milCLK,tmpclk5,sw[2],usingCLK);
    assign led = sw;
    wire [95:0]nextBoard,out,toPrint;
    wire[3:0]curXin,cursorX;
    wire[2:0]curYin,cursorY;
    Bit_4_RAM curX(curXin,tmpclk5,cursorX);
    Bit_3_RAM curY(curYin,tmpclk5,cursorY);
    CursorHandler CHANDEVI(btnL,btnR,btnU,btnD,cursorX,cursorY,curXin,curYin);
    Bitwith_96_2x1_MUX previewMUX(out,nextBoard,sw[3],toPrint);
    Score score(clk,~usingCLK & sw[1],seg,an);
    RAM mainRam(nextBoard,usingCLK,sw[0], ~sw[1], cursorX, cursorY, out,btnC);
    NextBoard N(out, nextBoard);
    Graphic2 graphic(clk,toPrint,cursorX,cursorY,~sw[1],row,col,sw[3]);

endmodule // CornWay

module CursorHandler(
    input L,R,U,D,
    input [3:0]x,
    input [2:0]y,
    output [3:0]dx,
    output[2:0]dy
    );
    Bit_4_Comparator b1(x,4'b0000,xzero);
    Bit_4_Comparator b2(x,4'b1011,xfull);
    Bit_3_Comparator b3(y,3'b000,yzero);
    Bit_3_Comparator b4(y,3'b111,yfull);
    Bitwith_4_4x1_MUX_3_4_meld eb(x,x-4'b0001,x+4'b0001,{L & ~xfull,R & ~xzero},dx);
    Bitwith_3_4x1_MUX_3_4_meld er(y,y-3'b001,y+3'b001,{U & ~yfull,D & ~yzero},dy);
endmodule

module Bit_4_RAM (
    input[3:0]dat,
    input clk,
    output [3:0]q
    );
    DFF D1(dat[0],clk,q[0]);
    DFF D2(dat[1],clk,q[1]);
    DFF D3(dat[2],clk,q[2]);
    DFF D4(dat[3],clk,q[3]);
endmodule

module Bit_3_RAM (
    input[2:0]dat,
    input clk,
    output [2:0]q
    );
    DFF D1(dat[0],clk,q[0]);
    DFF D2(dat[1],clk,q[1]);
    DFF D3(dat[2],clk,q[2]);
endmodule

module Graphic2(
    input clk,
    input [95:0] view,
    input [3:0]cX,
    input [2:0]cY,
    input cursor_en,
    output reg [11:0] row,
    output reg [7:0] col,
    input sw3
    );
    ClockReducer_1_65536 c(clk, clk2);
    ClockReducer_1_2 d(clk2, red_clk);
    wire [95:0]temp;
    assign temp = ((cursor_en & ~sw3) << cX + 12*cY) | view;
    initial begin
        row = 12'b000000000000;
        col = 8'b01111111;
    end
    always @(posedge red_clk) begin
        case (col)
            8'b01111111: begin row <= temp[95:84]; col <= 8'b11111110; end
            8'b11111110: begin row <= temp[83:72]; col <= 8'b11111101; end
            8'b11111101: begin row <= temp[71:60]; col <= 8'b11111011; end
            8'b11111011: begin row <= temp[59:48]; col <= 8'b11110111; end
            8'b11110111: begin row <= temp[47:36]; col <= 8'b11101111; end
            8'b11101111: begin row <= temp[35:24]; col <= 8'b11011111; end
            8'b11011111: begin row <= temp[23:12]; col <= 8'b10111111; end
            8'b10111111: begin row <= temp[11:0]; col <= 8'b01111111; end
        endcase
    end
endmodule

module Surrounding1 (
    input a,b,c,d,e,f,g,h,
    output[3:0]r
    );
    assign r = a+b+c+d+e+f+g+h;
endmodule

module Bit_4_Comparator (
    input[3:0]a,b,
    output c
    );
    assign c = & (a ~^ b);
endmodule

module Bit_3_Comparator (
    input[2:0]a,b,
    output c
    );
    assign c = & (a ~^ b);
endmodule

module NextState(
    input current,
    input a,b,c,d,e,f,g,h,
    output next
    );
    wire [3:0]r;
    Surrounding1 aaa(a,b,c,d,e,f,g,h,r);
    Bit_4_Comparator affa(r, 4'b0010, istwo);
    Bit_4_Comparator esfd(r, 4'b0011, isthree);
    assign next = isthree | current & istwo;
endmodule

module NextBoard (
    input [95:0]init,
    output [95:0]res
    );
    NextState N0(init[0] ,init[12],1'b0,1'b0,1'b0,1'b0,    1'b0,    init[1], init[13],res[0]);
    NextState N1(init[12],init[24],1'b0,1'b0,1'b0,init[0], init[1], init[13],init[25],res[12]);
    NextState N2(init[24],init[36],1'b0,1'b0,1'b0,init[12],init[13],init[25],init[37],res[24]);
    NextState N3(init[36],init[48],1'b0,1'b0,1'b0,init[24],init[25],init[37],init[49],res[36]);
    NextState N4(init[48],init[60],1'b0,1'b0,1'b0,init[36],init[37],init[49],init[61],res[48]);
    NextState N5(init[60],init[72],1'b0,1'b0,1'b0,init[48],init[49],init[61],init[73],res[60]);
    NextState N6(init[72],init[84],1'b0,1'b0,1'b0,init[60],init[61],init[73],init[85],res[72]);
    NextState N7(init[84],1'b0,    1'b0,1'b0,1'b0,init[72],init[73],init[85],1'b0,    res[84]);

    NextState N8(init[1],init[13],init[12],init[0],1'b0,1'b0,1'b0,init[2],init[14],res[1]);
    NextState N9(init[13],init[25],init[24],init[12],init[0],init[1],init[2],init[14],init[26],res[13]);
    NextState N10(init[25],init[37],init[36],init[24],init[12],init[13],init[14],init[26],init[38],res[25]);
    NextState N11(init[37],init[49],init[48],init[36],init[24],init[25],init[26],init[38],init[50],res[37]);
    NextState N12(init[49],init[61],init[60],init[48],init[36],init[37],init[38],init[50],init[62],res[49]);
    NextState N13(init[61],init[73],init[72],init[60],init[48],init[49],init[50],init[62],init[74],res[61]);
    NextState N14(init[73],init[85],init[84],init[72],init[60],init[61],init[62],init[74],init[86],res[73]);
    NextState N15(init[85],1'b0,1'b0,init[84],init[72],init[73],init[74],init[86],1'b0,res[85]);

    NextState N16(init[2],init[14],init[13],init[1],1'b0,1'b0,1'b0,init[3],init[15],res[2]);
    NextState N17(init[14],init[26],init[25],init[13],init[1],init[2],init[3],init[15],init[27],res[14]);
    NextState N18(init[26],init[38],init[37],init[25],init[13],init[14],init[15],init[27],init[39],res[26]);
    NextState N19(init[38],init[50],init[49],init[37],init[25],init[26],init[27],init[39],init[51],res[38]);
    NextState N20(init[50],init[62],init[61],init[49],init[37],init[38],init[39],init[51],init[63],res[50]);
    NextState N21(init[62],init[74],init[73],init[61],init[49],init[50],init[51],init[63],init[75],res[62]);
    NextState N22(init[74],init[86],init[85],init[73],init[61],init[62],init[63],init[75],init[87],res[74]);
    NextState N23(init[86],1'b0,1'b0,init[85],init[73],init[74],init[75],init[87],1'b0,res[86]);

    NextState N24(init[3],init[15],init[14],init[2],1'b0,1'b0,1'b0,init[4],init[16],res[3]);
    NextState N25(init[15],init[27],init[26],init[14],init[2],init[3],init[4],init[16],init[28],res[15]);
    NextState N26(init[27],init[39],init[38],init[26],init[14],init[15],init[16],init[28],init[40],res[27]);
    NextState N27(init[39],init[51],init[50],init[38],init[26],init[27],init[28],init[40],init[52],res[39]);
    NextState N28(init[51],init[63],init[62],init[50],init[38],init[39],init[40],init[52],init[64],res[51]);
    NextState N29(init[63],init[75],init[74],init[62],init[50],init[51],init[52],init[64],init[76],res[63]);
    NextState N30(init[75],init[87],init[86],init[74],init[62],init[63],init[64],init[76],init[88],res[75]);
    NextState N31(init[87],1'b0,1'b0,init[86],init[74],init[75],init[76],init[88],1'b0,res[87]);

    NextState N32(init[4],init[16],init[15],init[3],1'b0,1'b0,1'b0,init[5],init[17],res[4]);
    NextState N33(init[16],init[28],init[27],init[15],init[3],init[4],init[5],init[17],init[29],res[16]);
    NextState N34(init[28],init[40],init[39],init[27],init[15],init[16],init[17],init[29],init[41],res[28]);
    NextState N35(init[40],init[52],init[51],init[39],init[27],init[28],init[29],init[41],init[53],res[40]);
    NextState N36(init[52],init[64],init[63],init[51],init[39],init[40],init[41],init[53],init[65],res[52]);
    NextState N37(init[64],init[76],init[75],init[63],init[51],init[52],init[53],init[65],init[77],res[64]);
    NextState N38(init[76],init[88],init[87],init[75],init[63],init[64],init[65],init[77],init[89],res[76]);
    NextState N39(init[88],1'b0,1'b0,init[87],init[75],init[76],init[77],init[89],1'b0,res[88]);

    NextState N40(init[5],init[17],init[16],init[4],1'b0,1'b0,1'b0,init[6],init[18],res[5]);
    NextState N41(init[17],init[29],init[28],init[16],init[4],init[5],init[6],init[18],init[30],res[17]);
    NextState N42(init[29],init[41],init[40],init[28],init[16],init[17],init[18],init[30],init[42],res[29]);
    NextState N43(init[41],init[53],init[52],init[40],init[28],init[29],init[30],init[42],init[54],res[41]);
    NextState N44(init[53],init[65],init[64],init[52],init[40],init[41],init[42],init[54],init[66],res[53]);
    NextState N45(init[65],init[77],init[76],init[64],init[52],init[53],init[54],init[66],init[78],res[65]);
    NextState N46(init[77],init[89],init[88],init[76],init[64],init[65],init[66],init[78],init[90],res[77]);
    NextState N47(init[89],1'b0,1'b0,init[88],init[76],init[77],init[78],init[90],1'b0,res[89]);

    NextState N48(init[6],init[18],init[17],init[5],1'b0,1'b0,1'b0,init[7],init[19],res[6]);
    NextState N49(init[18],init[30],init[29],init[17],init[5],init[6],init[7],init[19],init[31],res[18]);
    NextState N50(init[30],init[42],init[41],init[29],init[17],init[18],init[19],init[31],init[43],res[30]);
    NextState N51(init[42],init[54],init[53],init[41],init[29],init[30],init[31],init[43],init[55],res[42]);
    NextState N52(init[54],init[66],init[65],init[53],init[41],init[42],init[43],init[55],init[67],res[54]);
    NextState N53(init[66],init[78],init[77],init[65],init[53],init[54],init[55],init[67],init[79],res[66]);
    NextState N54(init[78],init[90],init[89],init[77],init[65],init[66],init[67],init[79],init[91],res[78]);
    NextState N55(init[90],1'b0,1'b0,init[89],init[77],init[78],init[79],init[91],1'b0,res[90]);

    NextState N56(init[7],init[19],init[18],init[6],1'b0,1'b0,1'b0,init[8],init[20],res[7]);
    NextState N57(init[19],init[31],init[30],init[18],init[6],init[7],init[8],init[20],init[32],res[19]);
    NextState N58(init[31],init[43],init[42],init[30],init[18],init[19],init[20],init[32],init[44],res[31]);
    NextState N59(init[43],init[55],init[54],init[42],init[30],init[31],init[32],init[44],init[56],res[43]);
    NextState N60(init[55],init[67],init[66],init[54],init[42],init[43],init[44],init[56],init[68],res[55]);
    NextState N61(init[67],init[79],init[78],init[66],init[54],init[55],init[56],init[68],init[80],res[67]);
    NextState N62(init[79],init[91],init[90],init[78],init[66],init[67],init[68],init[80],init[92],res[79]);
    NextState N63(init[91],1'b0,1'b0,init[90],init[78],init[79],init[80],init[92],1'b0,res[91]);

    NextState N64(init[8],init[20],init[19],init[7],1'b0,1'b0,1'b0,init[9],init[21],res[8]);
    NextState N65(init[20],init[32],init[31],init[19],init[7],init[8],init[9],init[21],init[33],res[20]);
    NextState N66(init[32],init[44],init[43],init[31],init[19],init[20],init[21],init[33],init[45],res[32]);
    NextState N67(init[44],init[56],init[55],init[43],init[31],init[32],init[33],init[45],init[57],res[44]);
    NextState N68(init[56],init[68],init[67],init[55],init[43],init[44],init[45],init[57],init[69],res[56]);
    NextState N69(init[68],init[80],init[79],init[67],init[55],init[56],init[57],init[69],init[81],res[68]);
    NextState N70(init[80],init[92],init[91],init[79],init[67],init[68],init[69],init[81],init[93],res[80]);
    NextState N71(init[92],1'b0,1'b0,init[91],init[79],init[80],init[81],init[93],1'b0,res[92]);

    NextState N72(init[9],init[21],init[20],init[8],1'b0,1'b0,1'b0,init[10],init[22],res[9]);
    NextState N73(init[21],init[33],init[32],init[20],init[8],init[9],init[10],init[22],init[34],res[21]);
    NextState N74(init[33],init[45],init[44],init[32],init[20],init[21],init[22],init[34],init[46],res[33]);
    NextState N75(init[45],init[57],init[56],init[44],init[32],init[33],init[34],init[46],init[58],res[45]);
    NextState N76(init[57],init[69],init[68],init[56],init[44],init[45],init[46],init[58],init[70],res[57]);
    NextState N77(init[69],init[81],init[80],init[68],init[56],init[57],init[58],init[70],init[82],res[69]);
    NextState N78(init[81],init[93],init[92],init[80],init[68],init[69],init[70],init[82],init[94],res[81]);
    NextState N79(init[93],1'b0,1'b0,init[92],init[80],init[81],init[82],init[94],1'b0,res[93]);

    NextState N80(init[10],init[22],init[21],init[9],1'b0,1'b0,1'b0,init[11],init[23],res[10]);
    NextState N81(init[22],init[34],init[33],init[21],init[9],init[10],init[11],init[23],init[35],res[22]);
    NextState N82(init[34],init[46],init[45],init[33],init[21],init[22],init[23],init[35],init[47],res[34]);
    NextState N83(init[46],init[58],init[57],init[45],init[33],init[34],init[35],init[47],init[59],res[46]);
    NextState N84(init[58],init[70],init[69],init[57],init[45],init[46],init[47],init[59],init[71],res[58]);
    NextState N85(init[70],init[82],init[81],init[69],init[57],init[58],init[59],init[71],init[83],res[70]);
    NextState N86(init[82],init[94],init[93],init[81],init[69],init[70],init[71],init[83],init[95],res[82]);
    NextState N87(init[94],1'b0,1'b0,init[93],init[81],init[82],init[83],init[95],1'b0,res[94]);

    NextState N88(init[11],init[23],init[22],init[10],1'b0,1'b0,1'b0,1'b0,1'b0,res[11]);
    NextState N89(init[23],init[35],init[34],init[22],init[10],init[11],1'b0,1'b0,1'b0,res[23]);
    NextState N90(init[35],init[47],init[46],init[34],init[22],init[23],1'b0,1'b0,1'b0,res[35]);
    NextState N91(init[47],init[59],init[58],init[46],init[34],init[35],1'b0,1'b0,1'b0,res[47]);
    NextState N92(init[59],init[71],init[70],init[58],init[46],init[47],1'b0,1'b0,1'b0,res[59]);
    NextState N93(init[71],init[83],init[82],init[70],init[58],init[59],1'b0,1'b0,1'b0,res[71]);
    NextState N94(init[83],init[95],init[94],init[82],init[70],init[71],1'b0,1'b0,1'b0,res[83]);
    NextState N95(init[95],1'b0,1'b0,init[94],init[82],init[83],1'b0,1'b0,1'b0,res[95]);
endmodule
