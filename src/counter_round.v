/*
	counter_round.v
	Ronzani, MaurÃ­cio Darabas
	
	DescriÃ§ao: Arquivo counter_round.v 
	
	RevisÃ£o:
	
	*/
	 
	module counter_round (
    input wire [3:0] data, 
    input wire clk,       
    input wire R,         
    input wire E,         
    output reg tc,        
    output reg [3:0] ROUND 
);

reg [3:0] total; 
always @(posedge clk or posedge R) begin
    if (R) begin
        total <= 4'b0000; 
        tc <= 1'b0;       
    end else if (E) begin
        total <= total + 1'b1; 
        if (total == data) begin
            tc <= 1'b1; 
        end
    end
    ROUND <= total; 
end

endmodule
	
	
	
	