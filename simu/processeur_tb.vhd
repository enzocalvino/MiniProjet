library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity processeur_tb is
end processeur_tb;

architecture tb of processeur_tb is
Signal CLK,RST : std_logic;
Signal offset :  std_logic_vector(23 downto 0);
Signal Imm :  std_logic_vector(7 downto 0);
Signal RN, RD, RM :  std_logic_vector(3 downto 0);
Signal S : std_logic_vector(31 downto 0);

begin
    
    clock : process
    begin
      CLK <= '0';
      wait for 5 ns;
      CLK <= '1';
      wait for 5 ns;
    end process clock;
    
    
    testbench: process
    begin
    RST <= '1';
    
    wait for 5 ns;
    
    RST <= '0';
    offset <= (others => '0');
    
    wait for 50 ns;
    
    wait;  
    end process;
    
    Proc_TB : entity work.processeur port map(CLK => CLK, RST => RST, offset => offset, 
                                Imm => Imm, RN => RN, RD => RD, RM => RM, S => S);
                                
end tb;