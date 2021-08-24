`include "RCA32.v"

module testBench;
    reg [31:0] a,b; reg cIn;
    wire [31:0] s; wire cOut;
    RCA32 RCA(.s(s), .cIn(cIn), .cOut(cOut),.a(a),.b(b));
    initial begin
        a = 32'd32; b = 32'd64; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 32'd32; b = 32'd64; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 32'd4294967291; b = 32'd4; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 32'd4294967291; b = 32'd4; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        #5 $finish;
    end 
endmodule
