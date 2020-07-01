`timescale 1ns / 1ps

module sim_tb();
    reg [7:0]a,b;
    Comparator_WORD C(a,b,1'b1, res1,res2,res3);

    integer c,d;
    initial begin
       for (c = 0; c<256; c=c+1) begin
            for (d = 0; d<256; d=d+1) begin
                a=c;
                b=d;
                #100;
            end
        end
        $finish;
    end
endmodule
