--Name: Ty Ahrens 
--Date: 3/9/2025
--Purpose: Program to sent to DE10-LITE board that defines pinnouts and 
--		   provides real pins for the F_or_G program from M&C 4.2
library IEEE;
use IEEE.std_logic_1164.all;

entity hw4p1 is 
	port (SW	:	IN std_logic_vector(3 downto 0);
		  KEY : IN std_logic_vector(1 downto 0);
	      LEDR	:	OUT std_logic_vector(9 downto 0));
end hw4p1;

architecture rtl of hw4p1 is
	signal A, B, C, D, F1, F2	: std_logic;
	
	component F_or_G
		port (A, B, C, D  : IN std_logic;
			  F, G			: OUT std_logic);
	end component;
	
	
begin
		A <= not SW(3) when KEY(1) = '0' else SW(3);
		B <= not SW(2) when KEY(1) = '0' else SW(2);
		C <= not SW(1) when KEY(1) = '0' else SW(1);
		D <= not SW(0) when KEY(1) = '0' else SW(0);
	
	U0: entity work.F_or_G(rtl) port map (A => A, B => B, C => C, D => D, F => F1, G => F2);
	
	LEDR(9) <= '0' when KEY(0) = '0' else F1;
	LEDR(0) <= '0' when KEY(0) = '0' else F2;
	LEDR(8 downto 1) <= (others => '0');
	
end rtl;