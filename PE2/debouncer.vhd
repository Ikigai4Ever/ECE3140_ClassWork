library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debounce is
    Port (
        clk     : in  STD_LOGIC;
        noisy   : in  STD_LOGIC;
        clean   : out STD_LOGIC
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

    clean <= debounced;
end Behavioral;
