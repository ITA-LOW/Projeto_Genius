/*
	Topo_tb.v
	Ronzani, Maurício Darabas
	
	DescriÃ§ao: Arquivo Topo.v arquivo principal
	
	Revisão:
	
	*/
	
`timescale 1ns/100ps;
	
module Topo_tb;
	  
	reg r_CLOCK_50;
	reg[3:0] r_KEY;
	reg[9:0] r_SW;
	
	Topo U0_TB
	(
		.CLOCK_50(r_CLOCK_50), .KEY(r_KEY),	.SW(r_SW),
		
		.LEDR(),
		.HEX0(),	.HEX1(),	.HEX2(),	.HEX3(),	.HEX4(),	.HEX5()		
	);
	
	initial r_CLOCK_50=0;
	
	always #10 r_CLOCK_50=~r_CLOCK_50;
	
	initial begin
	   r_SW[1]=1;
	   #30;
	   r_SW[1]=0;
	   #2000;
	   $stop;
	end
	

endmodule
