library verilog;
use verilog.vl_types.all;
entity REG_FPGA is
    port(
        CLK             : in     vl_logic;
        R               : in     vl_logic;
        E               : in     vl_logic;
        data            : in     vl_logic_vector(63 downto 0);
        q               : out    vl_logic_vector(63 downto 4);
        q3              : out    vl_logic_vector(3 downto 0)
    );
end REG_FPGA;
