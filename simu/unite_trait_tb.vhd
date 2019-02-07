library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity unite_trait_tb is
  port(OK: out boolean:=TRUE);
end unite_trait_tb;

architecture tb of unite_trait_tb is
  
Signal CLK, RST, N, WE : std_logic;
Signal OP : std_logic_vector(1 downto 0);
Signal RA, RB, RW : std_logic_vector(3 downto 0);
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
        RA <= "0000";
        RB <= "1111";
        RW <= "0000";
        WE <= '1';
        OP <= "01";
        
        wait for 5 ns;
        
        RW <= "0001";

        OK <= (S_i = X"00000030");
        
        wait for 5 ns;
        
        -- R(1) = R(1) + R(15)
        
        RA <= "0001";
        RB <= "1111";
        OP <= "00";

        
        wait for 5 ns;
        
        RW <= "0001";

        OK <= (S_i = X"00000060");
        
        wait for 5 ns;
        
        -- R(2) = R(1) + R(15)
   
        RA <= "0001";
        RB <= "1111";
        OP <= "00";
        
        
        wait for 5 ns;

        RW <= "0010";
        

        OK <= (S_i = X"00000090");
        
        wait for 5 ns;
        
        -- R(3) = R(1) - R(15) 
        
        RA <= "0001";
        RB <= "1111";
        OP <= "10";

        
        wait for 5 ns;
        
        RW <= "0011";

        
        OK <= (S_i = X"00000030");
        

        wait for 5 ns;
        
        -- R(5) = R(7) + R(15)
        
        RA <= "0111";
        RB <= "1111";
        OP <= "10";
        RW <= "0101";
        
        wait for 5 ns;
        
        RW <= "0101";
        
        OK <= (S_i = X"FFFFFFD0");

        
        wait;
  end process testbench;
C0 : entity work.unite_trait port map(CLK => CLK, RST => RST, WE => WE, OP => OP, RA => RA, RB => RB, RW => RW, N => N, S => S_i);
end tb;  
        
                                        