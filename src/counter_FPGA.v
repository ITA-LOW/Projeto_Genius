module counter_FPGA (
    input wire clk,
    input wire R,
    input wire E,
    input wire [3:0] data,
    output reg tc,
    output reg [3:0] SEQFPGA
);

    reg [3:0] total;

    always @(posedge clk or posedge R) begin
        if (R) begin
            total <= 4'b0000;
            tc <= 1'b0;
        end else if (E) begin
            total <= total + 4'b0001;
            if (total == data) begin
                tc <= 1'b1;
            end else begin
                tc <= 1'b0;
            end
        end
    end

    always @(total) begin
        SEQFPGA <= total;
    end

endmodule
