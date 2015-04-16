`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:05 04/15/2015 
// Design Name: 
// Module Name:    sjnicho1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module single_bit_full_adder(
	input a,
	input b,
	input cin,
	output o,
	output cout
	);
	
	wire w_carry0, w_carry1, w_carry2;
	
	//check to see if this bit overflows
	and (w_carry0, a, b);
	and (w_carry1, a, cin);
	and (w_carry2, b, cin);
	
	//if the bit overflows, send a 1 on carry out
	or (cout, w_carry0, w_carry1, w_carry2);
	
	//add the three bits together
	xor(o, a, b, cin);
endmodule

module adder(
	input [3:0] a,
	input [3:0] b,
	output [3:0] out,
	output overflow
	);

	wire first_carry;
	single_bit_full_adder adder0(a[0], b[0], 1'b0, out[0], first_carry);
	
	wire second_carry;
	single_bit_full_adder adder1(a[1], b[1], first_carry, out[1], second_carry);
	
	wire third_carry;
	single_bit_full_adder adder2(a[2], b[2], second_carry, out[2], third_carry);
	
	single_bit_full_adder adder3(a[3], b[3], third_carry, out[3], overflow);
endmodule

module display_converter(
	input [3:0] in,
	input over_in,
	output [6:0] lcd,
	output over_out
	);
		
	//prep the inversions
	wire [3:0] nots;
	not(nots[3], in[3]);
	not(nots[2], in[2]);
	not(nots[1], in[1]);
	not(nots[0], in[0]);
	
	//each of these is a minterm in the boolean equations
	//they are reused across lcd segments, so we'll
	//define them for reuse
	wire one, two, three, four, five, six, seven, eight, nine, zero;
	and(one, nots[3], nots[2], nots[1], in[0]);
	and(two, nots[3], nots[2], in[1], nots[0]);
	and(three, nots[3], nots[2], in[1], in[0]);
	and(four, nots[3], in[2], nots[1], nots[0]);
	and(five, nots[3], in[2], nots[1], in[0]);
	and(six, nots[3], in[2], in[1], nots[0]);
	and(seven, nots[3], in[2], in[1], in[0]);
	and(eight, in[3], nots[2], nots[1], nots[0]);
	and(nine, in[3], nots[2], nots[1], in[0]);
	and(zero, nots[3], nots[2], nots[1], nots[0]);
	
	//each segment can be defined as a series of numbers
	//that turn it on
	or(lcd[6], two, three, five, six, seven, eight, nine, zero);
	or(lcd[5], one, two, three, four, seven, eight, nine, zero);
	or(lcd[4], one, three, four, five, six, seven, eight, nine, zero);
	or(lcd[3], two, three, five, six, eight,nine, zero);
	or(lcd[2], two, six, eight, zero);
	or(lcd[1], four, five, six, eight, nine, zero);
	or(lcd[0], two, three, four, five, six, eight, nine);
	
	//numbers 10-15 produce overflow
	//defined by: w(x+y)
	wire four_or_two_bit;
	or(four_or_two_bit, x, y);
	and(over_out, in[3], four_or_two_bit);
	
endmodule

module project2_m(
    input [3:0] a,
    input [3:0] b,
    input s,
    output [6:0] lcd,
	output lcd_o
	);
	
	wire [3:0] real_a;
	
	//if we want to subtract, we must invert the a inputs
	xor(real_a[0], a[0], s);
	xor(real_a[1], a[1], s);
	xor(real_a[2], a[2], s);
	xor(real_a[3], a[3], s);
	
	wire [3:0] result;
	wire overflow;
	
	adder add(real_a, b, result, overflow);
	
	//if we want to subtract, we must also invert the output
	wire [3:0] final;
	xor(final[0], result[0], s);
	xor(final[1], result[1], s);
	xor(final[2], result[2], s);
	xor(final[3], result[3], s);
	
	display_converter display(final, overflow, lcd, lcd_o);
endmodule
