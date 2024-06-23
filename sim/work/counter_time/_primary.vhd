library verilog;
use verilog.vl_types.all;
entity counter_time is
    port(
        CLKT            : in     vl_logic;
        R               : in     vl_logic;
        E               : in     vl_logic;
        TEMPO           : out    vl_logic_vector(3 downto 0);
        end_time        : out    vl_logic
    );
end counter_time;
