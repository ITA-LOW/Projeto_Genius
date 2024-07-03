module REG_FPGA (
    input wire CLK,       // Sinal de clock
    input wire R,         // Sinal de reset
    input wire E,         // Sinal de habilitação
    input wire [63:0] data,  // Entrada de dados de 64 bits
    output reg [63:4] q,  // Saída que guarda a sequência completa de 64 bits
    output reg [3:0] q3   // Saída que guarda os 4 bits menos significativos da sequência
);

    always @(posedge CLK or posedge R) begin
        if (R) begin
            // Reinicia o registrador para zero quando R está ativo
            q <= 60'b0;
            q3 <= 4'b0;
        end else if (E) begin
            // Atualiza q com os dados de entrada quando E está ativo
            q <= data[63:4];
            q3 <= data[3:0];
        end
        // Caso contrário, mantém os valores atuais de q e q3
    end

endmodule
