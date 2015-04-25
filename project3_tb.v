`timescale 10fs / 1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   
// Design Name:   
// Module Name:   
// Project Name:  
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module team34_tb;

	// Inputs
	reg signed [15:0] A;
	reg signed [15:0] B;
	reg [3:0] Opcode;

	// Outputs
	
	wire signed [15:0] print;
	wire ov;
	// Instantiate the Unit Under Test (UUT)
	project3 uut (
		.A(A), 
		.B(B), 
		.Opcode(Opcode), 
		.print(print),
		.ov(ov)
	);

	initial begin
	$display("This is a two 16 bit input calculator");
	$display("Team 34: Adam Perry, Sean Nichol, John Ogg and Andrew Raston");
	
	$display("\n Run Simulation...");
	$monitor("A:%d,B:%d,Opcode:%d, print:%d,ov:%b",A,B,Opcode,print,ov);
	
	
		// Initialize Inputs
		$display("\n --Addition--");
		Opcode = 0;
		A=36;     B=25; #100; 
		A=12000;  B=12000; #100; 
		A=30000;  B=2500; #100; 
		A=32767;  B=5000; #100; 
		A=-32767;  B=1; #100; 
		
		$display("\n --Subtraction--");
		Opcode = 1;
		A=36;     B=25; #100; 
		A=12000;  B=12000; #100; 
		A=30000;  B=2500; #100; 
		A=32000;  B=33000; #100; 
		A=-32767;  B=1; #100; 
		
		$display("\n --Multiplication--");
		Opcode = 2;
		A=36;     B=0; #100; 
		A=-7000;  B=0; #100; 
		A=-326;  B=0; #100; 
		A=2000;  B=0; #100; 
		A=6533; B=0; #100; 
		
		$display("\n --Division--");
		Opcode = 3;
		A=36;     B=0; #100; 
		A=-7000;  B=0; #100; 
		A=-326;  B=0; #100; 
		A=2000;  B=0; #100; 
		A=6533; B=0; #100; 
		
		$display("\n --Increase--");
		Opcode = 4;
		A=36;     B=0; #100; 
	   	A=-7000;  B=0; #100; 
		A=-326;  B=0; #100; 
		A=2000;  B=0; #100; 
		A=32766; B=0; #100; 
		
		$display("\n --Decrease--");
		Opcode = 5;
		A=36;     B=0; #100; 
	   	A=-7000;  B=0; #100; 
		A=-326;  B=0; #100; 
		A=2000;  B=0; #100; 
		A=-32767; B=0; #100; 
		
		$display("\n --Bit_and--");
		Opcode = 6;
		A=36;     B=25; #100; 
	   	A=12000;  B=12000; #100; 
		A=30000;  B=2500; #100; 
		A=32000;  B=33000; #100; 
		A=-32767;  B=1; #100; 
		
		$display("\n --Bit_xor--");
		Opcode = 7;
		A=36;     B=25; #100; 
	   	A=12000;  B=12000; #100; 
		A=30000;  B=2500; #100; 
		A=32000;  B=33000; #100; 
		A=-32767;  B=1; #100;  
		
		$display("\n --bit_or--");
		Opcode = 8;
		A=36;     B=25; #100; 
	   	A=12000;  B=12000; #100; 
		A=30000;  B=2500; #100; 
		A=32000;  B=33000; #100; 
		A=-32767;  B=1; #100;  
		
		$display("\n --Complement--");
		Opcode = 9;
		A=36;     B=0; #100; 
	   	A=12000;  B=0; #100; 
		A=30000;  B=0; #100; 
		A=32000;  B=0; #100; 
		A=-32767;  B=0; #100; 
		        
		// Add stimulus here

	end
      
endmodule

