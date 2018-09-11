LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity chooseone is
	port( clk:in std_logic;
		pulse:in std_logic;--pulse
		output:out std_logic;
		k: in std_logic_vector(2 downto 0)
	);
	end chooseone;
architecture one of chooseone is
begin
p1:process(pulse,clk,k) ---count time and option time
begin
if(k="000") then
	output<=clk;
else
	output<=pulse;
end if;
end process p1;
end one;