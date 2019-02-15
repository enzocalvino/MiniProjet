library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity processeur is 
port(
        CLK,RST : in std_logic;
        S : out std_logic_vector(31 downto 0)
        
);
end entity;


architecture RTL of processeur is
  
  Signal instruction, flag, PSR : std_logic_vector(31 downto 0);
  Signal nPCsel, RegWr, ALUSrc, PSREn, MemWr, WrSrc, RegSel : std_logic;
  Signal ALUCtr : std_logic_vector(1 downto 0);
  
  begin
    
    flag(30 downto 0) <= (others => '0');
    
    Gestion_instruct: entity work.unite_gestion port map(CLK => CLK, RST => RST,
                                                          offset => instruction(23 downto 0), nPCsel => nPCsel,
                                                          instruction => instruction);
    
    Decode_instruction: entity work.decodeurinstructions port map(instruction => instruction,
                                                                  PSR =>  PSR, nPCsel => nPCsel, 
                                                                  RegWr => RegWr, ALUSrc => ALUSrc, 
                                                                  PSREn => PSREn, MemWr => MemWr, WrSrc => WrSrc, 
                                                                  RegSel => RegSel, ALUCtr => ALUCtr);
    
    PSR_reg: entity work.reg32bit port map(DataIn => flag, RST => RST, 
                                        CLK => CLK, WE => PSREn, DataOut => PSR);
                                        
    Unite_Traitement: entity work.top_trait_unit port map(CLK => CLK, RST => RST, RegSel => RegSel,
                                                Imm => instruction(7 downto 0), WE => RegWr, WrEn => MemWr, COM_1 => ALUSrc,
                                                COM_2 => WrSrc, OP => ALUctr, RN => instruction(19 downto 16), 
                                                RD =>instruction(15 downto 12) , RM => instruction(3 downto 0),
                                                N => flag(31), S => S);
                                                                                         
  end rtl;
        
                                                           