library verilog;
use verilog.vl_types.all;
entity LOGICA is
    port(
        REG_SetupLEVEL  : in     vl_logic_vector(1 downto 0);
        ROUND           : in     vl_logic_vector(3 downto 0);
        REG_SetupMAPA   : in     vl_logic_vector(1 downto 0);
        POINTS          : out    vl_logic_vector(7 downto 0)
    );
end LOGICA;
