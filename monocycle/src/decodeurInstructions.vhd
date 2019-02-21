library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;


entity decodeurInstructions is
        port(
             Instruction : in std_logic_vector(31 downto 0);
             PSR : in std_logic_vector(31 downto 0);
             RegWr, ALUSrc, PSREn, MemWr, WrSrc, RegSel, nPCsel : out std_logic;
             ALUCtr : out std_logic_vector(1 downto 0)
             );
end decodeurInstructions;

architecture rtl of decodeurInstructions is

type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
signal instr_courante : enum_instruction;

begin

  
  instructions:process(Instruction)
    begin
    
    if Instruction(31 downto 20) = x"E3A" then
      
      instr_courante <= MOV;
      
    elsif Instruction(31 downto 20) = x"E61" then
      
      instr_courante <= LDR;
      
    elsif Instruction(31 downto 20) = x"E08" then
      
      instr_courante <= ADDr;
      
    elsif Instruction(31 downto 20) = x"E28" then
      
      instr_courante <= ADDi;
      
    elsif Instruction(31 downto 20) = x"E35" then
      
      instr_courante <= CMP;
      
    elsif Instruction(31 downto 24) = x"BA" then
      
      instr_courante <= BLT;
      
    elsif Instruction(31 downto 20) = x"E60" then
      
      instr_courante <= STR;
      
    elsif Instruction(31 downto 24) = x"EA" then
      
      instr_courante <= BAL;
      
    end if;
    
  end process;
  
  decodage:process(Instruction, instr_courante)
    begin
      
      if instr_courante = ADDi then
        
        nPCsel <= '0';
        RegWr <= '1';
        ALUSrc <= '1';
        ALUCtr <= "00";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
        
      elsif instr_courante = ADDr then
        
        nPCsel <= '0';
        RegWr <= '1';
        ALUSrc <= '0';
        ALUCtr <= "00";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
        
      elsif instr_courante = BAL then
        
        nPCsel <= '1';
        RegWr <= '0';
        ALUSrc <= '0';
        ALUCtr <= "00";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
        
      elsif instr_courante = BLT then
        
        if PSR(31) = '1' then
          nPCsel <= '1'; 
        else
          nPCsel <= '0';
        end if;
        
        RegWr <= '0';
        ALUSrc <= '0';
        ALUCtr <= "01";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
  
      elsif instr_courante = CMP then
        
        nPCsel <= '0';
        RegWr <= '0';
        ALUSrc <= '1';
        ALUCtr <= "10";
        PSREn <= '1';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
        
      
      elsif instr_courante = LDR then
        
        nPCsel <= '0';
        RegWr <= '1';
        ALUSrc <= '1';
        ALUCtr <= "00";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '1';
        RegSel <= '0';
        
    
      elsif instr_courante = MOV then
        
        nPCsel <= '0';
        RegWr <= '1';
        ALUSrc <= '1';
        ALUCtr <= "01";
        PSREn <= '0';
        MemWr <= '0';
        WrSrc <= '0';
        RegSel <= '0';
        
      elsif instr_courante = STR then
        
        nPCsel <= '0';
        RegWr <= '0';
        ALUSrc <= '1';
        ALUCtr <= "00";
        PSREn <= '0';
        MemWr <= '1';
        WrSrc <= '1';
        RegSel <= '1';
        
      end if;
      
    end process;
  
end rtl;             