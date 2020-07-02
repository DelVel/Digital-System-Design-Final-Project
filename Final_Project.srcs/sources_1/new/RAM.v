`timescale 1ns / 1ps

module RAM(
    input[7:0] DATA,
    input CLK,
    input WR,
    input[3:0] ADDR,
    output[7:0] OUT
    );
    wire [15:0]temp;
    Decoder_4_16 decoder(ADDR,1'b1,temp);
    RAM_WORD WORD01(DATA,CLK,WR,temp[0],OUT);
    RAM_WORD WORD02(DATA,CLK,WR,temp[1],OUT);
    RAM_WORD WORD03(DATA,CLK,WR,temp[2],OUT);
    RAM_WORD WORD04(DATA,CLK,WR,temp[3],OUT);
    RAM_WORD WORD05(DATA,CLK,WR,temp[4],OUT);
    RAM_WORD WORD06(DATA,CLK,WR,temp[5],OUT);
    RAM_WORD WORD07(DATA,CLK,WR,temp[6],OUT);
    RAM_WORD WORD08(DATA,CLK,WR,temp[7],OUT);
    RAM_WORD WORD09(DATA,CLK,WR,temp[8],OUT);
    RAM_WORD WORD10(DATA,CLK,WR,temp[9],OUT);
    RAM_WORD WORD11(DATA,CLK,WR,temp[10],OUT);
    RAM_WORD WORD12(DATA,CLK,WR,temp[11],OUT);
    RAM_WORD WORD13(DATA,CLK,WR,temp[12],OUT);
    RAM_WORD WORD14(DATA,CLK,WR,temp[13],OUT);
    RAM_WORD WORD15(DATA,CLK,WR,temp[14],OUT);
    RAM_WORD WORD16(DATA,CLK,WR,temp[15],OUT);
endmodule

module RAM_WORD(
    input [7:0]DAT,
    input CLK,
    input WR,
    input CS,
    output [7:0]OUT
    );
    RAM_4 R01(DAT[3:0],CLK,WR,CS,OUT[3:0]);
    RAM_4 R02(DAT[7:4],CLK,WR,CS,OUT[7:4]);
endmodule // RAM_WORD

module RAM_4(
    input [3:0]DAT,
    input CLK,
    input WR,
    input CS,
    output [3:0]OUT
    );
    RAMcell R1(DAT[0],CLK,WR,CS,OUT[0]);
    RAMcell R2(DAT[1],CLK,WR,CS,OUT[1]);
    RAMcell R3(DAT[2],CLK,WR,CS,OUT[2]);
    RAMcell R4(DAT[3],CLK,WR,CS,OUT[3]);
endmodule // RAM_4
