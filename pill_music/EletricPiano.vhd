LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
Entity ElectricPiano IS
	Port(clk : IN STD_LOGIC;
		tone : IN STD_LOGIC_VECTOR(2 downto 0);
		speaker : OUT STD_LOGIC);
END ENTITY ElectricPiano;

ARCHITECTURE ACT OF ElectricPiano IS
	SIGNAL	spks:STD_LOGIC;
	SIGNAL COUNT : INTEGER RANGE 0 TO 200;
	SIGNAL time1 : INTEGER RANGE 0 TO 200;
BEGIN
PROCESS(tone)
BEGIN
	CASE tone IS
		WHEN "001" => COUNT <= 191;--262
		WHEN "010" => COUNT <= 170;--294
		WHEN "011" => COUNT <= 151;--330
		WHEN "100" => COUNT <= 143;--349
		WHEN "101" => COUNT <= 127;--392
		WHEN "110" => COUNT <= 114;--440
		WHEN "111" => COUNT <= 102;--492
		WHEN OTHERS => COUNT <= 0;
	END CASE;
END PROCESS;

PROCESS(clk)
BEGIN
	IF(clk'event AND clk = '1')and count /= 0 THEN
		time1 <= time1 + 1;
		IF(time1 = COUNT)THEN
			spks<=NOT spks;
			time1 <= 0;
		END IF;
	END IF;
END PROCESS;

speaker <= spks;
END ARCHITECTURE ACT;