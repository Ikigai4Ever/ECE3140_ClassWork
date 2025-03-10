library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Declare the entity and architecture
entity tb_hw4p1 is
end tb_hw4p1;

architecture behavior of tb_hw4p1 is

  -- Component Declaration for the Unit Under Test (UUT)
  component hw4p1
    port (
      SW3, SW2, SW1, SW0 : in std_logic;
      KEY0, KEY1          : in std_logic;
      LEDR0, LEDR9        : out std_logic
    );
  end component;

  -- Signals for the inputs and outputs of the UUT
  signal SW3, SW2, SW1, SW0 : std_logic := '0';
  signal KEY0, KEY1         : std_logic := '0';
  signal LEDR0, LEDR9       : std_logic;

begin

  -- Instantiate the UUT (Unit Under Test)
  uut: hw4p1 port map (
    SW3 => SW3,
    SW2 => SW2,
    SW1 => SW1,
    SW0 => SW0,
    KEY0 => KEY0,
    KEY1 => KEY1,
    LEDR0 => LEDR0,
    LEDR9 => LEDR9
  );

  -- Stimulus process
  stim_proc: process
  begin
    -- Test case 1: Default inputs (SW3-SW0 = 0000, KEY0 = '0', KEY1 = '0')
    SW3 <= '0'; SW2 <= '0'; SW1 <= '0'; SW0 <= '0'; KEY0 <= '0'; KEY1 <= '0';
    wait for 10 ns;
    assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 1 Failed!" severity error;

    -- Test case 2: KEY0 pressed (blank LEDs)
    KEY0 <= '1';
    wait for 10 ns;
    assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 2 Failed!" severity error;

    -- Test case 3: KEY1 pressed, inputs SW3-SW0 = 0000
    KEY0 <= '0'; KEY1 <= '1';
    wait for 10 ns;
    assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 3 Failed!" severity error;

    -- Test case 4: KEY1 pressed, inputs SW3-SW0 = 1111 (complemented)
    SW3 <= '1'; SW2 <= '1'; SW1 <= '1'; SW0 <= '1';
    wait for 10 ns;
    assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 4 Failed!" severity error;

    -- Test case 5: Test different combinations of SW3-SW0
    SW3 <= '1'; SW2 <= '0'; SW1 <= '1'; SW0 <= '0';
    wait for 10 ns;
    assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 5 Failed!" severity error;

    -- Test case 6: All SW inputs high (SW3-SW0 = 1111)
    SW3 <= '1'; SW2 <= '1'; SW1 <= '1'; SW0 <= '1';
    wait for 10 ns;
    assert (LEDR0 = '1' and LEDR9 = '1') report "Test Case 6 Failed!" severity error;

    -- Test case 7: Test the logic when KEY0 is not pressed (KEY0 = '0')
    KEY0 <= '0'; KEY1 <= '0';
    wait for 10 ns;
    assert (LEDR0 = '0' and LEDR9 = '0') report "Test Case 7 Failed!" severity error;

    -- End of simulation
    wait;
  end process;

end behavior;
