-- Banc de Test pour l'ALU

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity ALU_TB is
port( OK: out BOOLEAN := TRUE);
end entity;

architecture TB of ALU_TB is

  
  signal OP_i : Std_logic_vector(1 downto 0);
  signal A_i, B_i: Std_logic_vector(31 downto 0);
  signal S_i : Std_logic_vector(31 downto 0);
  signal N_i : Std_logic;

begin
  
  process
  begin
  
    OP_i <= "00";
    A_i <= "00000000000000000000000000000001";
    B_i <= "00000000000000000000000000000001";
    
    wait for 5 ns;
    
    OK <= (S_i = "00000000000000000000000000000010")
    
    OK <= (N_i = '0');
    
    wait for 5 ns;
    
    OP_i <= "01";
    A_i <= "00000000000000000000000000000010";
    B_i <= "00000000000000000000000000000001";
    
    wait for 5 ns;
    
    OK <= (S_i = "00000000000000000000000000000001");
    

    
    OK <= (N_i = '0');
    
    wait for 5 ns;
    
    OP_i <= "10";
    A_i <= "00000000000000000000000000000001";
    B_i <= "00000000000000000000000000000010";
    
    wait for 5 ns;
    
    OK <= (S_i = "11111111111111111111111111111111");

    
    OK <= (N_i = '1');
    
    wait for 5 ns;
    
    OP_i <= "11";
    A_i <= "00000000000000000000000000000010";
    B_i <= "00000000000000000000000000000001";
    
    wait for 5 ns;
    
    OK <= (S_i = "00000000000000000000000000000010");
  
    
    OK <= (N_i = '0');
    
    wait;
  end process;
  
  UUT: entity work.ALU(behav) port map(OP => OP_i, A => A_i, B => B_i, S => S_i, N => N_i);
  end architecture TB;