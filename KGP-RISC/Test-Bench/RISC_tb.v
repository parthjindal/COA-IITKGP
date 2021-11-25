`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:59:06 11/08/2021
// Design Name:   RISC
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/RISC_tb.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RISC_tb;

	// Inputs
	reg clk;
	reg rst;
	// Instantiate the Unit Under Test (UUT)
	RISC uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#2;
		rst = 0;
		#3;
		#5000;
		$finish;
		// Add stimulus here
	end
	
	always @(*) begin
		if (uut.RFile.r[1] == 1) begin
			$display("Content of return value register $v0: %d", uut.RFile.r[2]);
			$finish;
		end
	end
	
	always
	#5 clk = ~clk;
      
endmodule

