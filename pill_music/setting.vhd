library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity setting is
	port(QD:in std_logic;
		CLK:in std_logic;
		CLKF:in std_logic;
		START:in std_logic;
		clear:in std_logic;
		state_input:in std_logic_vector(2 downto 0);
		
		red :out std_logic;
		green :out std_logic;
		yellow :out std_logic;
		h1:out std_logic_vector(3 downto 0);
		m1:out std_logic_vector(3 downto 0);
		l1:out std_logic_vector(3 downto 0);
		h2:out std_logic_vector(3 downto 0);
		l2:out std_logic_vector(3 downto 0);
		test:out std_logic
		);
end setting;

architecture implement of setting is
	--real total pill account hml
	signal total_pill_h : std_logic_vector(3 downto 0):="0000";
	signal total_pill_m : std_logic_vector(3 downto 0):="0000";
	signal total_pill_l : std_logic_vector(3 downto 0):="0000";
	--real pills account in per bottle hl
	signal pil_per_bot_h : std_logic_vector(3 downto 0):="0000";
	signal pil_per_bot_l : std_logic_vector(3 downto 0):="0000";
	--real bottle account hl
	signal bot_num_h : std_logic_vector(3 downto 0):="0000";
	signal bot_num_l : std_logic_vector(3 downto 0):="0000";
	--user set the total pill hml
	signal set_total_pill_h: std_logic_vector(3 downto 0):="0000";
	signal set_total_pill_m: std_logic_vector(3 downto 0):="0000";
	signal set_total_pill_l: std_logic_vector(3 downto 0):="0000";
	--user set the pill pre bottle hl
	signal set_pil_per_bot_h: std_logic_vector(3 downto 0):="0000";
	signal set_pil_per_bot_l: std_logic_vector(3 downto 0):="0000";
	--state
	signal state: std_logic_vector(2 downto 0):="001";
	--LED
	signal alarm_temp: std_logic:='0';
	--work or not
	signal working: std_logic:='0';
	signal finish: std_logic:='0';
	
	SIGNAl clk1 : STD_LOGIC:='0';
	
	signal sel_set_total_pill_h:std_logic;
	signal sel_set_total_pill_m:std_logic;
	signal sel_set_total_pill_l:std_logic;
	
	signal sel_set_pil_per_bot_h:std_logic;
	signal sel_set_pil_per_bot_l:std_logic;
	
begin

