`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:25:57 09/28/2021
// Design Name:   DFF
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment5_2/Test_DFF.v
// Project Name:  Assignment5_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DFF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_DFF;

	// Inputs
	reg D;
	reg clk;
	reg rst;

	// Outputs
	wire Q;

	// Instantiate the Unit Under Test (UUT)
	DFF uut (
		.Q(Q), 
		.D(D), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		D = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
       
		$monitor($time,"Q = %b",Q);
		// Add stimulus here
		D = 1;
		#2 D = 0;
		#2 D = 1;
		#10 D = 1;
		#10 D = 0;
		#10 D = 0;
		#10 D = 1;
		#10;
	end
   always
	#10 clk = ~clk;
endmodule

