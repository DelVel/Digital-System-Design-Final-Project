`timescale 1ns / 1ps

module BCD_Counter(
    input clk,
    input reset,
    output [3:0]out
    );
    DFF D1(~out[0]          , ~clk   , reset, out[0]);
    DFF D2(~out[1] & ~out[3], ~out[0], reset, out[1]);
    DFF D3(~out[2]          , ~out[1], reset, out[2]);
    DFF D4(out[2] & out[1]  , ~out[0], reset, out[3]);
endmodule // BCD_Counter

module Score(
    input clk, increment, reset,
    output [7:0]seg,
    output reg [3:0]an
    );
    wire [3:0] out1,out2,out3,out4;
    integer flicker_counter;
    wire [3:0] toConv;
    reg [1:0] sel;

    BCD_Counter first   (increment, reset,  out1);
    BCD_Counter second  (out1[3],   reset,  out2);
    BCD_Counter third   (out2[3],   reset,  out3);
    BCD_Counter fourth  (out3[3],   reset,  out4);

    Bitwith_4_4x1_MUX mux(out1,out2,out3,out4,sel,toConv);
    BCD_7SEG_CONV converter(toConv, seg);

    initial begin
        an<=4'b1110;
        flicker_counter <= 0;
    end
    always @(posedge clk) begin
        if(flicker_counter % 1000 == 0) begin
            case(an)
                4'b1110 : begin sel<=2'b01; an<=4'b1101; end
                4'b1101 : begin sel<=2'b10; an<=4'b1011; end
                4'b1011 : begin sel<=2'b11; an<=4'b0111; end
                4'b0111 : begin sel<=2'b00; an<=4'b1110; end
            endcase
        end
    end
    always @(posedge clk) begin
        if(flicker_counter == 1048576) begin flicker_counter <= 1; end
        else begin flicker_counter <= flicker_counter + 1; end
    end

endmodule
