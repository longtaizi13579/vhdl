library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity music_reader is
	port(CLK : in std_logic;
		 start : in std_logic;
		 --tone : out integer range 0 to 382);
		 tone : out std_logic_vector(2 downto 0));
end music_reader;

architecture behaviour of music_reader is
	signal flag : std_logic:='0';
	signal count : integer range 0 to 8 := 0;
	signal temp_out : integer range 0 to 382;
begin

	process(start,count)
	begin
		if(start'event and start = '1') then
			flag <= '1';
		end if;
		
		if(count = 8) then
			flag <= '0';
		end if;
	end process;
	
	process(CLK)
	begin
		if CLK'event and CLK = '1' then
			if(flag='1') then
				count <= count + 1;
			else
				count <= 0;
			end if;
		end if;	
	
	end process;
	
--	tone <= 255 when count = 0 else
--			303 when count = 1 else
--			294 when count = 2 else
--			303 when count = 3 else
--			381 when count = 4 else
--			303 when count = 5 else
--			294 when count = 6 else
--			303 when count = 7 else
--			0;

	tone <= "101" when count = 1 else
			"011" when count = 2 else
			"010" when count = 3 else
			"011" when count = 4 else
			"001" when count = 5 else
			"011" when count = 6 else
			"010" when count = 7 else
			"011" when count = 8 else
			"000";
end behaviour;
	
	
		
		
