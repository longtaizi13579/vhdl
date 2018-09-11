LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity test is
	port( clk:in std_logic;
		k: in std_logic_vector(2 downto 0);
		pulse:in std_logic;--pulse
		lcx:in std_logic;
		ount:out std_logic_vector(3 downto 0);
      ount2:out std_logic_vector(3 downto 0);
      ount3:out std_logic_vector(3 downto 0);
		ount4:out std_logic_vector(3 downto 0);
      ount5:out std_logic_vector(3 downto 0);
      ount6:out std_logic_vector(3 downto 0);
      larm1:out std_logic_vector(3 downto 0);
      larm2:out std_logic_vector(3 downto 0);
      larm3:out std_logic_vector(3 downto 0);
      larm4:out std_logic_vector(3 downto 0);
      larm5:out std_logic_vector(3 downto 0);
      larm6:out std_logic_vector(3 downto 0)
	);
end test;

architecture tube of test is
signal count:std_logic_vector(3 downto 0):="0000";
signal count2:std_logic_vector(3 downto 0):="0000";
signal count3:std_logic_vector(3 downto 0):="0000";
signal count4:std_logic_vector(3 downto 0):="0000";
signal count5:std_logic_vector(3 downto 0):="0000";
signal count6:std_logic_vector(3 downto 0):="0000";
signal alarm1:std_logic_vector(3 downto 0):="0000";
signal alarm2:std_logic_vector(3 downto 0):="0000";
signal alarm3:std_logic_vector(3 downto 0):="0000";
signal alarm4:std_logic_vector(3 downto 0):="0000";
signal alarm5:std_logic_vector(3 downto 0):="0000";
signal alarm6:std_logic_vector(3 downto 0):="0000";
begin
		
		p1:process(k,lcx) ---count time and option time
		begin
		if(rising_edge(lcx))then
		if(k="000") then
		if(count="1001")then
			count<="0000";
			if(count2="0101")then
			count2<="0000";
				if(count3="1001")then
				count3<="0000";
					if(count4="0101")then
					count4<="0000";
						if(count5="1001")then 
							count5<="0000";
							count6<=count6+1;
						elsif(count5="0011" and count6="0010") then
							count5<="0000";
							count6<="0000";
						else
							count5<=count5+1;
						end if;
					else
					count4<=count4+1;
					end if;
				else
				count3<=count3+1;
				end if;
			else
			count2<=count2+1;
			end if;
		else
		count<=count+'1';
		end if;
		elsif(k="001") then
				if(count5="1001")then 
					count5<="0000";
					count6<=count6+1;
				elsif(count5="0011" and count6="0010") then
					count5<="0000";
					count6<="0000";
				else
					count5<=count5+1;
				end if;
		elsif(k="010") then
			if(count3="1001")then
				count3<="0000";
				if(count4="0101")then
					count4<="0000";
				else
					count4<=count4+1;
				end if;
			else
				count3<=count3+1;
			end if;
		elsif(k="011") then
			if(count="1001")then
				count<="0000";
				if(count2="0101")then
					count2<="0000";
				else
					count2<=count2+1;
				end if;
			else
				count<=count+1;
			end if;
			
		elsif(k="101") then
				if(alarm5="1001")then 
					alarm5<="0000";
					alarm6<=alarm6+1;
				elsif(alarm5="0011" and alarm6="0010") then
					alarm5<="0000";
					alarm6<="0000";
				else
					alarm5<=alarm5+1;
				end if;
		elsif(k="110") then
			if(alarm3="1001")then
				alarm3<="0000";
				if(alarm4="0101")then
					alarm4<="0000";
				else
					alarm4<=alarm4+1;
				end if;
			else
				alarm3<=alarm3+1;
			end if;
		elsif(k="111") then
			if(alarm1="1001")then
				alarm1<="0000";
				if(alarm2="0101")then
					alarm2<="0000";
				else
					alarm2<=alarm2+1;
				end if;
			else
				alarm1<=alarm1+1;
			end if;
			
		end if;
		end if;
		end process p1;
		
		givedata:process(count,count2,count3,count4,count5,count6,alarm1,alarm2,alarm3,alarm4,alarm5,alarm6)
		begin
		ount<=count;
      ount2<=count2;
      ount3<=count3;
		ount4<=count4;
      ount5<=count5;
      ount6<=count6;
      larm1<=alarm1;
      larm2<=alarm2;
      larm3<=alarm3;
      larm4<=alarm4;
      larm5<=alarm5;
      larm6<=alarm6;
		end process givedata;
	
		
end tube;