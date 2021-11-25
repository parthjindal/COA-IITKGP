`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:23:17 11/05/2021
// Design Name:   RegisterFile
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/RegisterFile_tb.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RegisterFile_tb;

	// Inputs
	reg regWrite;
	reg [4:0] readAddr1;
	reg [4:0] readAddr2;
	reg [4:0] writeAddr;
	reg [31:0] writeData;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.regWrite(regWrite), 
		.readAddr1(readAddr1), 
		.readAddr2(readAddr2), 
		.writeAddr(writeAddr), 
		.writeData(writeData), 
		.readData1(readData1), 
		.readData2(readData2)
	);

	initial begin
		// Initialize Inputs
		regWrite = 0;
		readAddr1 = 0;
		readAddr2 = 0;
		writeAddr = 0;
		writeData = 0;

		// Wait 100 ns for global reset to finish
		#100;
      $monitor($time, "Addr1 = %d, readData1 = %d, Addr2 = %d, readData2 = %d", readAddr1, readAddr2, readData1, readData2);  
		#10; regWrite = 1; writeAddr = 5'd1; writeData = 32'd11;
		#10; regWrite = 1; writeAddr = 5'd2; writeData = 32'd12;
		#10; regWrite = 0; readAddr1 = 5'd1; readAddr2 = 5'd2;
		// Add stimulus here

	end

      
endmodule

