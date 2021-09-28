`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_Comparator
// Description: This module is used to test the comparator module
////////////////////////////////////////////////////////////////////////////////

module Test_Comparator;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire L;
	wire E;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	Comparator uut (
		.L(L), 
		.E(E), 
		.G(G), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		
		#2 $display("a = %b, b = %b, L = %b, E = %b, G = %b", a, b, L, E, G);
		a = 1; b = 0;
		#2 $display("a = %b, b = %b, L = %b, E = %b, G = %b", a, b, L, E, G);
		a = 0; b = 1;
		#2 $display("a = %b, b = %b, L = %b, E = %b, G = %b", a, b, L, E, G);
		a = 1; b = 1;
		#2 $display("a = %b, b = %b, L = %b, E = %b, G = %b", a, b, L, E, G);
		// Wait 100 ns for global reset to finish
		$finish;
       
		// Add stimulus here

	end
      
endmodule