-----------------input model-----------------------------------------
	sel_set_total_pill_h <= QD when state = "001" and working = '0' else '0';
	sel_set_total_pill_m <= QD when state = "010" and working = '0' else '0';
	sel_set_total_pill_l <= QD when state = "011" and working = '0' else '0';
	sel_set_pil_per_bot_h <= QD when state = "100" and working = '0' else '0';
	sel_set_pil_per_bot_l <= QD when state = "101" and working = '0' else '0';
	
	process(sel_set_total_pill_h)
	begin
		if (sel_set_total_pill_h'event and sel_set_total_pill_h = '1') then
			if (set_total_pill_h = "1001") then
				set_total_pill_h <= "0000";
			else
				set_total_pill_h <= set_total_pill_h + 1;
			end if;
		end if;
	end process;
	
	process(sel_set_total_pill_m)
	begin
		if (sel_set_total_pill_m'event and sel_set_total_pill_m = '1') then
			if (set_total_pill_m = "1001") then
				set_total_pill_m <= "0000";
			else
				set_total_pill_m <= set_total_pill_m + 1;
			end if;
		end if;
	end process;
	
	process(sel_set_total_pill_l)
	begin
		if (sel_set_total_pill_l'event and sel_set_total_pill_l = '1') then
			if (set_total_pill_l = "1001") then
				set_total_pill_l <= "0000";
			else
				set_total_pill_l <= set_total_pill_l + 1;
			end if;
		end if;
	end process;

	process(sel_set_pil_per_bot_h)
	begin
		if (sel_set_pil_per_bot_h'event and sel_set_pil_per_bot_h = '1') then
			if (set_pil_per_bot_h = "1001") then
				set_pil_per_bot_h <= "0000";
			else
				set_pil_per_bot_h <= set_pil_per_bot_h + 1;
			end if;
		end if;
	end process;

	process(sel_set_pil_per_bot_l)
	begin
		if (sel_set_pil_per_bot_l'event and sel_set_pil_per_bot_l = '1') then
			if (set_pil_per_bot_l = "1001") then
				set_pil_per_bot_l <= "0000";
			else
				set_pil_per_bot_l <= set_pil_per_bot_l + 1;
			end if;
		end if;
	end process;
	
--	set_ttl_pil_h <= set_total_pill_h;
--	set_ttl_pil_m <= set_total_pill_m;
--	set_ttl_pil_l <= set_total_pill_l;
	
--	set_per_bottle_h <= set_pil_per_bot_h;
--	set_per_bottle_l <= set_pil_per_bot_l;
-----------------------------end input model--------------------------------

-----------------------------control model----------------------------------
--	working <= '1' when (state="000" or state="110" or state="111") else '0';
	process(CLKF)
	begin
		if(CLKF'event and CLKF='1')then
			state <= state_input;
		end if;
	end process;
	
	process(START,clear,clk1)
	begin
		if(START='1')then
			if(set_pil_per_bot_h < "0101" and working='0')then
				working <= '1';
				alarm_temp <= '0';
			elsif(set_pil_per_bot_h >= "0101" and working='0')then
				alarm_temp <= '1';
			end if;
		elsif(clear='1')then
			working <= '0';
			alarm_temp <= '0';
			finish <= '0';
		elsif(total_pill_l = set_total_pill_l AND total_pill_m = set_total_pill_m AND total_pill_h = set_total_pill_h and working='1')then
			finish <= '1';
		else
			finish <= '0';
		end if;
	end process;

	green <= '1'when(working = '1' and finish = '0') else '0';
	yellow <= finish;
	red <= alarm_temp;
	
-----------------------------end control model------------------------------

-----------------------------output model-----------------------------------
	h1<=set_total_pill_h WHEN ((((state="001"AND CLK='1')OR state="010" OR state="011"OR state="100"OR state="101"OR state="000")AND working='0')OR state="111")ELSE-- in setting model
		"1111" WHEN ((state="001" AND CLK ='0')AND working='0') ELSE--set set_total_pill_h,shine
		"0000" WHEN (state="110")ELSE-- display the real bottle number
		 total_pill_h;--no setting,display the real number
		       
	m1<=set_total_pill_m WHEN ((((state="010"AND CLK='1')OR state="001" OR state="011"OR state="100"OR state="101"OR state="000")AND working='0')OR state="111")ELSE-- in setting model
		"1111" WHEN ((state="010" AND CLK ='0')AND working='0') ELSE--set set_total_pill_m,shine
		"0000" WHEN (state="110")ELSE-- display the real bottle number
		 total_pill_m;--no setting,display the real number
		 
	l1<=set_total_pill_l WHEN ((((state="011"AND CLK='1')OR state="001" OR state="010"OR state="100"OR state="101"OR state="000")AND working='0')OR state="111")ELSE-- in setting model
		"1111" WHEN ((state="011" AND CLK ='0')AND working='0') ELSE--set set_total_pill_l,shine
		"0000" WHEN (state="110")ELSE-- display the real bottle number
		 total_pill_l;--no setting,display the real number
	
	h2<=set_pil_per_bot_h WHEN ((((state="100"AND CLK='1')OR state="001" OR state="010"OR state="011"OR state="101"OR state="000")AND working='0')OR state="111")ELSE-- in setting model
		"1111" WHEN ((state="100" AND CLK ='0')AND working='0') ELSE--set set_pil_per_bot_h,shine
		bot_num_h WHEN (state="110")ELSE-- display the real bottle number
		pil_per_bot_h;--no setting,display the real number        
		       
	l2<=set_pil_per_bot_l WHEN ((((state="101"AND CLK='1')OR state="001" OR state="010"OR state="011"OR state="100"OR state="000")AND working='0')OR state="111")ELSE-- in setting model
		"1111" WHEN ((state="101" AND CLK ='0')AND working='0') ELSE--set set_pil_per_bot_h,shine
		bot_num_l WHEN (state="110")ELSE-- display the real bottle number
		pil_per_bot_l;--no setting,display the real number     

-----------------------------end output model-------------------------------

-----------------------------loading model----------------------------------
	PROCESS(clk)
	BEGIN
		IF(clk'event AND clk = '1')THEN
			clk1 <= not clk1;
		END IF;
	END PROCESS;
	PROCESS(clk1)
		BEGIN
		IF(clk1'event AND clk1 = '1')THEN
			IF(working = '1' AND finish = '0')THEN
				--TOTAL PILL
				IF(total_pill_l /= "1001")THEN
					total_pill_l <= total_pill_l + 1;
				ELSE
					IF(total_pill_m /= "1001")THEN
						total_pill_m <= total_pill_m + 1;
						total_pill_l <= "0000";
					ELSE
						total_pill_h <= total_pill_h + 1;
						total_pill_l <= "0000";
						total_pill_m <= "0000";
					END IF;
				END IF;
				IF(pil_per_bot_l = set_pil_per_bot_l AND pil_per_bot_h = set_pil_per_bot_h)THEN
					test <= '1' ; --
					pil_per_bot_l <= "0001";
					pil_per_bot_h <= "0000";
					IF(bot_num_l = "1001")THEN
						bot_num_l <= "0000";
						bot_num_h <= bot_num_h + 1;
						pil_per_bot_l <= "0001";
						pil_per_bot_h <= "0000";
					ELSE
						bot_num_l <= bot_num_l + 1;
						pil_per_bot_l <= "0001";
						pil_per_bot_h <= "0000";
					END IF;
				ELSIF(pil_per_bot_l = "1001")THEN
					test <= '0' ;--
					pil_per_bot_l <= "0000";
					pil_per_bot_h <= pil_per_bot_h + 1;
				ELSE
					test <= '0' ;--
					pil_per_bot_l <= pil_per_bot_l + 1;
				END IF;
			END IF;
		END IF;
		IF(working = '0')THEN
			total_pill_h <= "0000";
			total_pill_m <= "0000";
			total_pill_l <= "0000";
			pil_per_bot_h <= "0000";
			pil_per_bot_l <= "0000";
			bot_num_h <= "0000";
			bot_num_l <= "0000";
		END IF;
	END PROCESS;
--	PROCESS(clk1)
--	BEGIN
--		IF(total_pill_l = set_total_pill_l AND total_pill_m = set_total_pill_m AND total_pill_h = set_total_pill_h)THEN
--			finish <= '1';
--			state1 <= '0';
--		ELSE
--			state1 <= '1';
--			finish <= '0';
--		END IF;
--	END PROCESS;
-----------------------------end loading model------------------------------
end implement;
		
