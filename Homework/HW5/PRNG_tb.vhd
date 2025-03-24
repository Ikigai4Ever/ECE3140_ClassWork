library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PRNG_tb is
end PRNG_tb;

architecture Behavioral of PRNG_tb is
    
    component PRNG is 
    port (in_Clock, set_bit : in std_logic;
          rand_out : OUT std_logic_vector(3 downto 0));
    end component;

    signal CLK : STD_LOGIC := '0';
    signal SET : STD_LOGIC := '0';
    signal RANDOM_OUT : STD_LOGIC_VECTOR(3 downto 0);
    
    constant CLK_PERIOD : time := 20 ns;

begin

    UUT: PRNG port map (in_Clock => CLK, set_bit => SET, rand_out => RANDOM_OUT);

    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;


    stimulus: process
    begin

        -- Test case 2: Set all LFSRs asynchronously and observe the sequence
        SET <= '1';
        wait for 20 ns;
        assert RANDOM_OUT = "1111" report "correct set for bits";
        SET <= '0';
        wait for 100 ns;
        assert RANDOM_OUT /= "1111" report "bits are now randomized again";

        -- Test case 3: Observe output for 30 clock cycles
        for i in 0 to 29 loop
            report "RANDOM_OUT = " & std_logic_vector'image(RANDOM_OUT);
            wait for CLK_PERIOD;
        end loop;

        wait;
    end process;

end Behavioral;
