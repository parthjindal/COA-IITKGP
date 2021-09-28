`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Complement2
// Description: This module is used to implement the 2's complement of the input using a FSM
//////////////////////////////////////////////////////////////////////////////////
module Complement2(
    output reg out,
    input in,
    input clk,
    input rst);
        
    reg PS, NS;
    parameter S0 = 1'b0, S1 = 1'b1;

    always @(posedge clk or posedge rst) begin
        if (rst)
            PS <= S0;
        else
            PS <= NS;
    end

    always @(*) begin
        case (PS)
            S0: begin
                if (in == 1'b0) begin
                    out = 1'b0;
                    NS = S0;
                end else begin
                    out = 1'b1;
                    NS = S1;
                end
            end
            S1: begin
                if (in == 1'b0) begin
                    out = 1'b1;
                    NS = S1;
                end else begin
                    out = 1'b0;
                    NS = S1;
                end
            end
        endcase
    end
endmodule
