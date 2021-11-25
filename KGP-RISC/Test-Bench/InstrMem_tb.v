`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:36:35 11/05/2021
// Design Name:   InstrMem
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/InstrMem_tb.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstrMem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstrMem_tb;

	// Inputs
	reg clk;
	reg [9:0] addra;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	InstrMem uut (
		.clka(clk), 
		.addra(addra), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		addra = 0;

		// Wait 100 ns for global reset to finish
		#100;

		@(posedge clk)
		addra = 10'd0;
		
		#10; addra = 10'd0;
		#10; addra = 10'd1;
		
		// Add stimulus here
	end
	
	always
	#5 clk = ~clk;
	   
endmodule

