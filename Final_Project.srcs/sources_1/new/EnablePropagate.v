`timescale 1ns / 1ps

module EnableX(
    input [11:0] x,
    input dx,
    output [11:0] r
    );
    assign r[0] = x[0] | x[1] & dx;
    assign r[1] = x[0] & ~dx | x[1] | x[2] & dx;
    assign r[2] = x[1] & ~dx | x[2] | x[3] & dx;
    assign r[3] = x[2] & ~dx | x[3] | x[4] & dx;
    assign r[4] = x[3] & ~dx | x[4] | x[5] & dx;
    assign r[5] = x[4] & ~dx | x[5] | x[6] & dx;
    assign r[6] = x[5] & ~dx | x[6] | x[7] & dx;
    assign r[7] = x[6] & ~dx | x[7] | x[8] & dx;
    assign r[8] = x[7] & ~dx | x[8] | x[9] & dx;
    assign r[9] = x[8] & ~dx | x[9] | x[10] & dx;
    assign r[10] = x[9] & ~dx | x[10] | x[11] & dx;
    assign r[11] = x[10] & ~dx | x[11];
endmodule

module EnableY(
    input [7:0] y,
    input dy,
    output [7:0] r
    );
    assign r[0] = y[0] | y[1] & dy;
    assign r[1] = y[0] & ~dy | y[1] | y[2] & dy;
    assign r[2] = y[1] & ~dy | y[2] | y[3] & dy;
    assign r[3] = y[2] & ~dy | y[3] | y[4] & dy;
    assign r[4] = y[3] & ~dy | y[4] | y[5] & dy;
    assign r[5] = y[4] & ~dy | y[5] | y[6] & dy;
    assign r[6] = y[5] & ~dy | y[6] | y[7] & dy;
    assign r[7] = y[6] & ~dy | y[7];
endmodule
