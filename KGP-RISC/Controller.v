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
	 output reg memRead,
	 output reg memWrite,
	 output reg regWrite,
	 output reg [1:0] regDst,
	 output reg [1:0] mem2Reg,
	 output reg aluSrc,
	 output reg lblSel,
	 output reg jmpSel
    );
	 
	 always @(*) begin
		 if (opcode == 6'b000000) begin //rFormat
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 1;
			  regDst = 2'b00;
			  mem2Reg = 2'b11;
			  aluSrc = 0;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else if (opcode == 6'b001000 || opcode == 6'b001001) begin // addi/cmpi
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 1;
			  regDst = 2'b00;
			  mem2Reg = 2'b11;
			  aluSrc = 1;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else if (opcode == 6'b01000) begin  //lw
			  memRead = 1;
			  memWrite = 0;
			  regWrite = 1;
			  regDst = 2'b00;
			  mem2Reg = 2'b01;
			  aluSrc = 1;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else if (opcode == 6'b011000) begin //sw
			  memRead = 0;
			  memWrite = 1;
			  regWrite = 0;
			  regDst = 2'b01;
			  mem2Reg = 2'b00;
			  aluSrc = 1;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else if (opcode == 6'b101000 || opcode == 6'b101001 || opcode == 6'b101010) begin //b, bcy, bncy
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 0;
			  regDst = 2'b00;
			  mem2Reg = 2'b11 ;
			  aluSrc = 0;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else if (opcode[5:3] == 3'b110) begin //bltz, bz, bnz
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 0;
			  regDst = 2'b00;
			  mem2Reg = 2'b11;
			  aluSrc = 0;
			  lblSel = 1;
			  jmpSel = 0;
		 end
		 else if (opcode == 6'b100000) begin // br
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 0;
			  regDst = 2'b00;
			  mem2Reg = 2'b11;
			  aluSrc = 0;
			  lblSel = 0;
			  jmpSel = 1;
		 end
		 else if (opcode == 6'b101011) begin // bl
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 1;
			  regDst = 2'b11;
			  mem2Reg = 2'b00 ;
			  aluSrc = 0;
			  lblSel = 0;
			  jmpSel = 0;
		 end
		 else begin
			  memRead = 0;
			  memWrite = 0;
			  regWrite = 0;
			  regDst = 2'b00;
			  mem2Reg = 2'b00 ;
			  aluSrc = 0;
			  lblSel = 0;
			  jmpSel = 0;   
		 end
	 end


endmodule
