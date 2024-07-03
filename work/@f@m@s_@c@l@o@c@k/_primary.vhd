library verilog;
use verilog.vl_types.all;
entity FMS_CLOCK is
    port(
        clk_50MHz       : in     vl_logic;
        reset           : in     vl_logic;
        clk_025Hz       : out    vl_logic;
        clk_05Hz        : out    vl_logic;
        clk_1Hz         : out    vl_logic;
        clk_2Hz         : out    vl_logic
    );
end FMS_CLOCK;
