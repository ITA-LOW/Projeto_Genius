	module datapath
(
	CLOCK_50,
	KEY,
	SWITCH,
	R1,
	R2,
	E1,
	E2,
	E3,
	E4,
	SEL,
	hex0,
	hex1,
	hex2,
	hex3,
	hex4,
	hex5,
	leds,
	end_FPGA,
	end_User,
	end_time,
	win,
	match	
	);
	
	
	localparam P_KEY		=4;
	localparam P_SWITCH	=8;
	localparam P_HEX		=7;
	localparam P_LEDS		=4;

	// Input Port(s)
	input wire CLOCK_50;
	input wire [P_KEY-1:0]KEY;
	input wire [P_SWITCH-1:0]SWITCH;
	input wire R1;
	input wire R2;
	input wire E1;
	input wire E2;
	input wire E3;
	input wire E4;
	input wire SEL;

	// Output Ports
	output wire [P_HEX-1:0]hex0;
	output wire [P_HEX-1:0]hex1;
	output wire [P_HEX-1:0]hex2;
	output wire [P_HEX-1:0]hex3;
	output wire [P_HEX-1:0]hex4;
	output wire [P_HEX-1:0]hex5;
	output wire [P_LEDS-1:0]leds;
	output wire end_FPGA;
	output wire end_User;
	output wire end_time;
	output wire win;
	output wire match;
	
	
	assign leds=0;
	
	//wire [3:0]w_tempo; //ligar no dec7seg depois. w_tempo substituido por TIME
	wire [3:0] TIME;
	counter_time U0_CT
	(
	.CLKT(CLOCK_50), .R(R2), .E(E2),
	.TEMPO(TIME), .end_time(end_time)
	);
	
	

wire w_win;
assign win=w_win;
wire w_mux0_mux1;
mux2x1 MUX0
(
	.a(7'b1000_111), // 1 - U
	.b(7'b1011_011), // 0 - F
	.sel(w_win),
	.q	(w_mux0_mux1)
);

mux2x1 MUX1
(
	.a(w_mux0_mux1), // 1 - w_mux0_mux1
	.b(7'b0001_110), // 0 - L
	.sel(SEL),
	.q	(hex5)
);

//----------------------------------------
wire [7:0] SETUP;
wire [6:0] w_dec0_mux3;
wire [6:0] w_mux2_mux3;
dec7seg DEC0
(
	.bcd_i({2'b00,SETUP[7:6]}),
	.seg_o(w_dec0_mux3)
);

mux2x1 MUX2
(
	.a(7'b1011_011), // 1 - S
	.b(7'b1100_111), // 0 - P
	.sel(w_win),
	.q	(w_mux2_mux3)
);

mux2x1 MUX3
(
	.a(w_mux2_mux3), // 1 
	.b(w_dec0_mux3), // 0 
	.sel(SEL),
	.q	(hex4)
);

//---------------------------------------
wire [6:0] w_mux4_mux5;
mux2x1 MUX4
(
	.a(7'b1001_111), // 1 - E
	.b(7'b1111_011), // 0 - g
	.sel(w_win),
	.q	(w_mux4_mux5)
);

mux2x1 MUX5
(
	.a(w_mux4_mux5), // 1 
	.b(7'b0001_111), // 0 - t
	.sel(SEL),
	.q	(hex3)
);

//-------------------------------------


wire [6:0] w_dec1_mux7;
dec7seg DEC1
(
	.bcd_i(TIME),
	.seg_o(w_dec1_mux7)
);

wire [6:0] w_mux6_mux7;
mux2x1 MUX6
(
	.a(7'b1011_011), // 1 - r
	.b(7'b1100_111), // 0 - A
	.sel(w_win),
	.q	(w_mux6_mux7)
);

mux2x1 MUX7
(
	.a(w_mux6_mux7), // 1 
	.b(w_dec1_mux7), // 0 
	.sel(SEL),
	.q	(hex2)
);

//----------------------------------
wire [7:0] POINTS;
wire [6:0] w_dec2_mux8;
dec7seg DEC2
(
	.bcd_i(POINTS[7:4]),
	.seg_o(w_dec2_mux8)
);

mux2x1 MUX8
(
	.a(w_dec2_mux8), // 1 
	.b(7'b1011_011), // 0 - r
	.sel(SEL),
	.q	(hex1)
);
//-----------------------------------

wire [3:0] ROUND;
wire [6:0] w_dec3_mux9;
dec7seg DEC3
(
	.bcd_i(ROUND),
	.seg_o(w_dec3_mux9)
);

wire [6:0] w_dec4_mux9;
dec7seg DEC4
(
	.bcd_i(POINTS[3:0]),
	.seg_o(w_dec4_mux9)
);

mux2x1 MUX9
(
	.a(w_dec4_mux9), // 1 
	.b(w_dec3_mux9), // 0 
	.sel(SEL),
	.q	(hex0)
);

//---------------------------------
counter_round CR1
(
	.data(SETUP[3:0]),
	.clk(CLOCK_50),
	.R(R1),
	.E(E4),
	.tc(win),
	.ROUND(ROUND)
);

//---------------------------------

wire clk_025Hz;
wire clk_05Hz;
wire clk_1Hz;
wire clk_2Hz;
wire CLKZ;

FMS_CLOCK fms01
(
	.clk_50MHz(CLOCK_50),
	.reset(R1),
	.clk_025Hz(clk_025Hz), 	// 00
	.clk_05Hz(clk_05Hz),  	// 01
	.clk_1Hz(clk_1Hz),	  	// 10							SERA QUE ISSO TA CERTO, PERGUNTAR PARA O RODRIGO
	.clk_2Hz(clk_2Hz)			// 11
);

MUX4X1 FMS_mux4x1 (
    .level(SETUP[7:6]),
    .CL1(clk_025Hz),
    .CL2(clk_05Hz),
    .CL3(clk_1Hz),
    .CL4(clk_2Hz),
    .CLKHZ(CLKZ)
);

//---------------------------------







endmodule
