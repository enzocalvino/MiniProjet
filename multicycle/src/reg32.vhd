library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32 is 
    port(
        CLK, RST: in std_logic;
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
        );
    end entity;
        
        
architecture rtl of reg32 is
  
  begin
    
    process(CLK, RST)
      
      begin
        
        if RST = '1' then
          
          DataOut <= (others => '0');
          
        elsif rising_edge(CLK) then

            DataOut <= DataIn;

        end if;
		  
       end process;
        
    end rtl;
      