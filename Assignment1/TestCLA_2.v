`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
 
////////////////////////////////////////////////////////////////////////////////

module TestCLA_2;

	// Inputs
	reg cIn;
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [3:0] s;
	wire P;
	wire G;
	wire cOut;
	// Instantiate the Unit Under Test (UUT)
	CLA_2 uut (
		.s(s), 
		.P(P), 
		.G(G), 
		.cIn(cIn), 
		.a(a), 
		.b(b)
	);
	assign cOut = G | (P & cIn);
	initial begin
		// Initialize Inputs
		cIn = 0;
		a = 0;
		b = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		$monitor($time,"\ta=%d,\tb=%d,\tcIn=%b,\ts=%d,\tcOut=%d",a,b,cIn,s,cOut);
		#1 a =  3; b = 5; cIn = 0;
		#1 a = 10; b = 4; cIn = 1;
		#1 a = 10; b = 5; cIn = 0;
		#1 a = 10; b = 5; cIn = 1;
	end
      
endmodule

