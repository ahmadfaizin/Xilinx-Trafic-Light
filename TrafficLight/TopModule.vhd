library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopModule is
	port(
		master_clock	: IN STD_LOGIC;
		reset_btn		: IN STD_LOGIC;
		segment			: OUT STD_LOGIC_VECTOR(6 downto 0);
		anode				: OUT STD_LOGIC_VECTOR(3 downto 0);
		dot				: OUT STD_LOGIC);
end TopModule;

architecture Behavioral of TopModule is
	component ClockDevider is
		port(
			master_clock	: IN STD_LOGIC;
			reset				: IN STD_LOGIC;
			clock_traffic	: OUT STD_LOGIC;
			clock_countdown	: OUT STD_LOGIC;
			clock_segment	: OUT STD_LOGIC);
	end component;
	
	component LightControl is
		port(
			clock			: IN STD_LOGIC;
			reset			: IN STD_LOGIC;
			clock2		: IN STD_LOGIC;
			condition	: OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component SevenSegment is
		port(
			clock			: IN STD_LOGIC;
			reset			: IN STD_LOGIC;
			condition	: IN STD_LOGIC_VECTOR(15 downto 0);
			segment		: OUT STD_LOGIC_VECTOR(6 downto 0);
			anode			: OUT STD_LOGIC_VECTOR(3 downto 0);
			dot			: OUT STD_LOGIC);
	end component;
	
	signal clock_countdown, reset, clock_traffic, clock_segment : STD_LOGIC;
	signal condition	: STD_LOGIC_VECTOR(15 downto 0);
begin
	reset <= reset_btn;

	R1	: ClockDevider port map(master_clock => master_clock, reset => reset, clock_traffic => clock_traffic, clock_segment => clock_segment, clock_countdown => clock_countdown);
	R2	: LightControl port map(clock => clock_traffic, reset => reset, condition => condition, clock2 => clock_countdown);
	R3	: SevenSegment port map(clock => clock_segment, reset => reset, condition => condition, segment => segment , anode => anode, dot => dot);
end Behavioral;