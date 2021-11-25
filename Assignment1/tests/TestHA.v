`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Module Name: TestHA
// Assignment: Lab-1
// Problem: 1-(a)
// Group: 24
// Group Members: Parth Jindal, Pranav Rajput
// Description: Verilog test bench for the Half Adder module
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

