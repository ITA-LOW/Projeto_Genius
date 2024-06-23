library verilog;
use verilog.vl_types.all;
entity MUX4x1_4bits is
    port(
        SEL             : in     vl_logic_vector(1 downto 0);
        ENT0            : in     vl_logic_vector(3 downto 0);
        ENT1            : in     vl_logic_vector(3 downto 0);
        ENT2            : in     vl_logic_vector(3 downto 0);
        ENT3            : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end MUX4x1_4bits;
