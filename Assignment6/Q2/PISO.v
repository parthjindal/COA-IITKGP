`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:14 10/08/2021 
// Design Name: 
// Module Name:    PISO 
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
module PISO(
	input [7:0] a,
	input clk,
	input rst,
	output wire out
    );
	reg [7:0] cpy;
	assign out = cpy[0];
	always @(posedge clk) begin
		if(rst)
			cpy <= a;
		else
			cpy <= {1'b0,cpy[7:1]};
	end

endmodule
