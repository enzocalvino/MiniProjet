library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity banc is 
port(
        CLK,RST : in std_logic;
        W : in std_logic_vector(31 downto 0);
        RA : in std_logic_vector(3 downto 0);
        RB : in std_logic_vector(3 downto 0);
        RW : in std_logic_vector(3 downto 0);
        WE : in std_logic;
        A : out std_logic_vector(31 downto 0);
        B : out std_logic_vector(31 downto 0)
);
end banc;

architecture RTL of banc is
  type table is array(15 downto 0) of std_logic_vector(31 downto 0);
  
  function init_banc return table is
    variable result : table;
    
    begin
      for i in 14 downto 0 loop
        result(i) := (others => '0');
      end loop;
      
      result(15) := X"00000030";
      return result;
      
    end init_banc;
    
    
    signal Banc: table :=init_banc;
    
  begin
    A <= Banc(TO_INTEGER(unsigned(RA)));
    B <= Banc(TO_INTEGER(unsigned(RB)));
    
    process(CLK, RST)
      begin
        
        if RST = '1' then
          for i in 15 downto 0 loop
            Banc(i) <= (others => '0');
          end loop;
      elsif rising_edge(CLK) then
          if WE = '1' then
            Banc(TO_INTEGER(unsigned(RW))) <= W;
          end if;
        end if;
    end process;
    
  end RTL;