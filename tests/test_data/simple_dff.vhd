-- Simple D flip-flop in VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity simple_dff is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    d     : in std_logic;
    q     : out std_logic;
    q_n   : out std_logic
  );
end simple_dff;

architecture Behavioral of simple_dff is
  signal q_internal : std_logic;
begin
  process (clk, reset)
  begin
    if reset = '1' then
      q_internal <= '0';
    elsif rising_edge(clk) then
      q_internal <= d;
    end if;
  end process;

  q   <= q_internal;
  q_n <= not q_internal;

end Behavioral;
