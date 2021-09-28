`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_LFSR 
// Description: Linear Feedback Shift Register Test Bench 
////////////////////////////////////////////////////////////////////////////////

module Test_LFSR;

	// Inputs
	reg [3:0] seed;
	reg clk;
	reg rst;
	reg sel;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	LFSR uut (
		.seed(seed), 
		.clk(clk), 
		.rst(rst), 
		.sel(sel), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		seed = 0;
		clk =  1;
		rst =  0;
		sel =  0;

		// Add stimulus here
		rst =  1;				// reset the LFSR
		#4; 					
		rst =  0;							
		$monitor($time," out = %b",out);		
		#4 seed = 4'b1111; sel = 1;		// seed = 1111, sel = 1
		#4 sel = 0;						// sel = 0
		#56;							// wait for 16 clock cycles
		$finish;
	end
   always
	#2 clk = ~clk;						// toggle clock
endmodule

