`timescale 1ns / 1ps

module sim_tb();
    reg[3:0] in;
    wire [6:0] out;

    BCD_7SEG_CONV conv(in,out);
    integer i;
    initial begin
        for (i = 0; i<10; i=i+1) begin
            in=i;
            #1;
        end
        $finish;
    end
endmodule
