`timescale 1ns / 1ps

module BCD_Counter(
    input clk, reset,
    output [3:0]out
    );
    DFF D1(~reset & ~out[0],~clk,out[0]);
    DFF D2(~reset & ~out[1] & ~out[3],~out[0],out[1]);
    DFF D3(~reset & ~out[2], ~out[1], out[2]);
    DFF D4(~reset & out[2] & out[1], ~out[0], out[3]);
endmodule // BCD_Counter

module Score(
    input clk, increment, reset,
    output [7:0]seg,
    output reg [3:0]an
    );
    wire [3:0] out1,out2,out3,out4;
    BCD_Counter first(increment | clk & reset,reset,out1);
    BCD_Counter second(clk & reset | out1[3],reset,out2);
    BCD_Counter third(clk & reset | out2[3],reset,out3);
    BCD_Counter fourth(clk & reset | out3[3],reset,out4);

    integer flicker_counter;
    reg [3:0] targetOut;
    BCD_7SEG_CONV converter(targetOut, seg);

    initial begin
        an<=4'b1110;
        flicker_counter <= 0;
    end
    always @(posedge clk) begin
        if(flicker_counter % 20 == 0) begin
            case(an)
                4'b1110 : begin targetOut<=out2; an<=4'b1101; end
                4'b1101 : begin targetOut<=out3; an<=4'b1011; end
                4'b1011 : begin targetOut<=out4; an<=4'b0111; end
                4'b0111 : begin targetOut<=out1; an<=4'b1110; end
            endcase
        end
    end
    always @(posedge clk) begin
        if(flicker_counter == 400000000) begin flicker_counter <= 1; end
        else begin flicker_counter <= flicker_counter + 1; end
    end

endmodule
