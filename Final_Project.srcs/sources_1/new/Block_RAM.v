`timescale 1ns / 1ps

module Block_RAM(
    input[23:0] DATA,
    input WR,
    input CS,
    input[3:0] S,
    output[23:0] OUT
    );
    reg[15:0] temp;
    Decoder decoder(CS, S[0:3], temp[0:15]);
endmodule
