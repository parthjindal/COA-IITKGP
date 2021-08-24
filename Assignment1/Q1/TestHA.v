`include "HA.v"

module testBench;
    reg a,b;
    integer i;
    wire s,c;
    HalfAdder HA(s,c,a,b);
    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            {a,b} = i; #5;
            $display("A = %b, B = %b, S = %b, C = %b",a,b,s,c);
        end
        #5 $finish;
    end
endmodule