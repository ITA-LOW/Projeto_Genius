library verilog;
use verilog.vl_types.all;
entity counter_User is
    port(
        clk             : in     vl_logic;
        R               : in     vl_logic;
        E               : in     vl_logic;
        data            : in     vl_logic_vector(3 downto 0);
        tc              : out    vl_logic
    );
end counter_User;
