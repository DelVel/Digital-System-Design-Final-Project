`timescale 1ns / 1ps

module sim_tb();
    reg b;
    ClockReducer_1_100 a(b,c);
    initial begin b=0; end
    always begin
        #10;
        b <= ~b;
    end
endmodule
