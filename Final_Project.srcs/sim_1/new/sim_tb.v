`timescale 1ns / 1ps

module sim_tb();
    reg [3:0]in;
    wire [7:0] seg;
    BCD_7SEG_CONV C(in, seg);

    integer c;
    initial begin
       for (c = 0; c<16; c=c+1) begin
            in = c;
            #1;
        end
        $finish;
    end
endmodule
