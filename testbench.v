`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Sean Nichol
//
// Create Date:   18:39:54 04/11/2015
// Design Name: 	project2
// 
//
// Verilog Test Fixture created by ISE for module: add_sub
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg S;
	reg [6:0] lcd;

	// Outputs
	wire [3:0] total;
	wire Carry;
	wire OV;

	// Instantiate the Unit Under Test (UUT)
		add_sub uut (
		.total(total), 
		.Carry(Carry), 
		.OV(OV), 
		.A(A), 
		.B(B), 
		.S(S),
		.lcd(lcd)
	);

	initial begin
	$monitor("A=(%b), B=(%b), S=(%b), lcd=(%b)" ,A,B,S, lcd);
		// Initialize Inputs
		A = 5;
		B = 4;
		S = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
		
		// Initialize Inputs
		A = 0001;
		B = 0001;
		S = 0;
		// Wait 100 ns for global reset to finish
		#100;       
		
		A = 0001;
		B = 0001;		
		S = 0;
		
		#100;        
		  
		A = 5;
		B = 1;
		S = 1;
		#100;        
		
		A = 9;
		B = 8;
		S = 1;		
		#100;


	end
      
endmodule
