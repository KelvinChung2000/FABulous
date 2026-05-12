-- SPDX-FileCopyrightText: © 2026 FABulous Contributors
-- SPDX-License-Identifier: Apache-2.0

-- Global_Clock is declared as an unbound component so the GHDL Yosys plugin
-- imports it as a blackbox and synth_fabulous tech-maps the instance to the
-- dedicated clock bel.

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity counter is
  port (
    rst : in    std_logic;
    ena : in    std_logic;
    d   : out   std_logic_vector(7 downto 0)
  );
end entity counter;

architecture rtl of counter is

  component Global_Clock is
    port (
      CLK : out   std_logic
    );
  end component Global_Clock;

  signal clk : std_logic;
  signal ctr : unsigned(7 downto 0);

begin

  clk_inst : component Global_Clock
    port map (
      CLK => clk
    );

  process (clk) is
  begin

    if rising_edge(clk) then
      if (rst = '1') then
        ctr <= (others => '0');
      elsif (ena = '1') then
        ctr <= ctr + 1;
      end if;
    end if;

  end process;

  d <= std_logic_vector(ctr);

end architecture rtl;
