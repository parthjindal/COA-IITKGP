`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:36 11/05/2021 
// Design Name: 
// Module Name:    Shifter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Shifter(
	 input [4:0] shamt,
	 input [31:0] a,
	 input dir, // 0->logical, 1->arithmatic
	 input type,  // 0-> left, 1-> right
	 output [31:0] out
    );
	 
	 reg [31:0] inp1, inp2, inp4, inp8, inp16;
	 wire[31:0] mOut1, mOut2, mOut4, mOut8;
	  	 	 
	 always @(*) begin
        if (dir == 0) begin //left-shift
		      inp1 = {a[30:0], 1'b0};
				inp2 = {mOut1[29:0], 2'b0};
				inp4 = {mOut2[27:0], 4'b0};
				inp8 = {mOut4[23:0], 8'b0};
				inp16 = {mOut8[15:0], 16'b0};
		  end
		  else begin
		      inp1 = type ? {{1{a[31]}}, a[31:1]} : {1'b0, a[31:1]};
				inp2 = type ? {{2{mOut1[31]}}, mOut1[31:2]} : {2'b0, mOut1[31:2]};
				inp4 = type ? {{4{mOut2[31]}}, mOut2[31:4]} : {4'b0, mOut2[31:4]};
				inp8 = type ? {{8{mOut4[31]}}, mOut4[31:8]} : {8'b0, mOut4[31:8]};
				inp16 = type ? {{16{mOut8[31]}}, mOut8[31:16]} : {16'b0, mOut8[31:16]};
		  end
	 end
	 
	 MUX2_1 m1(a, inp1, shamt[0], mOut1);
	 MUX2_1 m2(mOut1, inp2, shamt[1], mOut2);
	 MUX2_1 m4(mOut2, inp4, shamt[2], mOut4);
	 MUX2_1 m8(mOut4, inp8, shamt[3], mOut8);
	 MUX2_1 m16(mOut8, inp16, shamt[4], out);
    
endmodule
