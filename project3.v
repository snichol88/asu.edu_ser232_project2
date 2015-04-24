`timescale 10fs / 1fs
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sean Nichol
// 
// Create Date:    
// Design Name: 
// Module Name:   Project3
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

module project3(
	


	//declare variables
   input [15:0] A,
	input [15:0] B,
	input [3:0] Opcode,
	output [15:0] print,
	output ov	
	);
	
	//intiate wire calculations
	wire [15:0] addition_result = A + B;
	wire [15:0] subtract_result = A - B;
	wire [15:0] multiply_result = (A*5);
	wire [15:0] divide_result = (A/10);
	wire [15:0] increase_result = (A+1);
	wire [15:0] decrease_result = (B-1);
	wire [15:0] bit_and_result = (A & B);
	wire [15:0] bit_xor_result = (A ^ B);
	wire [15:0] bit_or_result = (A | B);
	wire [15:0] complement = ~A;
	wire [15:0] final;
	wire overflow;
	
	mux muxer(
		.addition(addition_result),
		.subtract(subtract_result),
		.multiply(multiply_result),
		.divide(divide_result),
		.increase(increase_result),
		.decrease(decrease_result),
		.bit_and(bit_and_result),
		.bit_xor(bit_xor_result),
		.bit_or(bit_or_result),
		.comp(complement),
		.s(Opcode),
		.mux_out(final),
		.ovf(overflow)
	);
	
	//assign multiplexor final to print
	assign print = final;
	assign ov = overflow;
	
endmodule

module  mux(
	
	//initialize calculations
	input [15:0] addition,
	input [15:0] subtract,
	input [15:0] multiply,
	input [15:0] divide,
	input [15:0] increase,
	input [15:0] decrease,
	input [15:0] bit_and,
	input [15:0] bit_xor,
	input [15:0] bit_or,
	input [15:0] comp,
	input [3:0] s,
	output [15:0] mux_out,
	output reg ovf
	);
	
	reg [15:0] mux;
	assign mux_out = mux;	

	//begin block to choose calculation based upon input s
	//account for overflow 
	always @ (s or addition or subtract or multiply or divide or increase or decrease or bit_and or bit_xor or bit_or or ovf)
	begin : MUX
		//addition if 0 is chosen
		//accounts for over flow if > 32768 or < -32768
		if (s == 4'b0000) begin
			assign mux = addition;			
			if (addition > 65535 || addition < 0)
			ovf = 1'b1;
			else
			ovf = 1'b0;				
		end 
		
		//subtraction if 1 is chosen
		//accounts for over flow 
		else if(s == 4'b0001) begin
			assign mux = subtract;
			if (subtract > 65535 || subtract < 0)
			ovf = 1'b1;
			else 
			ovf = 1'b0;	
			
		end 
		
		//multiplication if 2 is chosen
		//accounts for over flow 
		else if(s == 4'b0010) begin
			assign mux = multiply;
			if (multiply > 65535)
			ovf = 1'b1;
			else if (multiply < -65535)
			ovf = 1'b1;	
			else
			ovf = 1'b0;				
		end 
		
		//division if 3 is chosen
		//no overflow for division, bit_or, bit_and, bit_or
		else if(s == 4'b0011) begin
			assign mux = divide;
		end 
		
		//increase if 4 is chosen
		else if(s == 4'b0100) begin
			assign mux = increase;
			if (increase == 65534)
			ovf = 1'b1;
			else
			ovf = 1'b0;	
		end 
		
		//decrease if 5 is chosen
		else if(s == 4'b0101) begin
			assign mux = decrease;
			if (decrease == -65534)
			ovf = 1'b1;
			else
			ovf = 1'b0;	
		end 
		
		//bit_and if 6 is chosen
		else if(s == 4'b0110) begin
			assign mux = bit_and;
		end 
		
		//bit_xor if 7 is chosen
		else if(s == 4'b0111) begin
			assign mux = bit_xor;
		end 
		
		//bit_or if 8 is chosen
		else if(s == 4'b1000) begin
			assign mux = bit_or;
		end 
		
		//complement if 9 is chosen
		else if(s == 4'b1000) begin
			assign mux = comp;
		end
		
	end 

endmodule

