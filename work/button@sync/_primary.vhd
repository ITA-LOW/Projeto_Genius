library verilog;
use verilog.vl_types.all;
entity buttonSync is
    generic(
        EsperaApertar   : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        SaidaAtiva      : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        EsperaSoltar    : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        key             : in     vl_logic;
        btn             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of EsperaApertar : constant is 1;
    attribute mti_svvh_generic_type of SaidaAtiva : constant is 1;
    attribute mti_svvh_generic_type of EsperaSoltar : constant is 1;
end buttonSync;
