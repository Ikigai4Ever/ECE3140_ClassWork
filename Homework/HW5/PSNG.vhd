--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: Using LFSRs with periods that are maximally-long and prime for each bit, create an 4-bit pseudorandom numbers sequence. 
--         Each bit's LFSR period should be mutually prime to all of the other bit LFSRs. 
--         Your design should employ an asynchronous set SET that sets all LFSR FFs. 

library IEEE;
use IEEE.std_logic_1164.all;

entity PSNG is 
    port (in_Clock, set_bit : in std_logic;
          rand_out : OUT std_logic_vector(3 downto 0));
end PSNG;

architecture behavior of PSNG is 
    signal LFSR1 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR2 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR3 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR4 : std_logic_vector(3 downto 0) := "1001";

begin 
    --use the Galois LFSRs in order to generate random numbers
    RAND_GENERATE : process(in_Clock, set_bit)
    begin 
        if rising_edge(in_Clock) then
            --generate random for bit0 of PSNG
            LFSR1(0) <= LFSR1(1);
            LFSR1(1) <= LFSR1(0) xor LFSR1(2);
            LFSR1(2) <= LFSR1(0) xor LFSR1(3);
            LFSR1(3) <= LFSR1(0);

            --generate random for bit1 of PSNG
            LFSR2(0) <= LFSR2(1);
            LFSR2(1) <= LFSR2(0) xor LFSR2(2);
            LFSR2(2) <= LFSR2(0) xor LFSR2(3);
            LFSR2(3) <= LFSR2(0);

            --generate random for bit2 of PSNG
            LFSR3(0) <= LFSR3(1);
            LFSR3(1) <= LFSR3(0) xor LFSR3(2);
            LFSR3(2) <= LFSR3(0) xor LFSR3(3);
            LFSR3(3) <= LFSR3(0);

            --generate random for bit3 of PSNG
            LFSR4(0) <= LFSR4(1);
            LFSR4(1) <= LFSR4(0) xor LFSR4(2);
            LFSR4(2) <= LFSR4(0) xor LFSR4(3);
            LFSR4(3) <= LFSR4(0);
        elsif set_bit = '1' then 
            LFSR1 <= "1001";
            LFSR2 <= "1001";
            LFSR3 <= "1001";
            LFSR4 <= "1001";
        end if;
    end process;

    rand_out <= LFSR4(0) & LFSR3(0) & LFSR2(0) & LFSR1(0);

end behavior;
