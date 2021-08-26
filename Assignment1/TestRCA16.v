`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:49:16 08/26/2021
// Design Name:   RCA16
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment1/Q1/HA/TestRCA16.v
// Project Name:  HA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RCA16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestRCA16;

	// Inputs
	reg cIn;
	reg [15:0] a;
	reg [15:0] b;

	// Outputs
	wire [15:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	RCA16 uut (
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
		#1 a =    32; b = 64; cIn = 0;
		#1 a =    32; b = 64; cIn = 1;
		#1 a = 65531; b =  4; cIn = 0;
		#1 a = 65531; b =  4; cIn = 1;
        
		// Add stimulus here

	end
      
endmodule

