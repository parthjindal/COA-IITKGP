`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Module Name: TestRCA8
// Assignment: Lab-1
// Problem: Testing the Ripple Carry Adder (8-bit)
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
////////////////////////////////////////////////////////////////////////////////

module TestRCA8;

	// Inputs
	reg cIn;
	reg [7:0] a;
	reg [7:0] b;

	// Outputs
	wire [7:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	RCA8 uut (
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
		$monitor($time,"\ta=%d,\tb=%d,\tcIn=%b,\ts=%d,\tcOut=%b",a,b,cIn,s,cOut);
		#1 a = 10; b =  20; cIn = 0;
		#1 a = 10; b = 245; cIn = 0;
		#1 a = 10; b = 245; cIn = 1;
	end
      
endmodule

