library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
	port(
		clock			: IN STD_LOGIC;
		reset			: IN STD_LOGIC;
		condition	: IN STD_LOGIC_VECTOR(15 downto 0);
		segment		: OUT STD_LOGIC_VECTOR(6 downto 0);
		anode			: OUT STD_LOGIC_VECTOR(3 downto 0);
		dot			: OUT STD_LOGIC);
end SevenSegment;

architecture Behavioral of SevenSegment is
	signal switch	: STD_LOGIC_VECTOR(1 downto 0);
	signal digit	: STD_LOGIC_VECTOR(3 downto 0);
	signal enable	: STD_LOGIC_VECTOR(3 downto 0);
begin
	dot <= '1';
	enable <= "1111";
	
	process(clock,reset)
		begin
			if reset = '1' then switch <= "00";
			elsif clock'event and clock = '1' then switch <= switch + 1;
			end if;
	end process;
	
	process(switch)
		begin
			case switch is
				when "00" => digit <= condition(3 downto 0);
				when "01" => digit <= condition(7 downto 4);
				when "10" => digit <= condition(11 downto 8);
				when others => digit <= condition(15 downto 12);
			end case;
	end process;
	
	process(digit)
		begin
			case digit is
				when X"0" => segment <= "0111111";
				when X"1" => segment <= "1110111";
				when X"2" => segment <= "1111110";
				when others => segment <= "1111111";
			end case;
	end process;
	
	process(switch,enable)
		begin
			anode <= "1111";
			if enable(conv_integer(switch)) = '1' then anode(conv_integer(switch)) <= '0';
			end if;
	end process;
			
end Behavioral;