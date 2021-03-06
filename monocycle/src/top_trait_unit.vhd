library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_trait_unit is 
port(
        CLK,RST : in std_logic;
        RegSel : in std_logic;
        Imm : in std_logic_vector(7 downto 0);
        WE, WrEn: in std_logic;
        COM_1, COM_2 : in std_logic;
        OP: in std_logic_vector(1 downto 0);
        RN, RD, RM : in std_logic_vector(3 downto 0);
        N : out std_logic;
        S : out std_logic_vector(31 downto 0)

        
);
end entity;

architecture RTL of top_trait_unit is
  
  Signal busW, busA, busB : std_logic_vector(31 downto 0);
  Signal ImmExt : std_logic_vector(31 downto 0);
  Signal mux_1_out : std_logic_vector(31 downto 0);
  Signal ALUout : std_logic_vector(31 downto 0);
  Signal DataOut : std_logic_vector(31 downto 0);
  Signal RB : std_logic_vector(3 downto 0);
  
  begin
  
  
  MUX_1_comp : entity work.mux21 generic map(N => 4) port map
                          (A => RM, B => RD, COM => RegSel, S => RB);
                          
  Banc_comp : entity work.banc port map(CLK => CLK, RST => RST, 
                                    W => busW, RA => RN, 
                                    RB => RB, RW => RD,
                                    WE => WE, A => busA,
                                    B => busB);
                                  
 
  Ext_Sig_comp : entity work.extensionsigne port map(E => Imm, S => ImmExt);
  
  MUX_2_comp : entity work.mux21 generic map(N => 32) 
                                port map(A => busB, B => ImmExt, 
                                          COM => COM_1, S => mux_1_out);
  
  ALU_comp : entity work.ALU port map(OP => OP, A => busA,
                                      B => mux_1_out, S => ALUout,
                                      N => N);
  
  Data_Memory_comp : entity work.memoiredonnees port map(CLK => CLK,
                                                          Addr => ALUout(5 downto 0),
                                                          WrEn => WrEn,
                                                          DataIn => busB,
                                                          DataOut => Dataout);
  
  MUX_3_comp : entity work.mux21 generic map(N => 32) 
                                  port map(A => ALUout, B => DataOut,
                                          COM => COM_2, S => busW);
  S <= busW;
                                          
end RTL;