-- VHDL mirror of counter.v.
-- The Global_Clock instance lands the clock on the demo fabric's global
-- clock network (the same wire fed by the eFPGA's top-level UserCLK). We
-- declare Global_Clock as a *component* with no backing entity body; the
-- GHDL Yosys plugin treats unbound component instantiations as blackboxes
-- and synth_fabulous then tech-maps the instance to the dedicated clock
-- bel. See ghdl-yosys-plugin/testsuite/examples/blackbox/blackbox1.vhdl.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (
    rst : in  std_logic;
    ena : in  std_logic;
    d   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of counter is
  component Global_Clock is
    port (CLK : out std_logic);
  end component;

  signal clk : std_logic;
  signal ctr : unsigned(7 downto 0);
begin
  clk_inst : Global_Clock port map (CLK => clk);

  process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        ctr <= (others => '0');
      elsif ena = '1' then
        ctr <= ctr + 1;
      end if;
    end if;
  end process;

  d <= std_logic_vector(ctr);
end architecture;
