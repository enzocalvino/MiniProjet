library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;


entity unite_gestion is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    nPCsel : in std_logic;
    offset : in std_logic_vector(23 downto 0);
    instruction : out std_logic_vector(31 downto 0)
  );
end entity;

architecture RTL of unite_gestion is
  Signal offset32 : std_logic_vector(31 downto 0);
  Signal PC : std_logic_vector(31 downto 0);
  
  
  begin
    
    C0 : entity work.extensionPC port map(E => offset, S => offset32);
    C1 : entity work.PC port map(CLK => CLK, RST => RST, nPCsel => nPCsel, offset => offset32, PC => PC);
    C2 : entity work.instruction_memory port map(PC => PC, Instruction => instruction);
    
  end rtl;

