`timescale 10ns/1ps

module mux(out, d0, d1, sel);
//input
input d0, d1, sel ;

//output 
output out ;
reg out ;

always @(sel or d0 or d1)
begin
    out = (sel) ? d1 : d0 ;
end
endmodule
