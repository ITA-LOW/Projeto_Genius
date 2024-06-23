/*
	counter_time.v
	Ronzani, Maurício Darabas
	
	Descriçao: Arquivo counter_time.v 
	
	Revisão:
	
	*/
	
	module counter_time
	(
	CLKT,R,E,
	TEMPO,end_time
	);
	
	input wire CLKT,R,E;
	output reg [3:0] TEMPO;
	output wire end_time;
	
	reg r_end_time;
	
	always @(posedge CLKT or posedge R)
	begin
		if(R==1'b1) begin
			TEMPO = 4'h0;
			r_end_time = 1'b0;
		end
		else begin
			if(E==1'b1) begin
				TEMPO = TEMPO + 1'b1;
				r_end_time = 1'b0;
				if(TEMPO==4'b1001) begin
					TEMPO  = 1'b0;
					r_end_time = 1'b1;
				end
			end		
		end
	end
	
	assign end_time = r_end_time;
	
	endmodule