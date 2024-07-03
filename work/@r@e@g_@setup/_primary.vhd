library verilog;
use verilog.vl_types.all;
entity REG_Setup is
    port(
        CLK             : in     vl_logic;
        R               : in     vl_logic;
        E               : in     vl_logic;
        SW              : in     vl_logic_vector(7 downto 0);
        setup           : out    vl_logic_vector(7 downto 0)
    );
end REG_Setup;
