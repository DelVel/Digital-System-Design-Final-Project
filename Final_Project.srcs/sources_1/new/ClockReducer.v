`timescale 1ns / 1ps

module ClockReducer_1_2(
    input clk,
    output res
    );
    DFF D1(~res, ~clk, res);
endmodule // ClockReducer_1_2

module ClockReducer_1_100(
    input clk,
    output reg res
    );
    reg [7:0]a;
    initial begin
        res = 0;
        a = 0;
    end
    always @(posedge clk) begin
        a <= a + 1;
        if(a % 100 == 0) begin
            res <= ~res;
        end
        if(a == 200) begin a <= 0; end
    end
endmodule //ClockReducer_1_100

module ClockReducer_1_4(
    input clk,
    output res
    );
    ClockReducer_1_2 D1(clk, C1);
    ClockReducer_1_2 D2(C1, res);
endmodule // ClockReducer_1_4

module ClockReducer_1_16(
    input clk,
    output res
    );
    ClockReducer_1_4 D1(clk, C1);
    ClockReducer_1_4 D2(C1, res);
endmodule // ClockReducer_1_16

module ClockReducer_1_256(
    input clk,
    output res
    );
    ClockReducer_1_16 D1(clk, C1);
    ClockReducer_1_16 D2(C1, res);
endmodule // ClockReducer_1_256

module ClockReducer_1_65536(
    input clk,
    output res
    );
    ClockReducer_1_256 D1(clk, C1);
    ClockReducer_1_256 D2(C1, res);
endmodule // ClockReducer_1_65536
