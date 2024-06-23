/*
controle.v
Ronzani, Maurício Darabas - 07/06/2024


*/

module controle
(
	CLOCK,enter,reset,
	end_FPGA,end_User,end_time,
	win,	match,
	
	R1,R2,E1,E2,E3,E4,SEL
	);

	// Input Port(s)
	input wire CLOCK,enter,reset,end_FPGA,end_User,end_time,win,match;
	output reg R1,R2,E1,E2,E3,E4,SEL;
	
	localparam N_ESTADOS = 3;
	//3 bits 8 estados
	//se mais estados -. mudar para N bits
	localparam [N_ESTADOS-1:0] Init 		= 3'b000, 	//primeiro estado ou e
									  Setup		= 3'b001,	//configuração inicial
									  Play_FPGA = 2,			//Jagada do FPGA
									  Play_User = 3'h3, 		//jogada do usuário
									  Check 		= 3'b100, 	//Verificação de resultado
									  Next_Round= 3'b101,	//Proxima rodada
									  Result		= 3'b110;	//Estado final do resultado
	
	reg [N_ESTADOS-1:0] state, next_state;
	
	
	//Processo sequencial
	//Armazena estado ATUAL	
	always@ (posedge CLOCK) begin
		if(reset)
			state<=Init;
		else
			state<=next_state;
		end
	
	//LOGICA COMBINACIONAL DOS ESTADOS
	always @ (end_FPGA or end_User or end_time or win or match or state) begin
		
		next_state = state;
		case (state) 
			Init: next_state = Setup;
					
			Setup: if(enter == 1'b1) next_state = Play_FPGA;
				
			Play_FPGA: if(end_FPGA == 1'b1) next_state = Play_User;
			
			Play_User: 
			begin 
				if(end_time == 1'b1) next_state = Result;
				else 
				if (end_User == 1'b1) next_state = Check;
			end					
			
			Check:
			begin
				if(match == 1'b1) next_state = Next_Round;
				else next_state = Result;
			end
			
			Next_Round: 
			begin
			if(win == 1'b1) next_state = Result;
			else next_state = Play_FPGA;
			end
			
			Result: next_state = Result; 
		
		endcase	
	end //FIM LOGICA COMBINACIONAL DOS ESTADOS
	
	always @ (state) begin
		R1=1'b0; R2=1'b0; 
		E1=1'b0; E2=1'b0; E3=1'b0; E4=1'b0; 
		SEL=1'b0;
	
		case (state)
			Init: begin
						R1=1'b1; R2=1'b1;				
					end
			Setup: 		E1=1'b1;
			
			Play_FPGA: 	E3=1'b1;
			
			Play_User:	E2=1'b1;
			
			Check:		E4=1'b1;
			
			Next_Round: R2=1'b1;
			
			Result: 		SEL=1'b1;		
		endcase
	end

	


endmodule
