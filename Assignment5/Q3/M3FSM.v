`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Test_M3FSM
// Description: Multiple of 3's FSM's Test Bench 
//////////////////////////////////////////////////////////////////////////////////
module M3FSM(
    output reg out,
    input inp,
    input clk,
    input rst
    );
    reg[1:0] PS, NS;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    
    // load stored next state into present state
    always @(posedge clk or posedge rst) begin
        if(rst)
            PS <= S0;
        else
            PS <= NS;
    end
    
    // logic for 
    always @(*) begin
        case (PS)
            S0: begin
            case (inp)
                0: begin	
                    out = 1;
                    NS = S0;
                    end
                1:	begin
                    out = 0;
                    NS = S1;
                    end
            endcase
            end
        S1: begin
            case (inp)
                0: begin	
                   out = 0;
                    NS = S2;
                    end
                1:	begin
                    out = 1;
                    NS = S0;
                    end
            endcase
            end
        S2: begin
            case (inp)
                0: begin	
                    out = 0;
                    NS = S1;
                    end
                1:	begin
                    out = 0;
                    NS = S2;
                    end
            endcase
            end			
        endcase
    end
endmodule
