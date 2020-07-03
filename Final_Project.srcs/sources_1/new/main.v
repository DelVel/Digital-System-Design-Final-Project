`timescale 1ns / 1ps

module main(
    // clock input
    input clk,
    //button input
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    //led segment output
    output [7:0] seg,
    output [3:0] an,
    //display output
    output [23:0] row,
    output [3:0] col
    );
    reg [95:0] viewData;

    reg [11:0] ballX;
    reg [7:0] ballY;
    reg baldDx;
    reg ballDy;
    reg [3:0] state;
    reg reset,inc;
    wire [95:0] nextState;
    wire [11:0] barRes;
    wire [11:0] enableX;
    wire [7:0] enableY;

    EnableX ex(ballX,ballDx,enableX);
    EnableY ey(bally,ballDy,enableY);

    Graphic graphic(clk,viewData,row,col);
    Score score(clk,inc,reset,seg,an);
    BarCounter barCounter(viewData[11:0],{btnL, btnR}, barRes);

endmodule // main

module main2 (
    // clock input
    input clk,
    //button input
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    //led segment output
    output [7:0] seg,
    output [3:0] an,
    //display output
    output [23:0] row,
    output [3:0] col
    );
    reg [95:0] viewData;

    reg [11:0] ballX;
    reg [7:0] ballY;
    reg baldDx;
    reg ballDy;
    reg [3:0] state;
    reg reset,inc;
    reg [11:0] barNow;
    wire [95:0] nextState;
    wire [11:0] barRes;
    wire [11:0] enableX;
    wire [7:0] enableY;

    EnableX ex(ballX,ballDx,enableX);
    EnableY ey(bally,ballDy,enableY);

    Graphic graphic(clk,viewData,row,col);
    Score score(clk,inc,reset,seg,an);
    BarCounter barCounter(barNow,{btnL, btnR}, barRes);

    initial begin

    end
endmodule
