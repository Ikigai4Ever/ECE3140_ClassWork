--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: 

library IEEE;
use IEEE.std_logic_1164.all;

entity hw5p4 is 
    port(KEY    : IN std_logic_vector(1 downto 0);
         SW0     : IN std_logic;
         feedback_pin   : OUT std_logic);
end hw5p4;

architecture behavior of hw5p4 is 
    constant f : std_logic := "1000000";

begin 
    signal LFSR1 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR2 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR3 : std_logic_vector(3 downto 0) := "1001";
    signal LFSR4 : std_logic_vector(3 downto 0) := "1001";

begin 
    --use the Galois LFSRs in order to generate random numbers
    RAND_GENERATE : process(in_Clock, set_bit)
    begin 
        if rising_edge(in_Clock) then
            --generate random for bit0 of PRNG
            LFSR1(0) <= LFSR1(1);
            LFSR1(1) <= LFSR1(2);
            LFSR1(2) <= LFSR1(3);
            LFSR1(3) <= LFSR1(3) xor LFSR1(2);

            --generate random for bit1 of PRNG
            LFSR2(0) <= LFSR2(1);
            LFSR2(1) <= LFSR2(2);
            LFSR2(2) <= LFSR2(3);
            LFSR2(3) <= LFSR2(3) xor LFSR2(1);

            --generate random for bit2 of PRNG
            LFSR3(0) <= LFSR3(1);
            LFSR3(1) <= LFSR3(2);
            LFSR3(2) <= LFSR3(3);
            LFSR3(3) <= LFSR3(2) xor LFSR3(0);

            --generate random for bit3 of PRNG
            LFSR4(0) <= LFSR4(1);
            LFSR4(1) <= LFSR4(2);
            LFSR4(2) <= LFSR4(3);
            LFSR4(3) <= LFSR4(1) xor LFSR4(0);
        elsif set_bit = '1' then 
            LFSR1 <= "1001";
            LFSR2 <= "1001";
            LFSR3 <= "1001";
            LFSR4 <= "1001";
        end if;
    end process;

    rand_out <= LFSR4(0) & LFSR3(0) & LFSR2(0) & LFSR1(0);

end behvaior;
