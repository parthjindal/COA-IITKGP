`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:17 11/06/2021
// Design Name:   ALU
// Module Name:   /home/parth/5th-Sem/Computer-Organization-and-Architecture-Laboratory/KGP-RISC/ALU_tb.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg signed [31:0] a;
	reg signed [31:0] b;
	reg [3:0] op;
	reg [4:0] shamt;

	// Outputs
	wire signed [31:0] result;
	wire fZero;
	wire fSign;
	wire fCarry;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.a(a), 
		.b(b), 
		.op(op), 
		.shamt(shamt), 
		.result(result), 
		.fZero(fZero), 
		.fSign(fSign), 
		.fCarry(fCarry)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		op = 0;
		shamt = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$monitor("a = %d, b = %d, result = %d, fZero = %b, fSign = %b, fCarry = %b, op = %b, shamt = %d",a,b,result,fZero,fSign,fCarry,op,shamt);
		a = 32'd12; b = 32'd 10; op = 4'b0001; #10; // add
		a = 32'd12; op = 4'b0000; #10 // forward
		b = 32'd10; op = 4'b0101; #10 // complement
		a = 32'd8; b = 32'd8; op = 4'b0011; #10; //xor
		op = 4'b0010; #10; //and
		a = 32'd4; op = 4'b1100; shamt = 5'd2; #10; // shift-left-logical 1 by 2 bits
      a = 32'd8; op = 4'b1110; shamt = 5'd2; #10; // shift-right-logical 8 by 2 bits
		a = 32'd4; op = 4'b1000; shamt = 5'd16; b = 32'd2; #10; // shift-left-variable 1 by 2 bits
		a = -32'd2147483648; op = 4'b1010; shamt = 5'd16; b = 32'd2; #10; // shift-right-logical-variable 8 by 2 bits
		a = 32'd8; op = 4'b1111; shamt = 5'd2;  b = 32'd50; #10; // shift-right-arithmatic 8 by 2 bits
		a = -32'd2147483648; op = 4'b1011; shamt = 5'd16;  b = 32'd2; #10; // shift-right-arithmatic-variable 8 by 2 bits

		// Add stimulus here
	end
      
endmodule

