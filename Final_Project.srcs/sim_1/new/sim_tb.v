`timescale 1ns / 1ps

module sim_tb();
    reg clk;
    wire [7:0] seg;
    wire [3:0]an,out1,out2,out3,out4;
    Score C(clk,1'b0, seg,an,out1,out2,out3,out4);

    integer c;
    initial begin
        clk = 0;
       for (c = 0; c<32000; c=c+1) begin
            clk = ~clk;
            #10;
        end
        $finish;
    end
endmodule
