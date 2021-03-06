LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity sound is
	port(
			clk100k:in std_logic;
			final:out std_logic;
         freq:in std_logic_vector(7 downto 0)
	);
	end sound;
architecture listen of sound is
signal freqout:std_logic;
signal cnt:std_logic_vector(7 downto 0);
begin
		sound: process(clk100k)
		begin
		final <= freqout;
			if rising_edge(clk100k) then
				if freq = "00000000" then--û������������
					freqout <= '0';--����������������������
				else
					if cnt = freq then--������
						cnt <= "00000000";
						freqout <= not freqout;--����ȡ��<=>�����
					else
							cnt <= cnt + 1;
					end if;
				end if;
			end if;
		end process sound;
	end listen;
	