library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity unite_trait is 
port(
        CLK,RST : in std_logic;
        WE: in std_logic;
        RegSel : in std_logic;
        OP: in std_logic_vector(1 downto 0);
        RN, RD, RM : in std_logic_vector(3 downto 0);
        N : out std_logic;
        S : out std_logic_vector(31 downto 0)
        
);
end entity;

architecture RTL of unite_trait is
  
  Signal busA, busB, busW : std_logic_vector(31 downto 0);
  Signal RB : std_logic_vector(3 downto 0);
  
begin
  
  C0 : entity work.mux21 generic map(N => 4) port map(A => RM, B => RD, COM => RegSel, S => RB);
  
  C1 : entity work.banc port map(CLK => CLK, RST => RST, 
                                  W => busW, RA => RN, 
                                  RB => RB, RW => RD, 
                                  WE => WE, A => busA, 
                                  B => busB);
    
    
  C2 : entity work.ALU port map(OP => OP, A => busA, 
                                B => busB, S => busW, N => N);
    
  S <= busW;
    
end architecture;
  