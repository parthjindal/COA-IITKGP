/**
 * @file HA.v
 * @assignment: Assignment 1
 * @problem: (1) Ripple Carry Adder
 * @description: Implementation for a Half Adder module
 * @author Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
 * @group X
 */

module HalfAdder(s, c, a, b);
    input a, b;
    output s, c;
    assign s = a ^ b;
    assign c = a & b;
endmodule