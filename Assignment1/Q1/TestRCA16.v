`include "RCA16.v"

module testBench;
    reg [15:0] a,b; reg cIn;
    wire [15:0] s; wire cOut;
    RCA16 RCA(.s(s), .cIn(cIn), .cOut(cOut),.a(a),.b(b));
    initial begin
        a = 16'd32; b = 16'd64; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 16'd32; b = 16'd64; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 16'd65531; b = 16'd4; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 16'd65531; b = 16'd4; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        #5 $finish;
    end 
endmodule
