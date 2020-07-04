`timescale 1ns / 1ps

module RAM(
    input[95:0] DATA,
    input CLK,
    input ONEDAT,
    input ONEDAT_EN,
    input[3:0] ADDRX,
    input[2:0] ADDRY,
    output[95:0] OUT,
    input ONEDAT_CHANGE
    );
    wire [7:0]temp;
    Decoder_3_8 decoder(ADDRY,temp);
    RAM_WORD WORD01(DATA[11:0] ,CLK,ONEDAT,ONEDAT_EN,temp[0],OUT[11:0],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD02(DATA[23:12],CLK,ONEDAT,ONEDAT_EN,temp[1],OUT[23:12],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD03(DATA[35:24],CLK,ONEDAT,ONEDAT_EN,temp[2],OUT[35:24],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD04(DATA[47:36],CLK,ONEDAT,ONEDAT_EN,temp[3],OUT[47:36],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD05(DATA[59:48],CLK,ONEDAT,ONEDAT_EN,temp[4],OUT[59:48],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD06(DATA[71:60],CLK,ONEDAT,ONEDAT_EN,temp[5],OUT[71:60],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD07(DATA[83:72],CLK,ONEDAT,ONEDAT_EN,temp[6],OUT[83:72],ADDRX,ONEDAT_CHANGE);
    RAM_WORD WORD08(DATA[95:84],CLK,ONEDAT,ONEDAT_EN,temp[7],OUT[95:84],ADDRX,ONEDAT_CHANGE);
endmodule

module RAM_WORD(
    input [11:0]DAT,
    input CLK,
    input ONEDAT,
    input ONEDAT_EN,
    input ONEDAT_XEN,
    output [11:0]OUT,
    input [3:0]ADDRX,
    input ONEDAT_CHANGE
    );
    wire [15:0]temp;
    Decoder_4_16 decoder(ADDRX,temp);
    RAMcell R01(DAT[0],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[0],OUT[0],ONEDAT_CHANGE);
    RAMcell R02(DAT[1],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[1],OUT[1],ONEDAT_CHANGE);
    RAMcell R03(DAT[2],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[2],OUT[2],ONEDAT_CHANGE);
    RAMcell R04(DAT[3],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[3],OUT[3],ONEDAT_CHANGE);
    RAMcell R05(DAT[4],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[4],OUT[4],ONEDAT_CHANGE);
    RAMcell R06(DAT[5],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[5],OUT[5],ONEDAT_CHANGE);
    RAMcell R07(DAT[6],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[6],OUT[6],ONEDAT_CHANGE);
    RAMcell R08(DAT[7],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[7],OUT[7],ONEDAT_CHANGE);
    RAMcell R09(DAT[8],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[8],OUT[8],ONEDAT_CHANGE);
    RAMcell R10(DAT[9],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[9],OUT[9],ONEDAT_CHANGE);
    RAMcell R11(DAT[10],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[10],OUT[10],ONEDAT_CHANGE);
    RAMcell R12(DAT[11],CLK,ONEDAT,ONEDAT_EN,ONEDAT_XEN,temp[11],OUT[11],ONEDAT_CHANGE);
endmodule // RAM_WORD

module RAMcell (
    input dat, clk, onedat, onedat_en,onedat_xen,onedat_yen,
    output out,
    input ONEDAT_CHANGE
    );
    assign CLK = ~onedat_en & clk | onedat_en & onedat_xen & onedat_yen & clk & ONEDAT_CHANGE;
    Bitwith_1_2x1_MUX mux(dat,onedat,onedat_en & onedat_xen & onedat_yen,d);
    DFF D(d,CLK,out);
endmodule

module DFF(
    input D,
    input CLK,
    output reg Q
    );
    initial begin
        Q <= 0;
    end

    always @(posedge CLK) begin
            Q <= D;
    end
endmodule
