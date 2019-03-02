library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity VIC_tb is
  port(OK: out boolean:=TRUE);
end VIC_tb;

architecture tb of VIC_tb is
Signal CLK : std_logic;
Signal RESET : std_logic;
Signal IRQ_SERV : in std_logic;
Signal IRQ0, IRQ1 : in std_logic;
Signal IRQ : std_logic;
Signal VICPC : std_logic_vector(31 downto 0);
Signal OK : std_logic;

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
      RESET <= '1';
      IRQ_SERV <= '0';
      
      wait for 10 ns;
      RESET <= '0';
      wait for 10 ns;

      IRQ1 <= '1';
      OK <= (VICPC = X"00000015");
      wait for 20 ns;

      IRQ1 <= '0';
      IRQ0 <= '1';
      OK <= (VICPC = X"00000009");
      wait for 20 ns;

      IRQ1 <= '1';
      OK <= (VICPC = X"00000015");
      wait for 20 ns;

      wait;
    end process;

    VIC_TB : entity work.VIC port map(CLK => CLK,
    RESET => RESET,
    IRQ_SERV => IRQ_SERV,
    IRQ0 => IRQ0,
    IRQ1 => IRQ1,
    IRQ => IRQ,
    VICPC => VICPC);

end tb;