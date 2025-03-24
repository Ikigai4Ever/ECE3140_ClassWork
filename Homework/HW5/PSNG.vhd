--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: Using LFSRs with periods that are maximally-long and prime for each bit, create an 4-bit pseudorandom numbers sequence. 
--         Each bit's LFSR period should be mutually prime to all of the other bit LFSRs. 
--         Your design should employ an asynchronous set SET that sets all LFSR FFs. 

library IEEE;
use IEEE.std_logic_1164.all;

entity PSNG is 
    port (in_Clock, enable_bit : in std_logic;
          out_bits : OUT std_logic_vector(3 downto 0));
end PSNG;

architecture behavior of PSNG is 
    signal bits : std_logic_vector(3 downto 0) := "1001";

    component xor2
            port(In1, In2   : IN std_logic;
                 Out1       : OUT std_logic);
    end component xor2;

begin 
    if enable_bit = '1' then
        bits <= "1111";
    else 
        RAND_GENERATE : process(in_Clock)
        begin 
            U0: xor2 port map (In1 => bits(0), In2 => bits(3), Out1 => bits(2));
            U1: xor2 port map (In1 => bits(0), In2 => bits(2), Out1 => bits(1));
        end process;
    end if;
end behavior;


------------------------------
-- Description of xor2 gate --
------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity xor2 is  
    port (In1, In2 : IN std_logic;
          Out1     : OUT std_logic);
end xor2;

architecture rtl of xor2 is
    begin 
        Out1 <= In1 xor In2;
end architecture rtl;