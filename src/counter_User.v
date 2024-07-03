module counter_User (
    input wire clk,
    input wire R,
    input wire E,
    input wire [3:0] data,
    output reg tc
);

    reg [3:0] cnt;

    always @(posedge clk or posedge R) begin
        if (R) begin
            cnt <= 4'b0000;
            tc <= 0;
        end else if (E) begin
            cnt <= cnt + 4'b0001;
            if (cnt == data) begin
                tc <= 1;
            end else begin
                tc <= 0;
            end
        end
    end

endmodule

	
	
	
	