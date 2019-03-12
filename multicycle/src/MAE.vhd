library ieee;
use ieee.std_logic_1164.all;

entity mae is
port(
		CLK,RST,N					: in std_logic;
		IRQ 							: in std_logic;
		INST_MEM, INST_REG		: in std_logic_vector(31 downto 0);
		PCSel, AluOP, AluSelB	: out std_logic_vector(1 downto 0);
		irq_serv, PCWrEn			: out std_logic;
		LRWrEn, AdrSel, MemRdEn : out std_logic;
		MemWrEn, IRWrEn, WSel   : out std_logic;
		RegWrEn, AluSelA			: out std_logic;
		CPSRSel 						: out std_logic;
		CPSRWrEn, SPSRWrEn		: out std_logic;
		ResWrEn						: out std_logic
);
end mae;

architecture RTL of mae is
	TYPE ETAT is (Etat1, Etat2, Etat3,
	Etat4, Etat5, Etat6,
	Etat7, Etat8, Etat9,
	Etat10, Etat11, Etat12,
	Etat13, Etat14, Etat15,
	Etat16, Etat17, Etat18);
	Signal EtatPresent, EtatFutur : ETAT;

	TYPE enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, BX);
	signal inst_mem_courante : enum_instruction;
	signal inst_reg_courante : enum_instruction;

	Signal ISR : std_logic;

	begin
		horloge: process(CLK, RST)
			begin
			IF RST = '1' then

				EtatPresent <= Etat1;

			elsif rising_edge(CLK) then

				EtatPresent <= EtatFutur;

			end if;
		end process horloge;

		instructions:process(INST_MEM)
		 begin

		 if INST_MEM(31 downto 20) = x"E3A" then

			inst_mem_courante <= MOV;

		 elsif INST_MEM(31 downto 20) = x"E61" then

			inst_mem_courante <= LDR;

		 elsif INST_MEM(31 downto 20) = x"E08" then

			inst_mem_courante <= ADDr;

		 elsif INST_MEM(31 downto 20) = x"E28" then

			inst_mem_courante <= ADDi;

		 elsif INST_MEM(31 downto 20) = x"E35" then

			inst_mem_courante <= CMP;

		 elsif INST_MEM(31 downto 24) = x"BA" then

			inst_mem_courante <= BLT;

		 elsif INST_MEM(31 downto 20) = x"E60" then

			inst_mem_courante <= STR;

		 elsif INST_MEM(31 downto 24) = x"EA" then

			inst_mem_courante <= BAL;

		 elsif INST_MEM(31 downto 24) = x"EB" then

			inst_mem_courante <= BX;

		 end if;

	 end process instructions;

		etats: process(EtatPresent, IRQ, INST_MEM, inst_mem_courante, ISR)
			begin

				if EtatPresent = Etat1 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '1';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "11";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat2;

				elsif EtatPresent = Etat2 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "11";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

							if (ISR = '1' or not(IRQ) = '1') and (inst_mem_courante = LDR or inst_mem_courante = STR or inst_mem_courante = ADDr or
								inst_mem_courante = ADDi or inst_mem_courante = CMP or inst_mem_courante = MOV) then

								EtatFutur <= Etat3;

							elsif inst_mem_courante = BAL or (inst_mem_courante = BLT and N = '1') then

								EtatFutur <= Etat4;

							elsif (inst_mem_courante = BLT and N = '0') then

								EtatFutur <= Etat5;

							elsif IRQ = '1' and not(ISR) = '1' then

								EtatFutur <= Etat17;

							elsif ISR = '1' and inst_mem_courante = BX then

								EtatFutur <= Etat16;

							end if;

				elsif  EtatPresent = Etat3 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '1';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '0';
						ALUSelB <= "11";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat6;

				elsif EtatPresent = Etat4 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '1';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '0';
						ALUSelB <= "11";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat1;

				 elsif EtatPresent = Etat5 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '1';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '0';
						ALUSelB <= "10";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat1;

				 elsif EtatPresent = Etat6 then

						if inst_mem_courante = LDR or inst_mem_courante = STR or inst_mem_courante = ADDi then

								EtatFutur <= Etat7;

						elsif inst_mem_courante = ADDr then

								EtatFutur <= Etat8;

						elsif inst_mem_courante = MOV then

								EtatFutur <= Etat9;

						elsif inst_mem_courante = CMP then

								EtatFutur <= Etat10;

						end if;

				 elsif EtatPresent = Etat7 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "01";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						if inst_mem_courante = LDR then

								EtatFutur <= Etat11;

						elsif inst_mem_courante = STR then

								EtatFutur <= Etat12;

						elsif inst_mem_courante = ADDi then

								EtatFutur <= Etat13;

						end if;

					elsif EtatPresent = Etat8 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat13;

					elsif EtatPresent = Etat9 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "01";
						ALUOP <= "01";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat13;

					elsif EtatPresent = Etat10 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "01";
						ALUOP <= "01";
						CPSRSel <= '0';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat1;

					elsif EtatPresent = Etat11 then

						irq_serv <= '0';
						PCSel <= "01";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '1';
						MemRdEn <= '1';
						MemWrEn <= '0';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "01";
						ALUOP <= "01";
						CPSRSel <= '0';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat14;

					elsif EtatPresent = Etat12 then

						irq_serv <= '0';
						PCSel <= "01";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '1';
						MemRdEn <= '0';
						MemWrEn <= '1';
						IRWrEn <= '1';
						WSel <= '0';
						RegWrEn <= '0';
						ALUSelA <= '1';
						ALUSelB <= "01";
						ALUOP <= "01";
						CPSRSel <= '0';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '1';

						EtatFutur <= Etat1;

					elsif EtatPresent = Etat13 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '1';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat1;

					elsif EtatPresent = Etat14 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '1';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat15;

					elsif EtatPresent = Etat15 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '0';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '0';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat1;

					elsif EtatPresent = Etat16 then

						irq_serv <= '1';
						PCSel <= "10";
						PCWrEn <= '1';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '1';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '1';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						ISR <= '0';

						EtatFutur <= Etat1;

					elsif EtatPresent = Etat17 then

						irq_serv <= '0';
						PCSel <= "00";
						PCWrEn <= '0';
						LRWrEn <= '1';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '1';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						EtatFutur <= Etat18;

					elsif EtatPresent = Etat18 then

						irq_serv <= '0';
						PCSel <= "11";
						PCWrEn <= '1';
						LRWrEn <= '0';
						AdrSel <= '0';
						MemRdEn <= '0';
						MemWrEn <= '0';
						IRWrEn <= '0';
						WSel <= '1';
						RegWrEn <= '1';
						ALUSelA <= '0';
						ALUSelB <= "00";
						ALUOP <= "00";
						CPSRSel <= '0';
						CPSRWrEn <= '1';
						SPSRWrEn <= '0';
						ResWrEn <= '0';

						ISR <= '1';

						EtatFutur <= Etat1;

					end if;

			end process etats;
	end RTL;
