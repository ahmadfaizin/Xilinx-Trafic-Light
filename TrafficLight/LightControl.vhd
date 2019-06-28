library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LightControl is
	port(
		clock			: IN STD_LOGIC;
		clock2			: IN STD_LOGIC;
		reset			: IN STD_LOGIC;
		condition	: OUT STD_LOGIC_VECTOR(15 downto 0));
end LightControl;

architecture Behavioral of LightControl is
	type STATE_TYPE is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11);
	signal state	: STATE_TYPE;
	signal counter	: STD_LOGIC_VECTOR(3 downto 0);
	signal counter2	: STD_LOGIC_VECTOR(6 downto 0);
	constant SEC1	: STD_LOGIC_VECTOR(5 downto 0) := "111100";
	constant SEC2	: STD_LOGIC_VECTOR(2 downto 0) := "010";
	constant SEC3	: STD_LOGIC_VECTOR(2 downto 0) := "011";
	constant SEC5	: STD_LOGIC_VECTOR(2 downto 0) := "101";
begin
	process(clock,reset)
		begin
			if reset = '1' then
				state		<= S0;
				counter	<= X"0";
			elsif clock'event and clock = '1' then
				case state is
					when S0 =>
						if counter < SEC2 then counter <= counter + 1;
						else
							state <= S1;
							counter <= X"0";
						end if;
					when S1 =>
						if counter < SEC5 then counter <= counter + 1;
						else
							state <= S2;
							counter <= X"0";
						end if;
					when S2 =>
						if counter < SEC3 then counter <= counter + 1;
						else
							state <= S3;
							counter <= X"0";
						end if;
					when S3 =>
						if counter < SEC2 then counter <= counter + 1;
						else
							state <= S4;
							counter <= X"0";
						end if;
					when S4 =>
						if counter < SEC5 then counter <= counter + 1;
						else
							state <= S5;
							counter <= X"0";
						end if;
					when S5 =>
						if counter < SEC3 then counter <= counter + 1;
						else
							state <= S6;
							counter <= X"0";
						end if;
					end case;
			end if;
		end process;
		
		process(clock2,reset)
		begin
			if reset = '1' then
				state		<= S6;
				counter	<= X"0";
			elsif clock2'event and clock2 = '1' then
				case state is
					when S6 =>
						if counter2 < SEC1 then counter2 <= counter2 + 1;
						else
							state <= S6;
							counter2 <= X"0";
						end if;
					
					end case;
			end if;
		end process;
		
		
		process(state)
			begin
				case state is
					when S0 => condition <= X"00";
					when S1 => condition <= X"01";
					when S2 => condition <= X"02";
					when S3 => condition <= X"00";
					when S4 => condition <= X"10";
					when others => condition <= X"20";
				end case;
		end process;
end Behavioral;