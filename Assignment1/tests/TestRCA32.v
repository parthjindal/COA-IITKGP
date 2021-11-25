`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Module Name: TestRCA32
// Assignment: Lab-1
// Problem: Testing the Ripple Carry Adder (32-bit)
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
////////////////////////////////////////////////////////////////////////////////

module TestRCA32;

	// Inputs
	reg cIn;
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	RCA32 uut (
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
		#1 a =         32; b = 64; cIn = 0;
		#1 a =         32; b = 64; cIn = 1;
		#1 a = 4294967291; b =  4; cIn = 0;
		#1 a = 4294967291; b =  4; cIn = 1;
	end
      
endmodule

