LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity chooseone is
	port( clk:in std_logic;
		pulse:in std_logic;--pulse
		output:out std_logic;
		k: in std_logic_vector(1 downto 0)
	);
	end chooseone;
architecture one of chooseone is
begin
p1:process(pulse,clk) ---count time and option time
begin
if(k="00") then
	output<=clk;
elsif(k="01") then
	output<=pulse;
end if;
end process p1;
end one;