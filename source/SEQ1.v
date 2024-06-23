/* **********************************************
* File Name: SEQ1.v
* Description: 4-bits sequency attribution 
* Author: Pereira, Rodrigo
* Creation Date: 05/07/2024
* Revision: Version 1.0
*
* Input: 4-bits address
* Output: 4-bits registered output_reg
*	
********************************************** */
module SEQ1(
    input [3:0] address,
    output reg [3:0] output_reg
);

always @(address) begin
    case (address)
        4'b0000: output_reg = 4'b0001;
        4'b0001: output_reg = 4'b0100;
        4'b0010: output_reg = 4'b0010;
        4'b0011: output_reg = 4'b1000;
        4'b0100: output_reg = 4'b0001;
        4'b0101: output_reg = 4'b1000;
        4'b0110: output_reg = 4'b0100;
        4'b0111: output_reg = 4'b1000;
        4'b1000: output_reg = 4'b0010;
        4'b1001: output_reg = 4'b1000;
        4'b1010: output_reg = 4'b0001;
        4'b1011: output_reg = 4'b0010;
        4'b1100: output_reg = 4'b1000;
        4'b1101: output_reg = 4'b0001;
        4'b1110: output_reg = 4'b0100;
        4'b1111: output_reg = 4'b0010;
        default: output_reg = 4'b0000;  // Default case to handle unexpected values
    endcase
end

endmodule
