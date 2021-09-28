`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_Complement2
// Description: This module is used to test the Complement2 module
////////////////////////////////////////////////////////////////////////////////

module Test_Complement2;

	// Inputs
	reg in;
	reg clk;
	reg rst;
	reg [8:0] test_inp = 8'b10110000;       // 8-bit input Note: Input can be of arbitary length, This is just for testing
	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	Complement2 uut (
		.out(out), 
		.in(in), 
		.clk(clk), 
		.rst(rst)
	);
	integer i;
	initial begin
		// Initialize Inputs
		in = 0;
		clk = 0;
		rst = 0;
		
		
		$display("Input Stream(MSB->LSB): 10110000");
		// Wait 100 ns for global reset to finish
		#1 rst = 1 ;
		#1 rst = 0 ;
		#3;
		for (i = 0; i < 8; i=i+1) begin
			#4 in = test_inp[i];
			#2 $display("%dth Bit: %b",i,out);
		end
		// Add stimulus here
        $finish;
	end
   
	always 
		#4 clk = ~clk;
	
endmodule

