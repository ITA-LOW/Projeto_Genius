library verilog;
use verilog.vl_types.all;
entity MUX4X1 is
    port(
        level           : in     vl_logic_vector(1 downto 0);
        CL1             : in     vl_logic;
        CL2             : in     vl_logic;
        CL3             : in     vl_logic;
        CL4             : in     vl_logic;
        CLKHZ           : out    vl_logic
    );
end MUX4X1;
