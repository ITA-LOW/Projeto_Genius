module MUX4x1_4bits
(
	SEL,
	ENT0,
	ENT1,
	ENT2,
	ENT3,
	out
);

	localparam P_SEL		=2;
	localparam P_ENT		=4;
	localparam P_OUT	=4;

	// Input Port(s)
	input wire [P_SEL-1:0]SEL;
	input wire [P_ENT-1:0]ENT0;
	input wire [P_ENT-1:0]ENT1;
	input wire [P_ENT-1:0]ENT2;
	input wire [P_ENT-1:0]ENT3;
	
	// Output Port(s)
	output wire [P_OUT-1:0]out;

endmodule
