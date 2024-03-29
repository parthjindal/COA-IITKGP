`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Module Name: TestCLA 
// Assignment: Lab-1
// Problem: Testing the Carry Look-ahead adder (4-bit)
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
////////////////////////////////////////////////////////////////////////////////

module TestCLA;

	// Inputs
	reg cIn;
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [3:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	CLA uut (
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
      $monitor($time,"\ta=%d,\tb=%d,\tcIn=%b,\ts=%d,\tcOut=%b",a,b,cIn,s,cOut);
		#1 a = 5; b =  7; cIn = 0;
		#1 a = 5; b = 10; cIn = 0;
		#1 a = 5; b = 10; cIn = 1;
		// Add stimulus here

	end
      
endmodule

