library verilog;
use verilog.vl_types.all;
entity controle is
    port(
        CLOCK           : in     vl_logic;
        enter           : in     vl_logic;
        reset           : in     vl_logic;
        end_FPGA        : in     vl_logic;
        end_User        : in     vl_logic;
        end_time        : in     vl_logic;
        win             : in     vl_logic;
        match           : in     vl_logic;
        R1              : out    vl_logic;
        R2              : out    vl_logic;
        E1              : out    vl_logic;
        E2              : out    vl_logic;
        E3              : out    vl_logic;
        E4              : out    vl_logic;
        SEL             : out    vl_logic
    );
end controle;
