`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:54:54 10/08/2021
// Design Name:   BitSerialAdder
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/Assignment6/TestBitSerialAdder.v
// Project Name:  Assignment6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BitSerialAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBitSerialAdder;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg clk;
	reg rst;
	reg Cin;
	
	// Outputs
	wire [7:0] Out;
	wire Cout;
	// Instantiate the Unit Under Test (UUT)
	BitSerialAdder uut (
		.A(A), 
		.B(B), 
		.clk(clk), 
		.rst(rst), 
		.Cin(Cin), 
		.Out(Out), 
		.Cout(Cout)
	);
	integer i;
	
	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		clk = 0;
		rst = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
      A = 8'd99; B = 8'd100; rst = 1;
		// Add stimulus here
		#3 rst = 0;
		#1;
		for(i = 0; i < 8; i = i + 1) begin
			#4;
		end
		$display("A = %d, B = %d, Sum = %d", A, B, Out);
	
	end
	always 
	#2 clk = ~clk;

      
endmodule

