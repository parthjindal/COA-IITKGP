`include "FA.v"

module testBench;
    reg a, b, cIn;
    integer i;
    wire s, cOut;
    FullAdder FA(.a(a), .b(b), .cIn(cIn), .s(s), .cOut(cOut));
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cIn} = i; #5;        
            $display("A = %b, B = %b, Cin = %b, S = %b, Cout = %b",a,b,cIn,s,cOut);
        end
        #5 $finish;
    end
endmodule