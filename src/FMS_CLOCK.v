
// FMS_CLOCK	

module FMS_CLOCK (
    input wire clk_50MHz,   // Sinal de clock de 50 MHz
    input wire reset,       // Sinal de reset
    output reg clk_025Hz,   // Sinal de clock de 0.25 Hz
    output reg clk_05Hz,    // Sinal de clock de 0.5 Hz
    output reg clk_1Hz,     // Sinal de clock de 1 Hz
    output reg clk_2Hz      // Sinal de clock de 2 Hz
);

reg [27:0] c025; // Contador para 0.25 Hz (28 bits) 199_999_999 = 2^28 e assim por diante
reg [26:0] c05;  // Contador para 0.5 Hz (27 bits)
reg [25:0] c1;   // Contador para 1 Hz (26 bits)
reg [24:0] c2;   // Contador para 2 Hz (25 bits)


localparam C025_MAX = 199_999_999; // dando nome a constantes como na aula de microcontroladores
localparam C05_MAX = 99_999_999;
localparam C1_MAX = 49_999_999;
localparam C2_MAX = 24_999_999;

always @(posedge clk_50MHz or posedge reset) begin
    if (reset) begin
        // Resetando contadores e clocks
        c025 <= 0;
        c05 <= 0;
        c1 <= 0;
        c2 <= 0;
        clk_025Hz <= 0;
        clk_05Hz <= 0;
        clk_1Hz <= 0;
        clk_2Hz <= 0;
    end else begin
        // Contador para 0.25 Hz - toda vez que contar ate 199_199_999 vai subir o sinal, quando contar de novo vai descer e assim vai produzir um sinal de 0,25Hz
        if (c025 == C025_MAX) begin
            c025 <= 0;
            clk_025Hz <= ~clk_025Hz; 
        end else begin
            c025 <= c025 + 1; // incrementa o contador
        end

        // Contador para 0.5 Hz
        if (c05 == C05_MAX) begin
            c05 <= 0;
            clk_05Hz <= ~clk_05Hz; 
        end else begin
            c05 <= c05 + 1;
        end

        // Contador para 1 Hz
        if (c1 == C1_MAX) begin
            c1 <= 0;
            clk_1Hz <= ~clk_1Hz;
        end else begin
            c1 <= c1 + 1;
        end

        // Contador para 2 Hz
        if (c2 == C2_MAX) begin
            c2 <= 0;
            clk_2Hz <= ~clk_2Hz;
        end else begin
            c2 <= c2 + 1;
        end 
    end
end

endmodule
