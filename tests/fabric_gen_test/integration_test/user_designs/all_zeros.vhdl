-- VHDL mirror of all_zeros.v.
-- See all_ones.vhdl for the `\all\` extended-identifier rationale.

library ieee;
use ieee.std_logic_1164.all;

entity all_zeros is
  port (
    \all\ : out std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of all_zeros is
begin
  \all\ <= (others => '0');
end architecture;
