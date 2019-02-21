library ieee;
use ieee.std_logic_1164.all;

entity mae is
port(
		CLK,RST,N					: in std_logic;	
		IRQ 							: in std_logic;
		INST_MEM, INST_REG		: in std_logic_vector(31 downto 0);	
		IRQ_SERV						: out std_logic	
);
end mae;
  