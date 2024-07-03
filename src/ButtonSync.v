module buttonSync (
    input wire clk,
    input wire key, // ativo baixo
    output reg btn // ativo alto
);

    // Estados da FSM
    parameter EsperaApertar = 2'b00;
    parameter SaidaAtiva = 2'b01;
    parameter EsperaSoltar = 2'b10;

    reg [1:0] current_state, next_state;

    // FSM: transição de estado e saída
    always @(posedge clk) begin
        current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            EsperaApertar: begin
                if (key == 1'b0) 
                    next_state = SaidaAtiva;
                else 
                    next_state = EsperaApertar;
                btn = 1'b0; // ativo baixo
            end
            SaidaAtiva: begin
                if (key == 1'b0) 
                    next_state = EsperaSoltar;
                else 
                    next_state = EsperaApertar;
                btn = 1'b1; // ativo alto
            end
            EsperaSoltar: begin
                if (key == 1'b0) 
                    next_state = EsperaSoltar;
                else 
                    next_state = EsperaApertar;
                btn = 1'b0; // ativo baixo
            end
            default: begin
                next_state = EsperaApertar;
                btn = 1'b0; // ativo baixo
            end
        endcase
    end
endmodule
