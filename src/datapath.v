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
	ledr,
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
	output wire [P_LEDS-1:0]ledr;
	output wire end_FPGA;
	output wire end_User;
	output wire end_time;
	output wire win;
	output wire match;
	
	assign ledr = OUT_FPGA[63:60];
	assign leds = ~KEY[3:0];
	//assign leds = 0;
	 
	
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
	.R(R1),														//PERGUNTAR PARA O RODDRIGO
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
	.clk_1Hz(clk_1Hz),	  	// 10							PERGUNTAR PARA O RODRIGO
	.clk_2Hz(clk_2Hz)			// 11
);

MUX4X1 MUX10 (
    .level(SETUP[7:6]),
    .CL1(clk_025Hz),
    .CL2(clk_05Hz),
    .CL3(clk_1Hz),
    .CL4(clk_2Hz),
    .CLKHZ(CLKZ)
);

//---------------------------------

wire [3:0]w_SEQFPGA;
counter_FPGA counter_fpga1 (
	.data(ROUND[3:0]),
	.clk(CLKHZ),
	.R(R2),
	.E(E3),
	.tc(end_FPGA),
	.SEQFPGA(w_SEQFPGA[3:0])
);


wire w_seq0_mux;
SEQ0 seq0 (
	.address(w_SEQFPGA[3:0]),           // PERGUNTAR PARA O RODRIGO
   .output_reg(w_seq0_mux)
);

wire w_seq1_mux;
SEQ1 seq1 (
	.address(w_SEQFPGA[3:0]),
   .output_reg(w_seq1_mux)
);

wire w_seq2_mux;
SEQ2 seq2 (
	.address(w_SEQFPGA[3:0]),
   .output_reg(w_seq2_mux)
);

wire w_seq3_mux;
SEQ3 seq3 (
	.address(w_SEQFPGA[3:0]),
   .output_reg(w_seq3_mux)
);

wire SEQ_FPGA;
MUX4X1 MUX11 (
	 .level(SETUP[5:4]),
    .CL1(w_seq0_mux),
    .CL2(w_seq1_mux),
    .CL3(w_seq2_mux),
    .CL4(w_seq3_mux),
    .CLKHZ(SEQ_FPGA)
);

//---------------------------------------

// Instanciação de buttonSync para cada botão
    wire btn0, btn1, btn2, btn3;

    buttonSync sync0 (.clk(CLOCK_50), .key(~KEY[0]), .btn(btn0));
    buttonSync sync1 (.clk(CLOCK_50), .key(~KEY[1]), .btn(btn1));
    buttonSync sync2 (.clk(CLOCK_50), .key(~KEY[2]), .btn(btn2));
    buttonSync sync3 (.clk(CLOCK_50), .key(~KEY[3]), .btn(btn3));

    // Lógica OR combinacional para os sinais sincronizados dos botões
    wire or_output;
    assign or_output = btn0 | btn1 | btn2 | btn3;

    // Lógica AND com E2
    wire counter_enable;
    assign counter_enable = or_output & E2;

    // Instanciação do módulo Counter_User
    counter_User counter_user01 (
        .clk(CLOCK_50),
        .R(R2),
        .E(counter_enable),
        .data(ROUND),
        .tc(end_User)
    );

//------------------------------------------
// Instância do módulo LOGICA
    LOGICA logica_inst (
        .REG_SetupLEVEL(SETUP[7:6]),  // Conecta os 2 bits mais ALTOS de SETUP a REG_SetupLEVEL
        .ROUND(ROUND),                // Conecta ROUND diretamente
        .REG_SetupMAPA(SETUP[5:4]),  // Conecta os 2 bits mais BAIXOS de SETUP a REG_SetupMAPA
        .POINTS(POINTS)               // Conecta POINTS à saída do módulo LOGICA
    );

//------------------------------------------------------------------------------------------------

// Instância do módulo REG_Setup
    REG_Setup reg_setup_inst (
        .CLK(CLOCK_50),               // Conecta o clock ao módulo REG_Setup
        .R(R1),                      // Conecta o sinal de reset R1 ao módulo REG_Setup
        .E(E1),                      // Conecta o sinal de habilitação E1 ao módulo REG_Setup
        .SW(SWITCH),                 // Conecta os switches ao módulo REG_Setup
        .setup(SETUP)       			// Conecta REG_SetupLEVEL à saída do módulo REG_Setup
    );

//------------------------------------------------------------------------------------------------

// Instância do módulo REG_FPGA
	 wire [63:4] q_output_regfpga;
    wire [3:0] q3_output_regfpga;
	 wire [63:0] OUT_FPGA;
    wire [63:0] and_output_regfpga;
	 assign and_output_regfpga = {SEQ_FPGA, q_output_regfpga};
	 assign OUT_FPGA = {q_output_regfpga, q3_output_regfpga};
	 
    REG_FPGA reg_fpga_inst (
        .CLK(CLKHZ),
        .R(R2),
        .E(E3),
        .data(and_output_regfpga),    // Conectar a entrada de dados desejada aqui
        .q(q_output_regfpga),         // Conectar a saída q do REG_FPGA
        .q3(q3_output_regfpga)        // Conectar a saída q3 do REG_FPGA
    );

//------------------------------------------------------------------------------------------------

// Instância do módulo REG_User
	 wire [3:0] NBTN;
	 wire [63:4] q_output_reguser;
    wire [3:0] q3_output_reguser;
	 wire [63:0] OUT_User;
	 wire [63:0] and_NBTN_q_output;
	 assign NBTN = {btn3, btn2, btn1, btn0};
	 assign and_NBTN_q_output = {NBTN, q_output_reguser};
	 assign OUT_User = {q_output_reguser, q3_output_reguser};
	 
    REG_USER reg_user_inst (
        .CLK(CLOCK_50),
        .R(R2),
        .E(counter_enable),
        .data(and_NBTN_q_output),    // Conectar a entrada de dados desejada aqui
        .q(q_output_reguser),         // Conectar a saída q do REG_FPGA
        .q3(q3_output_reguser)        // Conectar a saída q3 do REG_FPGA
    );

//------------------------------------------------------------------------------------------------



endmodule
