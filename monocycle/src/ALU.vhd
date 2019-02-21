library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
  port(
    OP : in std_logic_vector(1 downto 0);
    A, B : in std_logic_vector(31 downto 0);
    S : out std_logic_vector(31 downto 0);
    N : out std_logic
);
end ALU;


architecture behav of ALU is
Signal Y : std_logic_vector(31 downto 0);
begin 
  S <= Y;
  N <= Y(31);
  process(OP, A, B)
    begin
      if OP = "00" then
        Y <= std_logic_vector(signed(A) + signed(B));
      elsif OP = "01" then
        Y <= B after 1 ns;
      elsif OP = "10" then
        Y <= std_logic_vector(signed(A) - signed(B));
      elsif OP = "11" then
        Y <= A after 1 ns;
      end if;
    end process;
  end behav;
  
      
      
      
      