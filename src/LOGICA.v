module LOGICA (
    input wire [1:0] REG_SetupLEVEL, // Nível do jogo (1, 2, 3 ou 4)
    input wire [3:0] ROUND,          // Número de sequências acertadas (0 a 15)
    input wire [1:0] REG_SetupMAPA,  // Sinal adicional (não utilizado na descrição funcional)
    output reg [7:0] POINTS         // Pontuação final (8 bits)
);

    always @* begin
        // Multiplicação do nível pelo número de sequências acertadas
        POINTS = REG_SetupLEVEL * ROUND;
    end

endmodule
