-- VHDL mirror of passthrough.v.
-- 4-bit width chosen to match the overlapping signal placements in the
-- shared constraints.pcf.

library ieee;
use ieee.std_logic_1164.all;

entity passthrough is
  port (
    a : in  std_logic_vector(3 downto 0);
    b : out std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of passthrough is
begin
  b <= a;
end architecture;
