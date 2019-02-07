library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_trait_unit_tb is
  port(OK: out boolean:=TRUE);
end top_trait_unit_tb;

architecture tb of top_trait_unit_tb is
  
Signal CLK, RST, N_i, WE_i, WrEn_i, COM_1_i, COM_2_i : std_logic;
Signal Imm_i : std_logic_vector(7 downto 0);
Signal OP_i : std_logic_vector(1 downto 0);
Signal RA_i, RB_i, RW_i : std_logic_vector(3 downto 0);
Signal S_i : std_logic_vector(31 downto 0);

begin

   clock : process
        begin
          CLK <= '1';
          wait for 5 ns;
          CLK <= '0';
          wait for 5 ns;
        end process clock;
        
   testbench : process
        begin
          
        -- R(1) = R(15)
        
        RST <= '0';
        Imm_i <= (others => '0');
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '0';        
        RA_i <= "0000";
        RB_i <= "1111";
        OP_i <= "01";
        
        wait for 5 ns;
        
        WE_i <= '1';
        RW_i <= "0001";

        OK <= (S_i = X"00000030");
        OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- R(1) = R(1) + R(15)
        
        Imm_i <= (others => '0');
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '0';
        RA_i <= "0001";
        RB_i <= "1111";
        OP_i <= "00";

        
        wait for 5 ns;
        
        RW_i <= "0001";

        OK <= (S_i = X"00000060");
        OK <= (N_i = '0');
        
        wait;
      end process;
      
      C0 : entity work.top_trait_unit port map(CLK => CLK, RST => RST,
                                                Imm => Imm_i, WE => WE_i, 
                                                WrEn => WrEn_i, COM_1 => COM_1_i,
                                                COM_2 => COM_2_i, OP => OP_i, 
                                                RA => RA_i, RB => RB_i, 
                                                RW => RW_i, N => N_i, 
                                                S => S_i);

    end tb; 
    
    
          
        