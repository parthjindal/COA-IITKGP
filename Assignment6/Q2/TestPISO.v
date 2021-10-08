`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:05:45 10/08/2021
// Design Name:   PISO
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment6/TestPISO.v
// Project Name:  Assignment6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PISO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestPISO;

	// Inputs
	reg [7:0] a;
	reg clk;
	reg rst;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	PISO uut (
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
      a = 8'b11110000; rst = 1;
		#3 rst = 0;
		#1;
		for (i = 0; i < 8; i = i + 1) begin
			$display($time,"out = %b",out); 
			#4;
		end
		$finish;
		// Add stimulus here

	end
   always 
	#2 clk = ~clk;
endmodule

