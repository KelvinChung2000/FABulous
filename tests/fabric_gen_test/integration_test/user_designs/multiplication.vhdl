library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity multiplication is
  port (
    mult_a  : in    std_logic_vector(2 downto 0);
    mult_b  : in    std_logic_vector(2 downto 0);
    product : out   std_logic_vector(5 downto 0)
  );
end entity multiplication;

architecture rtl of multiplication is

begin

  product <= std_logic_vector(unsigned(mult_a) * unsigned(mult_b));

end architecture rtl;
