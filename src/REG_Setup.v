module REG_Setup (
    input wire CLK,       // Sinal de clock
    input wire R,         // Sinal de reset
    input wire E,         // Sinal de habilitação
    input wire [7:0] SW,  // Entrada dos switches (8 bits)
    output reg [7:0] setup // Saída do registrador de 2 bits
);

    always @(posedge CLK or posedge R) begin
        if (R) begin
            // Reinicia o registrador para zero quando R está ativo
            setup <= 2'b00;
        end else if (E) begin
            // Armazena o valor dos switches em setup quando E está ativo
            setup <= SW[1:0];
        end
        // Caso contrário, mantém o valor atual de setup
    end

endmodule
