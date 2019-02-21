library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32bit is 
    port(
        CLK, RST, WE : in std_logic;
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
        );
    end entity;
        
        
architecture rtl of reg32bit is
  
  begin
   
    
    process(CLK, RST)
      
      begin
        
        if RST = '1' then
          
          DataOut <= (others => '0');
          
        elsif rising_edge(CLK) then
          
          if WE = '1' then
            DataOut <= DataIn;
          end if;
        end if;
        end process;
        
      end rtl;
      