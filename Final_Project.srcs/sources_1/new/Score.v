`timescale 1ns / 1ps

module FA(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );
    assign S = A ^ B ^ Cin;
    assign Cout = ((A ^ B) & Cin) | (A & B);
endmodule

module Score(
    input S
    );
    wire[3:0] sum;
    assign sum[0] = ~S;
    assign sum[1] = S;
    assign sum[2] = 0;
    assign sum[2] = S;
    
    wire[23:0] memo;
    RAM Rram(0, 0, 1, 4'b1111, memo);
    
    wire[23:0] score, cout;
    FA fa0(memo[0], sum[0], 0, score[0], cout[0]);  
    FA fa1(memo[1], sum[1], cout[0], score[1], cout[1]);  
    FA fa2(memo[2], sum[2], cout[1], score[2], cout[2]);  
    FA fa3(memo[3], sum[3], cout[2], score[3], cout[3]);  
    FA fa4(memo[4], 0, cout[3], score[4], cout[4]);  
    FA fa5(memo[5], 0, cout[4], score[5], cout[5]);  
    FA fa6(memo[6], 0, cout[5], score[6], cout[6]);  
    FA fa7(memo[7], 0, cout[6], score[7], cout[7]);  
    FA fa8(memo[8], 0, cout[7], score[8], cout[8]);  
    FA fa9(memo[9], 0, cout[8], score[9], cout[9]);  
    FA fa10(memo[10], 0, cout[9], score[10], cout[10]);  
    FA fa11(memo[11], 0, cout[10], score[11], cout[11]);  
    FA fa12(memo[12], 0, cout[11], score[12], cout[12]);  
    FA fa13(memo[13], 0, cout[12], score[13], cout[13]);  
    FA fa14(memo[14], 0, cout[13], score[14], cout[14]);  
    FA fa15(memo[15], 0, cout[14], score[15], cout[15]);  
    FA fa16(memo[16], 0, cout[15], score[16], cout[16]);  
    FA fa17(memo[17], 0, cout[16], score[17], cout[17]);  
    FA fa18(memo[18], 0, cout[17], score[18], cout[18]);  
    FA fa19(memo[19], 0, cout[18], score[19], cout[19]);  
    FA fa20(memo[20], 0, cout[19], score[20], cout[20]);  
    FA fa21(memo[21], 0, cout[20], score[21], cout[21]);  
    FA fa22(memo[22], 0, cout[21], score[22], cout[22]);  
    FA fa23(memo[23], 0, cout[22], score[23], cout[23]); 
    
    wire[23:0] temp;
    RAM Wram(score, 1, 1, 4'b1111, temp); 
endmodule
