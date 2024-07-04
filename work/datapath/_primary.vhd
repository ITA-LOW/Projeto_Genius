library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(3 downto 0);
        SWITCH          : in     vl_logic_vector(7 downto 0);
        R1              : in     vl_logic;
        R2              : in     vl_logic;
        E1              : in     vl_logic;
        E2              : in     vl_logic;
        E3              : in     vl_logic;
        E4              : in     vl_logic;
        SEL             : in     vl_logic;
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0);
        leds            : out    vl_logic_vector(3 downto 0);
        ledr            : out    vl_logic_vector(3 downto 0);
        end_FPGA        : out    vl_logic;
        end_User        : out    vl_logic;
        end_time        : out    vl_logic;
        win             : out    vl_logic;
        match           : out    vl_logic
    );
end datapath;
