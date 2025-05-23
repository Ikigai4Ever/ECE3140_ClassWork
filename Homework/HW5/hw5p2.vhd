--Name: Ty Ahrens 
--Date: 3/23/2025
--Purpose: behavioral architecture of problem 5.48 from Mano & Ciletti text

library IEEE;
use IEEE.std_logic_1164.all;

entity mealey_FSM is
  port (x, clockSwitch : IN std_logic;
        z : OUT std_logic;
        display : OUT std_logic_vector(6 downto 0));
end mealey_FSM;

architecture behavior of mealey_FSM is 

    subtype State_Type is std_logic_vector (1 downto 0);
        --define the different states by giving them a constant value IN VHDL ONLY
        constant a : State_Type := "00";
        constant b : State_Type := "01";
        constant c : State_Type := "10";
        constant d : State_Type := "11";

        --create signals for current and next state for memory
        signal Current_State : State_Type := a;
        signal Next_State : State_Type;
        
begin
    --state memory box to hold what the next state is 
    STATE_MEMORY : process(clockSwitch)
    begin 
        if clockSwitch = '1' then 
            Current_State <= Next_State;
		  end if;
    end process;

    --next state logic block 
    NEXT_STATE_LOGIC : process (Current_State, x) 
    begin 
        case Current_State is 
            when a =>   if x = '0' then Next_State <= b;
                        else Next_State <= c;
                        end if;
            when b =>   if x = '0' then Next_State <= c;
                        else Next_State <= d;
                        end if;
            when c =>   if x = '0' then Next_State <= b;
                        else Next_State <= d;
                        end if;
            when d =>   if x = '0' then Next_State <= c;
                        else Next_State <= a;
                        end if;
            --when others => Next_State <= a;
        end case;
    end process;

    --output logic block controlled by current state and input bc mealey
    OUTPUT_LOGIC : process (Current_State, x)
    begin 
        case Current_State is 
            when a =>   if x = '1' then z <= '0';
                        else z <= '1';
                        end if;
            when b =>   if x = '1' then z <= '1';
                        else z <= '0';
                        end if;
            when c =>   if x = '1' then z <= '1';
                        else z <= '0';
                        end if;
            when d =>   if x = '1' then z <= '0';
                        else z <= '1';
                        end if;
            when others => z <= '1';
        end case;
    end process;

    SEVENSEG : process (Current_State)
    begin   
        case Current_State is 
            when a =>   display <= "0001000";
            when b =>   display <= "1100000";
            when c =>   display <= "0110001";
            when d =>   display <= "1000010";
            when others => display <= "1111111";
        end case;
    end process;

end behavior; 