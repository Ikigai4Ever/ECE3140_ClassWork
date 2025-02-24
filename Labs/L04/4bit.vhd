LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Mux_4bit IS
    PORT (  X,  Y   	:  IN  	STD_LOGIC_VECTOR(3 DOWNTO 0);
				s			:	IN 	STD_LOGIC;
				M			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0));
END Mux_4bit;

ARCHITECTURE Structure OF Mux_4bit IS
BEGIN
	M(0) <= (NOT(s) AND X(0)) OR (s AND Y(0));
	M(1) <= (NOT(s) AND X(1)) OR (s AND Y(1));
	M(2) <= (NOT(s) AND X(2)) OR (s AND Y(2));
	M(3) <= (NOT(s) AND X(3)) OR (s AND Y(3));
END Structure;