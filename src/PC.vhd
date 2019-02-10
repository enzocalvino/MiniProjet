library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Std_logic_arith.all;
use IEEE.numeric_std.all;


entity PC is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    nPCsel : in std_logic;
    PCin : in std_logic_vector(31 downto 0);
    PCout : out std_logic_vector(31 downto 0)
  );
end PC;

architecture RTL of PC is
  Signal offset : unsigned(11 downto 0);
  begin
  offset <= unsigned(PCin(11 downto 0));
  process(CLK, RST)
    begin
      if RST = '1' then
        PCout <= (others => '0');
      elsif rising_edge(CLK) then
        if nPCsel = '1' then
          PCout <= std_logic_vector(unsigned(PCin) + 1 + offset);
        elsif nPCsel = '0' then
          PCout <= std_logic_vector(unsigned(PCin) + 1);
        end if;
      end if;
  end process;
  end RTL;
