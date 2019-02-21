library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux41 is
generic( N : integer);
port(
   A, B, C, D : in std_logic_vector(N-1 downto 0);
   COM : in std_logic_vector(1 downto 0);
   S : out std_logic_vector(N-1 downto 0)
   );
end mux41;

architecture RTL of mux41 is
  begin
    with COM select S <=
        A when "00",
        B when "01",
		  C when "10",
		  D when "11",
       (others => '0') when others;
end RTL;