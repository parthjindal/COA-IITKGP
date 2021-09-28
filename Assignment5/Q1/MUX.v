`timescale 10ns/1ps

module mux(out, d0, d1, sel);
//input
input d0, d1, sel ;

//output 
output out ;

assign out = (sel) ? d1 : d0 ;
endmodule