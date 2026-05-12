-- SPDX-FileCopyrightText: © 2026 FABulous Contributors
-- SPDX-License-Identifier: Apache-2.0

library ieee;
  use ieee.std_logic_1164.all;

entity passthrough is
  port (
    a : in    std_logic_vector(3 downto 0);
    b : out   std_logic_vector(3 downto 0)
  );
end entity passthrough;

architecture rtl of passthrough is

begin

  b <= a;

end architecture rtl;
