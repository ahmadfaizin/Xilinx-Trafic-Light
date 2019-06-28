library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDevider is
	port(
		master_clock	: IN STD_LOGIC;
		reset				: IN STD_LOGIC;
		clock_traffic	: OUT STD_LOGIC;
		clock_segment	: OUT STD_LOGIC);
end ClockDevider;

architecture Behavioral of ClockDevider is
	signal accu			: STD_LOGIC_VECTOR(27 downto 0);
begin
	process(master_clock,reset,accu)
		begin
			if reset = '1' then accu <= X"0000000";
			elsif master_clock'event and master_clock = '1' then accu <= accu + 1;
			end if;
			
			clock_traffic	<= accu(23);
			clock_segment	<= accu(15);
			clock_countdown <= accu(20);
	end process;
end Behavioral;