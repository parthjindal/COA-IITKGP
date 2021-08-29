`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

module TestRCA4;

	// Inputs
	reg cIn;
	reg [3:0] a;
	reg [3:0] b;

	// Outputs
	wire [3:0] s;
	wire cOut;

	// Instantiate the Unit Under Test (UUT)
	RCA4 uut (
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
		#1 a =  4; b = 4; cIn = 0;
		#1 a = 10; b = 5; cIn = 0;
		#1 a = 10; b = 5; cIn = 1;
        
		// Add stimulus here

	end
      
endmodule

