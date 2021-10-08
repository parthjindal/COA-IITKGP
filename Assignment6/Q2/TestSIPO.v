`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:17:18 10/08/2021
// Design Name:   SIPO
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment6/TestSIPO.v
// Project Name:  Assignment6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SIPO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestSIPO;

	// Inputs
	reg a;
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	SIPO uut (
		.a(a), 
		.clk(clk), 
		.rst(rst), 
		.out(out)
	);
	integer i;
	initial begin
		// Initialize Inputs
		a = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		rst = 1;
		#4 rst = 0;
		for(i = 0; i < 8; i = i + 1) begin
			a = i % 2;
			#4 $display($time,"Out = %8'b",out);
		end
		// Add stimulus here

	end
	always
	#2 clk = ~clk;
      
endmodule

