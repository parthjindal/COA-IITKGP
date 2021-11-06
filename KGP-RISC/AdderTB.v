`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:03:49 11/05/2021
// Design Name:   Adder
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/AdderTB.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AdderTB;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] sum;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	Adder uut (
		.a(a), 
		.b(b), 
		.sum(sum), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$monitor("a = %d, b = %d, sum = %d, carry = %b", a, b, sum, carry);
		a = 32'd2147483648; b = 32'd1073741824; #10;
        
		// Add stimulus here

	end
      
endmodule

