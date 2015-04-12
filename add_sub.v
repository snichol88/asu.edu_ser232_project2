`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Sean Nichol
// 
// Create Date:    18:38:52 04/11/2015 
// Design Name: 
// Module Name:    add_sub 
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
module add_sub(total, Carry, OV, A, B, S, lcd);

   output [3:0] total;   // The total after add/subtract
   output 	Carry;   // the 1-bit carry or borrow status
   output 	OV;   // Overflow 1-bit
   output [6:0] lcd;
	
   input [3:0] 	A;   // First 4-bit input
   input [3:0] 	B;   // Second 4-bit input
   input 	S;  // The calculation: 0 for add, 1 for subtract
   
   wire 	C0; // The bit carried out of fa0, the bit carried into fa1.
   wire 	C1; // The bit carried out of fa1, the bit carried into fa2.
   wire 	C2; // The bit carried out of fa2, the bit carried into fa3.
   wire 	C3; // The bit carried out of fa2, will generate the final carry/borrow
   
   wire 	B0; // The xor'd result of B[0] and S
   wire 	B1; // The xor'd result of B[1] and S
   wire 	B2; // The xor'd result of B[2] and S
   wire 	B3; // The xor'd result of B[3] and S


	//xor truth table    
   xor(B0, B[0], S);
   xor(B1, B[1], S);
   xor(B2, B[2], S);
   xor(B3, B[3], S);
   xor(Carry, C3, S);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
   xor(OV, C3, C2);     // If the caarry outputs differ from eachother, then there is an overflow
	
	//instantiated adder module
  adder fa0(total[0], C0, A[0], B0, S);    // the least significant bit
  adder fa1(total[1], C1, A[1], B1, C0);
  adder fa2(total[2], C2, A[2], B2, C1);
  adder fa3(total[3], C3, A[3], B3, C2);    // the most significant
	
	//instantiated segment module
	display_seg segment(total, lcd);
	
endmodule 

// full adder module
module adder(total, C_out, A, B, C_in);
   output total;
   output C_out;
   input  A;
   input  B;
   input  C_in;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(total, C_in, w1);
   and(w2, A, B);   
   and(w3, A, C_in);
   and(w4, B, C_in);   
   or(C_out, w2, w3, w4);
	
endmodule

// 7 segment display module
module display_seg (A, Conv);

input [3:0] A;
output [6:0] Conv;

//prep the inversions
	wire w_not, x_not, y_not, z_not;
	not(w_not, A[0]);
	not(x_not, A[1]);
	not(y_not, A[2]);
	not(z_not, A[3]);
	
	//each of these is a minterm in the boolean equations
	//they are reused across lcd segments, so we'll
	//define them for reuse
	wire one, two, three, four, five, six, seven, eight, nine, zero;
	and(zero, w_not, x_not, y_not, z_not);
	and(one, w_not, x_not, y_not, A[3]);
	and(two, w_not, x_not, A[2], z_not);
	and(three, w_not, x_not, A[2], A[3]);
	and(four, w_not, A[1], y_not, z_not);
	and(five, w_not, A[1], y_not, A[3]);
	and(six, w_not, A[1], A[2], z_not);
	and(seven, w_not, A[1], A[2], A[3]);
	and(eight, A[0], x_not, y_not, z_not);
	and(nine, A[0], x_not, y_not, A[3]);
	
	
	//each segment can be defined as a series of numbers
	//that turn it on
	or(Conv[0], two, three, five, six, seven, eight, nine, zero);
	or(Conv[1], one, two, three, four, seven, eight, nine, zero);
	or(Conv[2], one, three, four, five, six, seven, eight, nine, zero);
	or(Conv[3], two, three, five, six, seven, eight, zero);
	or(Conv[4], two, six, eight, zero);
	or(Conv[5], four, five, six, eight, nine, zero);
	or(Conv[6], two, three, four, five, six, eight, nine); 
	
	//numbers 10-15 also produce overflow
	//defined by: w(x+y)
	wire internal_overflow, four_or_two_bit;
	or(four_or_two_bit, A[1], A[2]);
	and(internal_overflow, A[0], four_or_two_bit);
	
	or(over_out, over_in, internal_overflow);
	
endmodule
