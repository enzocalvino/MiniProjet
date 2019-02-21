library IEEE;
use IEEE.std_logic_1164.all;

entity VIC is
	port(
		CLK : in std_logic;
		RESET : in std_logic;
		IRQ_SERV : in std_logic;
		IRQ0, IRQ1 : in std_logic;
		IRQ : out std_logic;
		VICPC : out std_logic_vector(31 downto 0)
	);
end VIC;

architecture RTL of VIC is
Signal IRQ0_n, IRQ0_n_1, IRQ0_memo : std_logic;
Signal IRQ1_n, IRQ1_n_1,  IRQ1_memo : std_logic; 

begin
	IRQ <= IRQ1_memo or IRQ0_memo;
	
	process(CLK, RESET)
		begin
		
		if RESET = '1' then
			VICPC <= (others => '0');
			
			IRQ0_n <= '0';
			IRQ0_n_1 <= '0';
			
			IRQ1_n <= '0';
			IRQ1_n_1 <= '0';

		elsif rising_edge(clk) then
		
			IRQ0_n_1 <= IRQ0_n;
			IRQ0_n <= IRQ0;
			
			if(IRQ0_n = '1' and IRQ0_n_1 = '0') then
				IRQ0_memo <= '1';
			end if;
			
			IRQ1_n_1 <= IRQ1_n;
			IRQ1_n <= IRQ1;
			
			if(IRQ1_n = '1' and IRQ1_n_1 = '0') then
				IRQ1_memo <= '1';
			end if;
			
			if(IRQ_SERV = '1') then
				IRQ0_memo <= '0';
				IRQ1_memo <= '0';
			end if;
			
			if(IRQ1_memo = '1') then
				VICPC <= x"00000015";
			end if;
			
			if(IRQ0_memo = '1') then
				VICPC <= x"00000009";
			end if;
			
		end if;
			
		
	end process;
end RTL;