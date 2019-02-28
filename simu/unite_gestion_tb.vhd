library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity unite_gestion_tb is
end unite_gestion_tb;

architecture tb of unite_gestion_tb is
Signal CLK, RST, nPCsel : std_logic;
Signal offset : std_logic_vector(23 downto 0);
Signal instruction : std_logic_vector(31 downto 0);

begin

        clock : process
        begin
          CLK <= '0';
          wait for 5 ns;
          CLK <= '1';
          wait for 5 ns;
        end process clock;

        testbench: process
        begin
        RST <= '1';
        offset <= (others => '0');
        nPCsel <= '0';

        wait for 5 ns;

        RST <= '0';
        nPCsel <= '0';
        offset <= X"FFFFFA";

        wait for 50 ns;

        nPCsel <= '1';

        wait for 10 ns;

        nPCsel <= '0';

        wait;
      end process;

      C0 : entity work.unite_gestion port map(CLK => CLK, RST => RST,
                                              nPCsel => nPCsel, offset => offset,
                                              instruction => instruction);
end tb;
