`timescale 1ns / 1ps

module sim_tb();
    reg clk,inc, res;
    wire [7:0] seg;
    wire [3:0]an;
    Score C(clk,inc,res, seg,an);
    integer c;
    initial begin
        res <= 1;
        #1;
        res <= 0;
        inc <= 1;
        clk <= 0;
    end
    always begin
        #10;
        clk <= ~clk;
    end
    always begin
        #15;
        inc <= ~inc;
    end
endmodule
