`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:22:56 08/26/2021
// Design Name:   HalfAdder
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment1/Q1/HA/TestHA.v
// Project Name:  HA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HalfAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestHA;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire s;
	wire c;

	// Instantiate the Unit Under Test (UUT)
	HalfAdder uut (
		.s(s), 
		.c(c), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor($time,"a = %b, b = %b, s = %b, c = %b",a, b, s, c);
		
		#1 a = 1; b = 1;
		#1 a = 0; b = 1;
		#1 a = 1; b = 0;
	end
      
endmodule

