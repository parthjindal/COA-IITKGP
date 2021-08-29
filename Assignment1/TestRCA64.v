`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

module TestRCA64;

	// Inputs
	reg cIn;
	reg [63:0] a;
	reg [63:0] b;

	// Outputs
	wire [63:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	RCA64 uut (
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
        
		// Add stimulus here
		$monitor($time,"\ta=%d,\tb=%d,\tcIn=%b,\ts=%d,\tcOut=%b",a,b,cIn,s,cOut);
		#1 a =         64'd32; b = 64'd64; cIn = 0;
		#1 a =         64'd32; b = 64'd64; cIn = 1;
		#1 a = 64'd18446744073709551611; b =  64'd4; cIn = 0;
		#1 a = 64'd18446744073709551611; b =  64'd4; cIn = 1;
	end
      
endmodule

