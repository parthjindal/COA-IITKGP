`timescale 1ns/1ps

module barrel_shifter(
    input [7:0] in,
    input [2:0] shamt,
    input dir,
    output [7:0] out 
    );

    wire [7:0] muxin4 ;
    wire [7:0] muxout4 ;
    wire [7:0] muxin2 ;
    wire [7:0] muxout2 ;
    wire [7:0] muxin1 ;
    // wire [7:0] muxout1 ;
    // no wire needed for output of 1-bit shift as that is the final output value

    // setting one set of input values for 2-1 multiplexer
    assign muxin4 = dir ? {in[3:0], 4'b0} : {4'b0, in[7:4]} ;
    assign muxin2 = dir ? {muxout4[5:0], 2'b0} : {2'b0, muxout4[7:2]} ;
    assign muxin1 = dir ? {muxout2[6:0], 1'b0} : {1'b0, muxout2[7:1]} ;

    // 4-bit shift 
    // muxin4 wire is assigned values depending on direction ( 0s appended at the end or start based on left or right shift)
    // mux for 4-bit shift
    mux2_1 m4bit(muxout4, in, muxin4, shamt[2]) ;

    // 2-bit shift 
    // muxin2 wire is assigned values depending on direction ( 0s appended at the end or start based on left or right shift)
    // mux for 2-bit shift
    mux2_1 m2bit(muxout2, muxout4, muxin2, shamt[1]) ;

    // 1-bit shift 
    // muxin1 wire is assigned values depending on direction ( 0s appended at the end or start based on left or right shift)
    // mux for 1 bit shift
    mux2_1 m1bit(out, muxout2, muxin1, shamt[0]) ;

endmodule 
