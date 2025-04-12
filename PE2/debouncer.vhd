--Name: Ty Ahrens 
--Date: 4/12/2025
--Purpose: Debouncer for Channel A and B of rotary encoder. Takes in the noisy signal
--         and saves the signal input for each clock cycle to ensure that the signal
--         is stable.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debounce is
    Port (
        clk     : in  STD_LOGIC; -- DE10-Lite clock 
        noisy   : in  STD_LOGIC; -- Input from rotary encoder
        clean   : out STD_LOGIC  -- Debounced signal from this
    );
end Debounce;

architecture Behavioral of Debounce is
    constant debounce_limit : integer := 50000;  -- 1ms at 50MHz
    signal counter          : integer range 0 to debounce_limit := 0;
    signal debounced        : STD_LOGIC := '0';
    signal last_state       : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if noisy /= last_state then
                counter <= 0;
            else
                if counter < debounce_limit then
                    counter <= counter + 1;
                else
                    debounced <= noisy;
                end if;
            end if;
            last_state <= noisy;
        end if;
    end process;

    clean <= debounced;  -- set the debounced signal to output back to top_entity
end Behavioral;
