module mux2x1
(
	a,
	b,
	sel,
	q
);
	input [6:0]a, b;
	input sel;
	output reg [6:0] q;
	
	
	always @(a or b or sel)
	begin
		if (sel==1'b1)
			q <= a;
		else
			q <= b;
	
	end
	
	   

endmodule 