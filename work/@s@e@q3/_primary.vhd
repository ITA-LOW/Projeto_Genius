library verilog;
use verilog.vl_types.all;
entity SEQ3 is
    port(
        address         : in     vl_logic_vector(3 downto 0);
        output_reg      : out    vl_logic_vector(3 downto 0)
    );
end SEQ3;
