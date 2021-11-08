`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:10:53 11/08/2021
// Design Name:   BranchControl
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/BranchControl_tb.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BranchControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BranchControl_tb;

	// Inputs
	reg [5:0] opcode;
	reg fZero;
	reg fSign;
	reg fCarry;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	BranchControl uut (
		.opcode(opcode), 
		.fZero(fZero), 
		.fSign(fSign), 
		.fCarry(fCarry), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		fZero = 0;
		fSign = 0;
		fCarry = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$monitor("opcode = %b, fZero = %b, fSign = %b, fCarry = %b, out = %b", opcode,fZero,fSign,fCarry,out);
		opcode = 6'b101000; #10; // op:b
		opcode = 6'b100000; #10; // op:br
		opcode = 6'b110000; fSign = 1; #10; //op:bltz rs < 0
		opcode = 6'b110000; fSign = 0; #10; //op:bltz !rs < 0
		opcode = 6'b110001; fZero = 1; #10; //op:bz rs == 0
		opcode = 6'b110001; fZero = 0; #10; //op:bz rs != 0
		opcode = 6'b110010; fZero = 0; #10; //op:bnz rs != 0
		opcode = 6'b110010; fZero = 1; #10; //op:bnz rs == 0
		opcode = 6'b101011; #10;  //op:bl
		opcode = 6'b101001; fCarry = 1; #10; //op:bcy carry = 1
		opcode = 6'b101010; fCarry = 0; #10; //op:bncy carry = 0
		opcode = 6'b000000; #10;


        
		// Add stimulus here

	end
      
endmodule

