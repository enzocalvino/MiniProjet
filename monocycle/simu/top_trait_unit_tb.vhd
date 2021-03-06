library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_trait_unit_tb is
  port(OK: out boolean:=TRUE);
end top_trait_unit_tb;

architecture tb of top_trait_unit_tb is
  
Signal CLK, RST, N_i, WE_i, WrEn_i, COM_1_i, COM_2_i : std_logic;
SIgnal RegSel_i : std_logic;
Signal Imm_i : std_logic_vector(7 downto 0);
Signal OP_i : std_logic_vector(1 downto 0);
Signal RA_i, RB_i, RW_i : std_logic_vector(3 downto 0);
Signal S_i : std_logic_vector(31 downto 0);

begin

   clock : process
        begin
          CLK <= '0';
          wait for 5 ns;
          CLK <= '1';
          wait for 5 ns;
        end process clock;
        
   testbench : process
        begin
          
        -- R(1) = R(15)
        
        RST <= '0';
        RegSel_i <= '0';
        Imm_i <= (others => '0');
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '0';        
        RA_i <= "0000";
        RB_i <= "1111";
        WE_i <= '1';
        RW_i <= "0000";
        OP_i <= "01";
        
        wait for 5 ns;
        
        RW_i <= "0001";

        OK <= (S_i = X"00000030");
        --OK <= (N_i = '0');
        
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
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- R(2) = R(15) + 16
        
        Imm_i <= "00010000";
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '1';
        RA_i <= "1111";
        RB_i <= "0000";
        OP_i <= "00";

        
        wait for 5 ns;
        
        RW_i <= "0010";

        OK <= (S_i = X"00000040");
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- R(2) = R(2) - R(15)
        
        Imm_i <= "00000000";
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '0';
        RA_i <= "0010";
        RB_i <= "1111";
        OP_i <= "10";

        
        wait for 5 ns;
        
        RW_i <= "0010";

        OK <= (S_i = X"00000010");
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- R(2) = R(2) - 16
        
        Imm_i <= "00010000";
        WrEn_i <= '0';
        COM_2_i <= '0';
        COM_1_i <= '1';
        RA_i <= "0010";
        RB_i <= "0000";
        OP_i <= "10";

        
        wait for 5 ns;
        
        RW_i <= "0010";

        OK <= (S_i = X"00000000");
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- R(4) = LW 0(63)
        
        Imm_i <= "00111111";
        WrEn_i <= '0';
        COM_2_i <= '1';
        COM_1_i <= '1';
        RA_i <= "0000";
        RB_i <= "0000";
        OP_i <= "00";

        
        wait for 5 ns;
        
        RW_i <= "0100";

        OK <= (S_i = X"00000003");
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        -- SW R(4), 0(0)
        
        Imm_i <= "00000000";
        WrEn_i <= '1';
        WE_i <= '0';
        COM_2_i <= '1';
        COM_1_i <= '1';
        RA_i <= "0000";
        RB_i <= "0100";
        OP_i <= "00";

        
        wait for 5 ns;
        

        OK <= (S_i = X"00000003");
        --OK <= (N_i = '0');
        
        wait for 5 ns;
        
        WrEn_i <= '1';
        WE_i <= '0';
        
        wait;
      end process;
      
      C0 : entity work.top_trait_unit port map(CLK => CLK, RST => RST,
                                                Imm => Imm_i, WE => WE_i, 
                                                WrEn => WrEn_i, COM_1 => COM_1_i,
                                                COM_2 => COM_2_i, OP => OP_i, 
                                                RN => RA_i, RM => RB_i, 
                                                RD => RW_i, N => N_i, 
                                                S => S_i, RegSel => RegSel_i);

    end tb; 
    
    
          
        