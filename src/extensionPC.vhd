library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Std_logic_arith.all;

entity extensionPC is
port(
    E : in std_logic_vector(23 downto 0);
    S : out std_logic_vector(31 downto 0)
);
end extensionPC;

architecture RTL of extensionPC is

begin
  S <= SXT(E, S'length);

end RTL;
