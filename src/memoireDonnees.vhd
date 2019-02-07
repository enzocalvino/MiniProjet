library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity memoireDonnees is
port(
	CLK : in std_logic;
	Addr : in std_logic_vector(5 downto 0);
	WrEn : in std_logic;
	DataIn : in std_logic_vector(31 downto 0);
	DataOut : out std_logic_vector(31 downto 0));
	
end memoireDonnees;

architecture RTL of memoireDonnees is
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
    
    
    signal Memoire: table :=init_mem;
    begin
    	
    DataOut <= Memoire(To_integer(unsigned(Addr)));
    
    writing: process(CLK)
    begin
      
      if WrEn = '1' then
        
        if rising_edge(CLK) then
          
          Memoire(To_integer(unsigned(Addr))) <= DataIn;
          
        end if;
        
      end if;
      
    end process;
    
  end RTL;
  
  