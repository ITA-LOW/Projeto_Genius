library verilog;
use verilog.vl_types.all;
entity counter_round is
    port(
        data            : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        R               : in     vl_logic;
        E               : in     vl_logic;
        tc              : out    vl_logic;
        ROUND           : out    vl_logic_vector(3 downto 0)
    );
end counter_round;
