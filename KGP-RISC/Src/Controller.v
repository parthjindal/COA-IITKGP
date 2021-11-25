`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:37 11/06/2021 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input  [5:0] opcode,
	 output memRead,
	 output memWrite,
	 output regWrite,
	 output [1:0] regDst,
	 output [1:0] mem2Reg,
	 output aluSrc,
	 output lblSel,
	 output jmpSel
    );
	 
	 
	 assign jmpSel = ~opcode[4] & ~opcode[3];
	 assign lblSel = opcode[5] & opcode[4];
	 assign mem2Reg = opcode[5:4];
	 assign memWrite = (opcode == 6'b011000);
	 assign memRead = (opcode == 6'b010000);
	 assign aluSrc = opcode[4] | opcode[3];
	 
	 assign regWrite = (~opcode[5] & ~opcode[4]) |
							 (~opcode[5] & ~opcode[3]) |
							 ( opcode[1] &  opcode[0]);
							 
	 assign regDst[0] = opcode[4];
	 assign regDst[1] = opcode[5];
	 

endmodule
