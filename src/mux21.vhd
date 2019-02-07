library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux21 is
generic( N : integer);
port(
   A, B : in std_logic_vector(N-1 downto 0);
   COM : in std_logic;
   S : out std_logic_vector(N-1 downto 0)
   );
end mux21;

architecture RTL of mux21 is
  begin
    with COM select S <=
        A when '0',
        B when '1',
        A when others;
end RTL;