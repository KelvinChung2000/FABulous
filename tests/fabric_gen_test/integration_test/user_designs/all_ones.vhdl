-- VHDL mirror of all_ones.v.
-- `all` is a VHDL reserved word; the extended identifier `\all\` carries the
-- same name into the synthesized netlist so the shared constraints.pcf
-- entries `set_io all[N] …` still bind.

library ieee;
use ieee.std_logic_1164.all;

entity all_ones is
  port (
    \all\ : out std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of all_ones is
begin
  \all\ <= (others => '1');
end architecture;
