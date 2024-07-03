library verilog;
use verilog.vl_types.all;
entity MUX2x1_7bits is
    port(
        SEL             : in     vl_logic;
        ENT0            : in     vl_logic_vector(6 downto 0);
        ENT1            : in     vl_logic_vector(6 downto 0);
        \out\           : out    vl_logic_vector(6 downto 0)
    );
end MUX2x1_7bits;
