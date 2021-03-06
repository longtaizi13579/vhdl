LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity music is
	port( 
		clk:in std_logic;
		req:out std_logic_vector(7 downto 0);
		count:in std_logic_vector(3 downto 0);
      count2:in std_logic_vector(3 downto 0);
      count3:in std_logic_vector(3 downto 0);
		count4:in std_logic_vector(3 downto 0);
      count5:in std_logic_vector(3 downto 0);
      count6:in std_logic_vector(3 downto 0);
      alarm1:in std_logic_vector(3 downto 0);
      alarm2:in std_logic_vector(3 downto 0);
      alarm3:in std_logic_vector(3 downto 0);
      alarm4:in std_logic_vector(3 downto 0);
      alarm5:in std_logic_vector(3 downto 0);
      alarm6:in std_logic_vector(3 downto 0)
	);
end music;

architecture voice of music is
signal freq:std_logic_vector(7 downto 0);
signal counter:std_logic_vector(3 downto 0);--14 conditions
begin
music: process(clk, count,count2,count3,count4,count5,count6,alarm1,alarm2,alarm3,alarm4,alarm5,alarm6)
		variable sign:std_logic:='0';
		begin 
			if(count4 & count3 & count2 & count= "0000000000000000") then 
			sign:='1';
			elsif(count=alarm1 and count2=alarm2 and count3=alarm3 and count4=alarm4 and count5=alarm5 and count6=alarm6) then
			sign:='1';
			elsif(clk' event and clk = '1' and sign='1') then
				if counter="0000" then
					freq<="11000011";
					counter<=counter+1;
				elsif counter="0001" then
					freq<="11000011";
					counter<=counter+1;
				elsif counter="0010" then
					freq<="10000010";
					counter<=counter+1;
				elsif counter="0011" then
					freq<="10000010";
					counter<=counter+1;
				elsif counter="0100" then
					freq<="01110101";
					counter<=counter+1;
				elsif counter="0101" then
					freq<="01110101";
					counter<=counter+1;
				elsif counter="0110" then
					freq<="10000010";
					counter<=counter+1;
				elsif counter="0111" then
					freq<="00000000";
					sign:='0';
					counter<="0000";
				end if;
			end if;
			req<=freq;
		end process music;
end voice;