`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:34:44 08/26/2021
// Design Name:   FullAdder
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment1/Q1/HA/TestFA.v
// Project Name:  HA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FullAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestFA;

	// Inputs
	reg cIn;
	reg a;
	reg b;

	// Outputs
	wire s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	FullAdder uut (
		.s(s), 
		.cOut(cOut), 
		.cIn(cIn), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		cIn = 0;
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor($time,"\ta=%b,\tb=%b,\tcIn=%b,\ts=%b,\tcOut=%b",a,b,cIn,s,cOut);
		#1 a = 0; b = 1; cIn = 0;
		#1 a = 1; b = 1; cIn = 0;
		#1 a = 1; b = 1; cIn = 1;

	end
      
endmodule

