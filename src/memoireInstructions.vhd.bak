library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity memoireInstructions is
  port(
  CLK : in std_logic;
  Addr : in std_logic_vector(31 downto 0);
  Instruction : out std_logic_vector(31 downto 0)
  );
end memoireInstructions;

architecture rtl of memoireInstructions is
  type table is array(63 downto 0) of std_logic_vector(31 downto 0);

  function init_mem return table is
    variable result : table;

    begin
      for i in 62 downto 0 loop
        result(i) := (others => '0');
      end loop;

      result(63)(31 downto 2) := (others => '0');
      result(63)(1 downto 0) := "11";

      return result;

    end init_mem;

    signal Instructions : table:=init_mem;
  begin

    Instruction <= Instructions(To_integer(unsigned(Addr(31 down 26))));

  end rtl;
