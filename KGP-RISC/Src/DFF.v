`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:14 11/09/2021 
// Design Name: 
// Module Name:    DFF 
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
module DFF(
	 input in,
	 input clk,
	 input rst,
	 output reg out
    );
	 
	 always @(posedge clk or posedge rst) begin
	     if(rst)
		      out <= 1'b0;
		  else 
				out <= in;
	 end
endmodule
