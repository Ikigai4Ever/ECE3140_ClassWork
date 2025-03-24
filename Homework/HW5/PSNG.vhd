--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: Using LFSRs with periods that are maximally-long and prime for each bit, create an 4-bit pseudorandom numbers sequence. 
--         Each bit's LFSR period should be mutually prime to all of the other bit LFSRs. 
--         Your design should employ an asynchronous set SET that sets all LFSR FFs. 

library IEEE;
use IEEE.std_logic_1164.all;

entity PSNG is 
    port (in_Clock, set_bit : in std_logic;
          out_bits : OUT std_logic_vector(3 downto 0));
end PSNG;

architecture behavior of PSNG is 
    signal bits : std_logic_vector(3 downto 0) := "1001";

begin 
    --use the Galois LFSRs in order to generate random numbers
    RAND_GENERATE : process(in_Clock, set_bit)
    begin 
        if rising_edge(in_Clock) then
            bits(0) <= bits(1);
            bits(1) <= bits(0) xor bits(2);
            bits(2) <= bits(0) xor bits(3);
            bits(3) <= bits(0);
        elsif set_bit = '1' then 
            bits <= "1111";
        end if;
    end process;
end behavior;
