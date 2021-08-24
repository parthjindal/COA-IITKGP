`include "RCA64.v"

module testBench;
    reg [63:0] a,b; reg cIn;
    wire [63:0] s; wire cOut;
    RCA64 RCA(.s(s), .cIn(cIn), .cOut(cOut),.a(a),.b(b));
    initial begin
        a = 64'd64; b = 64'd64; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 64'd64; b = 64'd64; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 64'd18446744073709551611; b = 64'd4; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 64'd18446744073709551611; b = 64'd4; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        #5 $finish;
    end 
endmodule
