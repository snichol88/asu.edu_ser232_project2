`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:43:44 04/15/2015
// Design Name:   project2_m
// Module Name:   
// Project Name:  project2_tb
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: project2_m
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sjnicho1_tb;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg s;

	// Outputs
	wire [6:0] lcd;
	wire lcd_o;
	
	

	// Instantiate the Unit Under Test (UUT)
	project2_m uut (
		.a(a), 
		.b(b), 
		.s(s), 
		.lcd(lcd), 
		.lcd_o(lcd_o)
	);

	initial begin
	$monitor("a=%b, b=%b, s=%b, lcd=%b, lcd_o=%b",a,b,s,lcd,lcd_o);
		// Initialize Inputs
		a = 6;
		b = 1;
		s = 1;

		// Wait 100 ns for global reset to finish
		#100;
		// Initialize Inputs
		a = 8;
		b = 1;
		s = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Initialize Inputs
		a = 2;
		b = 1;
		s = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Initialize Inputs
		a = 9;
		b = 4;
		s = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Initialize Inputs
		a = 9;
		b = 3;
		s = 0;

		// Wait 100 ns for global reset to finish
		#100;

	end
      
		
endmodule

