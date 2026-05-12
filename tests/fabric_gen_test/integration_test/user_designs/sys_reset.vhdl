-- See counter.vhdl for the Global_Clock blackbox idiom.

library ieee;
  use ieee.std_logic_1164.all;

entity sys_reset is
  port (
    rst : in    std_logic;
    a   : in    std_logic_vector(3 downto 0);
    b   : out   std_logic_vector(3 downto 0)
  );
end entity sys_reset;

architecture rtl of sys_reset is

  component Global_Clock is
    port (
      CLK : out   std_logic
    );
  end component Global_Clock;

  signal clk  : std_logic;
  signal data : std_logic_vector(3 downto 0);

begin

  clk_inst : component Global_Clock
    port map (
      CLK => clk
    );

  process (clk) is
  begin

    if rising_edge(clk) then
      if (rst = '1') then
        data <= x"7";
      else
        data <= a;
      end if;
    end if;

  end process;

  b <= data;

end architecture rtl;
