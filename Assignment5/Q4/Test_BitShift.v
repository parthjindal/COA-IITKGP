`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_BitShift
// Description: This module is used to test the BitShift module
////////////////////////////////////////////////////////////////////////////////

module Test_BitShift;

	// Inputs
	reg [31:0] inp;
	reg clk;
	reg load;
	reg rst;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	BitShift uut (
		.out(out), 
		.inp(inp), 
		.clk(clk), 
		.load(load), 
		.rst(rst)
	);

	integer i;
	initial begin
		// Initialize Inputs
		inp = 32'd1;
		clk = 0;
		load = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#1 load = 1;
		#2 load = 0;
		#1;
		for (i = 31; i >= 0; i = i - 1) begin
			$display($time,"%dth bit: %b",i,out);
			#4;
		end
		// Add stimulus here
		$finish;
	end
	always
	#2 clk = ~clk;
      
endmodule

