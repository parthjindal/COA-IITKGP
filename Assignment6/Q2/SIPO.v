`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:27 10/08/2021 
// Design Name: 
// Module Name:    SIPO 
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
module SIPO(
	input a,
	input clk,
	input rst,
	output wire [7:0] out
    );
	reg [7:0] cpy;
	assign out = cpy;
	
	always @(posedge clk) begin
		if(rst)
			cpy <= 8'd0;
		else 
			cpy <= {a,cpy[7:1]};
	end

endmodule
