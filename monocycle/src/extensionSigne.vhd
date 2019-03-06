library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;


entity extensionSigne is
generic( N : integer := 8);
port(
    E : in std_logic_vector(N-1 downto 0);
    S : out std_logic_vector(31 downto 0)
);
end extensionSigne;

architecture RTL of extensionSigne is

begin
  S <= SXT(E, S'length);
		
end RTL;