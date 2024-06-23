module MUX4X1
(
	level,
	CL1,
	CL2,
	CL3,
	CL4,
	CLKHZ
);

	localparam P_level	=2;

	// Input Port(s)
	input wire [P_level-1:0]level;
	input wire CL1;
	input wire CL2;
	input wire CL3;
	input wire CL4;
	
	// Output Port(s)
	output wire CLKHZ;

endmodule
