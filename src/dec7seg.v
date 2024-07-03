module dec7seg
(
bcd_i,
seg_o
);


localparam BCD_SIZE = 4;
localparam SEG_SIZE = 7;

input wire [BCD_SIZE - 1:0] bcd_i;
output reg [SEG_SIZE - 1:0] seg_o;


always @(bcd_i) begin

	case (bcd_i)
		4'h0 : seg_o = ~7'b011_1111;
		4'h1 : seg_o = ~7'b000_0110;
		4'h2 : seg_o = ~7'b110_1101;
		4'h3 : seg_o = ~7'b111_1001;
		4'h4 : seg_o = ~7'b011_0011;
		4'h5 : seg_o = ~7'b110_1101;
		4'h6 : seg_o = ~7'b111_1101;
		4'h7 : seg_o = ~7'b000_0111;
		4'h8 : seg_o = ~7'b111_1111;
		4'h9 : seg_o = ~7'b111_1011;
		4'hA : seg_o = ~7'b111_0111;
		4'hB : seg_o = ~7'b001_1111;
		4'hC : seg_o = ~7'b100_1110;
		4'hD : seg_o = ~7'b011_1101;
		4'hE : seg_o = ~7'b100_1111;
		4'hF : seg_o = ~7'b100_0111;


	endcase	
	
	end


endmodule 