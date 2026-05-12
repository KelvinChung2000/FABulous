-- VHDL mirror of addition.v.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addition is
  port (
    a : in  std_logic_vector(3 downto 0);
    b : in  std_logic_vector(3 downto 0);
    c : out std_logic_vector(4 downto 0)
  );
end entity;

architecture rtl of addition is
begin
  c <= std_logic_vector(resize(unsigned(a), 5) + resize(unsigned(b), 5));
end architecture;
