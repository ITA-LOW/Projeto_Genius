module MUX2x1_7bits
(
	SEL,
	ENT0,
	ENT1,
	out
);

	localparam P_ENT	=7;
	localparam P_OUT	=7;

	// Input Port(s)
	input wire SEL;
	input wire [P_ENT-1:0]ENT0;
	input wire [P_ENT-1:0]ENT1;
	
	// Output Port(s)
	output wire [P_OUT-1:0]out;

endmodule
