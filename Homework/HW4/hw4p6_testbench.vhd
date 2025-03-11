--Name: Ty Ahrens 
--Date: 3/11/2025
--Purpose: testbench for hw4p6 homework problem to test functionality of different 
--         switches, buttons, and seven segment states.

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_bin2seg7 is
end tb_bin2seg7;

architecture testbench of tb_bin2seg7 is
    -- Component declaration
    component bin2seg7
        port(
            inData    : IN std_logic_vector(3 downto 0);
            blanking  : IN std_logic;
            dispHex   : IN std_logic;
            dispPoint : IN std_logic;
            segA, segB, segC, segD, segE, segF, segG : OUT std_logic;
            segPoint  : OUT std_logic
        );
    end component;

    -- Signals for testbench
    signal inData    : std_logic_vector(3 downto 0);
    signal blanking  : std_logic;
    signal dispHex   : std_logic;
    signal dispPoint : std_logic;
    signal segA, segB, segC, segD, segE, segF, segG : std_logic;
    signal segPoint  : std_logic;
    
begin
    -- DUT (Device Under Test)
    UUT: bin2seg7 port map (inData => inData, blanking => blanking, dispHex => dispHex, dispPoint => dispPoint,
        segA      => segA,
        segB      => segB,
        segC      => segC,
        segD      => segD,
        segE      => segE,
        segF      => segF,
        segG      => segG,
        segPoint  => segPoint
    );

    -- Test process
    process
    begin
        -- Test Case 1: Blanking active (all segments off)
        inData <= "0000"; blanking <= '1'; dispHex <= '1'; dispPoint <= '1';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "1111111")
            report "Error: Expected blank display" severity failure;
        assert (segPoint = '0')
            report "Error: Decimal point should be OFF during blanking" severity failure;

        -- Test Case 2: Display "0" (0x0)
        inData <= "0000"; blanking <= '0'; dispHex <= '1'; dispPoint <= '1';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "0000001")
            report "Error: Expected display '0'" severity failure;
        assert (segPoint = '1')
            report "Error: Decimal point should be ON" severity failure;

        -- Test Case 3: Display "1" (0x1)
        inData <= "0001"; blanking <= '0'; dispHex <= '1'; dispPoint <= '0';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "1001111")
            report "Error: Expected display '1'" severity failure;
        assert (segPoint = '0')
            report "Error: Decimal point should be OFF" severity failure;

        -- Test Case 4: Display "9" (0x9)
        inData <= "1001"; blanking <= '0'; dispHex <= '1'; dispPoint <= '1';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "0001100")
            report "Error: Expected display '9'" severity failure;
        assert (segPoint = '1')
            report "Error: Decimal point should be ON" severity failure;

        -- Test Case 5: Display "A" (0xA) with dispHex = 1 (should display 'A')
        inData <= "1010"; blanking <= '0'; dispHex <= '1'; dispPoint <= '0';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "0001000")
            report "Error: Expected display 'A'" severity failure;

        -- Test Case 6: Display "A" (0xA) with dispHex = 0 (should be blank)
        inData <= "1010"; blanking <= '0'; dispHex <= '0'; dispPoint <= '1';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "1111111")
            report "Error: Expected blank for A-F when dispHex=0" severity failure;
        assert (segPoint = '1')
            report "Error: Decimal point should be ON" severity failure;

        -- Test Case 7: Display "F" (0xF) with dispHex = 1
        inData <= "1111"; blanking <= '0'; dispHex <= '1'; dispPoint <= '0';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "0111000")
            report "Error: Expected display 'F'" severity failure;

        -- Test Case 8: Display "F" (0xF) with dispHex = 0 (should be blank)
        inData <= "1111"; blanking <= '0'; dispHex <= '0'; dispPoint <= '0';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "1111111")
            report "Error: Expected blank for F when dispHex=0" severity failure;

        -- Test Case 9: KEY0 Pressed (Blanking ON)
        inData <= "0011"; blanking <= '1'; dispHex <= '1'; dispPoint <= '1';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "1111111")
            report "Error: Expected blank display when blanking active" severity failure;

        -- Test Case 10: All OFF
        inData <= "0000"; blanking <= '0'; dispHex <= '1'; dispPoint <= '0';
        wait for 10 ns;
        assert (segA & segB & segC & segD & segE & segF & segG = "0000001")
            report "Error: Expected display '0'" severity failure;

        -- End of Test
        report "Testbench completed successfully." severity note;
        wait;
    end process;

end testbench;
