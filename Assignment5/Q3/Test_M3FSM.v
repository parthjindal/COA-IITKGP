`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_M3FSM
// Description: Multiple of 3's FSM's Test Bench 
////////////////////////////////////////////////////////////////////////////////

module Test_M3FSM;

	// Inputs
	reg inp;
	reg clk;
	reg rst;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	M3FSM uut (
		.out(out), 
		.inp(inp), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		inp = 0;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#1 rst = 0;
		#1 $display("Input = 0, Accepted: %b\n",out);
		#1 inp = 1;
		#2 $display("Input = 1, Accepted: %b\n",out);
		#2 inp = 1;
		#2 $display("Input = 3, Accepted: %b\n",out);
		#2 inp = 1;
		#2 $display("Input = 7, Accepted: %b\n",out);
		#2 inp = 0;
		#2 $display("Input = 14, Accepted: %b\n",out);
		#2 inp = 0;
		#2 $display("Input = 28, Accepted: %b\n",out);
		#2 inp = 1;
		#2 $display("Input = 57, Accepted: %b\n",out);
		        
		$finish;
	end
	always
	#2 clk = ~clk;
      
endmodule

