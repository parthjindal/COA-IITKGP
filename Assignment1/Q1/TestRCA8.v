`include "RCA8.v"

module testBench;
    reg [7:0] a,b; reg cIn;
    wire [7:0] s; wire cOut;
    RCA8 RCA(.s(s), .cIn(cIn), .cOut(cOut),.a(a),.b(b));
    initial begin
        a = 8'd45; b = 8'd12; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 8'd45; b = 8'd12; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 8'd251; b = 8'd4; cIn = 1'b0; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        a = 8'd251; b = 8'd4; cIn = 1'b1; #5;
        $display("A = %d, B = %d, Cin = %b, Sum = %d, Cout = %b", a, b, cIn, s, cOut);
        #5 $finish;
    end 
endmodule
