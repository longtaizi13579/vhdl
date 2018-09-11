LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity show is
port(  clk:in std_logic;
		k: in std_logic_vector(2 downto 0);
		l1:out std_logic_vector(7 downto 1);
		l2:out std_logic_vector(3 downto 0);
		l3:out std_logic_vector(3 downto 0);
		l4:out std_logic_vector(3 downto 0);
		l5:out std_logic_vector(3 downto 0);
		l6:out std_logic_vector(3 downto 0);
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
	function leddecoder(in_data: std_logic_vector) return std_logic_vector is
	variable out_data: std_logic_vector(6 downto 0);
	begin
		case in_data is
			when "0000" => out_data := "1111110";
			when "0001" => out_data := "0110000";
			when "0010" => out_data := "1101101";
			when "0011" => out_data := "1111001";
			when "0100" => out_data := "0110011";
			when "0101" => out_data := "1011011";
			when "0110" => out_data := "0011111";
			when "0111" => out_data := "1110000";
			when "1000" => out_data := "1111111";
			when "1001" => out_data := "1110011";
			when others => NULL;
		end case;
		return out_data;
	end leddecoder;
end show;
architecture showtime of show is
signal countmem:std_logic;
		begin
		process(clk,k)
		begin
			if(clk'event and clk='0') then
			if(k(2)='0') then
			if (countmem='0')then
				l1 <= leddecoder(count);
				l2 <= count2; l3 <= count3;
				l4 <= count4; l5 <= count5; l6 <= count6;
				case k(1 downto 0) is	
					when "00" => NULL;
					when "01" => l5 <= "1111"; l6 <= "1111";
					when "10" => l4 <= "1111"; l3 <= "1111";
					when "11" => l2 <= "1111"; l1 <= "0000000";
				end case;
				countmem<='1';
			elsif(countmem='1') then
				l1 <= leddecoder(count);
				l2 <= count2; l3 <= count3;
				l4 <= count4; l5 <= count5; l6 <= count6;
				countmem<='0';
			end if;
			else
			if (countmem='0')then
				l1 <= leddecoder(alarm1);
				l2 <= alarm2; l3 <= alarm3;
				l4 <= alarm4; l5 <= alarm5; l6 <= alarm6;
				case k(1 downto 0) is	
					when "00" => NULL;
					when "01" => l5 <= "1111"; l6 <= "1111";
					when "10" => l4 <= "1111"; l3 <= "1111";
					when "11" => l2 <= "1111"; l1 <= "0000000";
				end case;
				countmem<='1';
			elsif(countmem='1') then
				l1 <= leddecoder(alarm1);
				l2 <= alarm2; l3 <= alarm3;
				l4 <= alarm4; l5 <= alarm5; l6 <= alarm6;
				countmem<='0';
			end if;
		end if;
		end if;
		end process;
end showtime;