`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_SeqComparator
// Description: Testbench for the sequential comparator
////////////////////////////////////////////////////////////////////////////////

module Test_SeqComparator;

	// Inputs
	reg OP;
	reg [31:0] A;
	reg [31:0] B;
	reg clk;
	reg rst;
	reg load;

	// Outputs
	wire Lout;
	wire Eout;
	wire Gout;

	// Instantiate the Unit Under Test (UUT)
	SeqComparator uut (
		.Lout(Lout), 
		.Eout(Eout), 
		.Gout(Gout), 
		.OP(OP), 
		.A(A), 
		.B(B), 
		.clk(clk), 
		.rst(rst), 
		.load(load)
	);

	integer i;
	initial begin
		// Initialize Inputs
		OP = 0;
		A = 32'd4294;
		B = 32'd4295;
		clk = 0;
		rst = 0;
		load = 0;

		#1 rst = 1;
		#1 rst = 0; load = 1;
		#1 load = 0;
		#1;
		for(i = 0; i < 32; i = i + 1) begin
			#8;
		end
		OP = 1;
		#1 $display("A=%d, B=%d, L = %b, E = %b, G = %b", A, B, Lout, Eout, Gout); 
		
		rst = 1; A = 32'd1234; B = 32'd196; OP = 0;
		#1 rst = 0; load = 1;
		#1 load = 0;
		#1;
		for(i = 0; i < 32; i = i + 1) begin
			#8;
		end
		OP = 1;
		#1 $display("A=%d, B=%d, L = %b, E = %b, G = %b", A, B, Lout, Eout, Gout);
		
		rst = 1; A = 32'd1103; B = 32'd1103; OP = 0;
		#1 rst = 0; load = 1;
		#1 load = 0;
		#1;
		for(i = 0; i < 32; i = i + 1) begin
			#8;
		end
		OP = 1;
		#1 $display("A=%d, B=%d, L = %b, E = %b, G = %b", A, B, Lout, Eout, Gout); 
		$finish;
	end
   always
	#4 clk = ~clk;
      
endmodule

