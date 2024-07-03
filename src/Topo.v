/*
	Topo.v
	Ronzani, Maurício Darabas
	
	Descriçao: Arquivo Topo.v arquivo principal
	
	Revisão:
	
	*/
	
	module Topo
	(
		CLOCK_50, KEY,	SW,
		
		LEDR, LEDS,
		HEX0,	HEX1,	HEX2,	HEX3,	HEX4,	HEX5		
	);
	
	localparam P_KEY	=4;
	localparam P_SW	=10;
	localparam P_LEDR	=10;
	localparam P_HEX	=7;

	// Input Ports
	input CLOCK_50;
	input wire [P_KEY-1:0] KEY;
	input wire [P_SW-1:0] SW;


	// Output Ports
	output wire [3:0] LEDR;
	output wire [9:6] LEDS;
	output wire [P_HEX-1:0] HEX0;
	output wire [P_HEX-1:0] HEX1;
	output wire [P_HEX-1:0] HEX2;
	output wire [P_HEX-1:0] HEX3;
	output wire [P_HEX-1:0] HEX4;
	output wire [P_HEX-1:0] HEX5;

	
	
	wire w_R1, w_R2, w_E1,w_E2,w_E3,w_E4,w_end_FPGA,w_end_User,w_end_time,w_win,w_match,w_SEL;
	datapath U0_DP
(
		.CLOCK_50(CLOCK_50),
		.KEY(KEY),
		.SWITCH(SW[9:2]), //.SWITCH({SW[9],SW[8],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2]}),
		.R1(w_R1), .R2(w_R2), .E1(w_E1), .E2(1'b1), .E3(w_E3), .E4(w_E4), .SEL(w_SEL),
		//saídas de dados
		.hex0(HEX0), .hex1(HEX1), .hex2(HEX2),	.hex3(HEX3), .hex4(HEX4), .hex5(HEX5),
		.ledr(LEDR[3:0]), .leds(LEDS[9:6]),
		//saídas de dados
		.end_FPGA(w_end_FPGA), .end_User(w_end_User), .end_time(w_end_time), .win(w_win), .match(w_match)	
	);

	
	controle U1_FSM
(
	.CLOCK(CLOCK_50),.enter(SW[0]),.reset(SW[1]),
	.end_FPGA(w_end_FPGA),.end_User(w_end_User),.end_time(w_end_time),
	.win(w_win),	.match(w_match),
	
	.R1(w_R1),.R2(w_R2),.E1(w_E1),.E2(),.E3(w_E3),.E4(w_E4),.SEL(w_SEL)
	);

endmodule
