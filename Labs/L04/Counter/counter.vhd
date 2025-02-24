LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_signed.ALL;

ENTITY counter IS
    PORT (	L		:	IN			STD_LOGIC;
				Clock	:	IN			STD_LOGIC;
				Data	:	IN			STD_LOGIC_VECTOR(2 DOWNTO 0);
				Q		:	BUFFER	STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY;

ARCHITECTURE Behaviour OF counter IS 
	SIGNAL E	:	STD_LOGIC;
BEGIN	
	PROCESS (Clock, L, Data)
	BEGIN
		IF	L = '0' THEN
			Q <= Data;
		ELSIF	Clock'EVENT AND Clock = '1' AND E = '1' THEN
			Q <= Q - "001";
		END IF;
	END PROCESS;
	-- stop the counter when Q = 0
	E <= '0' WHEN Q = "000" ELSE '1';
END Behaviour;