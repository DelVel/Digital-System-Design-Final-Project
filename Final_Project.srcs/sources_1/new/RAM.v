`timescale 1ns / 1ps

module RAM(
    input[23:0] DATA,
    input CLK,
    input WR,
    input[3:0] ADDR,
    output[23:0] OUT
    );
    wire [15:0]temp;
    Decoder decoder(ADDR, temp);
    RAM_WORD WORD1(DATA,CLK,WR,temp[0],OUT);
    RAM_WORD WORD2(DATA,CLK,WR,temp[1],OUT);
    RAM_WORD WORD3(DATA,CLK,WR,temp[2],OUT);
    RAM_WORD WORD4(DATA,CLK,WR,temp[3],OUT);
    RAM_WORD WORD5(DATA,CLK,WR,temp[4],OUT);
    RAM_WORD WORD6(DATA,CLK,WR,temp[5],OUT);
    RAM_WORD WORD7(DATA,CLK,WR,temp[6],OUT);
    RAM_WORD WORD8(DATA,CLK,WR,temp[7],OUT);
    RAM_WORD WORD9(DATA,CLK,WR,temp[8],OUT);
    RAM_WORD WORD10(DATA,CLK,WR,temp[9],OUT);
    RAM_WORD WORD11(DATA,CLK,WR,temp[10],OUT);
    RAM_WORD WORD12(DATA,CLK,WR,temp[11],OUT);
    RAM_WORD WORD13(DATA,CLK,WR,temp[12],OUT);
    RAM_WORD WORD14(DATA,CLK,WR,temp[13],OUT);
    RAM_WORD WORD15(DATA,CLK,WR,temp[14],OUT);
    RAM_WORD WORD16(DATA,CLK,WR,temp[15],OUT);
endmodule

module RAM_BIT(
    input [7:0]DAT,
    input CLK,
    input WR,
    input CS,
    output [7:0]OUT
    );
    RAMcell R1(DAT[0],CLK,WR,CS,OUT[0]);
    RAMcell R2(DAT[1],CLK,WR,CS,OUT[1]);
    RAMcell R3(DAT[2],CLK,WR,CS,OUT[2]);
    RAMcell R4(DAT[3],CLK,WR,CS,OUT[3]);
    RAMcell R5(DAT[4],CLK,WR,CS,OUT[4]);
    RAMcell R6(DAT[5],CLK,WR,CS,OUT[5]);
    RAMcell R7(DAT[6],CLK,WR,CS,OUT[6]);
    RAMcell R8(DAT[7],CLK,WR,CS,OUT[7]);
endmodule // RAM_BIT

module RAM_WORD(
    input [23:0]DAT,
    input CLK,
    input WR,
    input CS,
    output [23:0]OUT
    );
    RAM_BIT R1(DAT[23:16],CLK,WR,CS,OUT[23:16]);
    RAM_BIT R2(DAT[15:8],CLK,WR,CS,OUT[15:8]);
    RAM_BIT R3(DAT[7:0],CLK,WR,CS,OUT[7:0]);
endmodule //RAM_WORD 