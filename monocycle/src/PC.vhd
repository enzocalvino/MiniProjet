library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;


entity PC is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    nPCsel : in std_logic;
    offset : in std_logic_vector(31 downto 0);
    PC : out std_logic_vector(31 downto 0)
  );
end PC;

architecture RTL of PC is

  Signal PC_i : std_logic_vector(31 downto 0);
  begin

    PC <= PC_i;

  process(CLK, RST)
    begin

      if RST = '1' then
        PC_i <= (others => '0');

      elsif rising_edge(CLK) then

          if nPCsel = '1' then
            PC_i <= std_logic_vector(unsigned(PC_i) + 1 + unsigned(offset));

          elsif nPCsel = '0' then
            PC_i <= std_logic_vector(unsigned(PC_i) + 1);

          end if;

      end if;
  end process;
  end RTL;
