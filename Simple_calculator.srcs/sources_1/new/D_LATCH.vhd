----------------------------------------------------------------------------------
-- Group 19
-- Module Name: D_LATCH - Behavioral
-- Description: 
-- A simple latch module with a reset mechanism
-- 
-- Dependencies: 
-- FSM, SW
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_LATCH is
    Port ( D : in std_logic_vector(11 downto 0);
           EN : in  STD_LOGIC;
           reset: in std_logic;
           Q  : out std_logic_vector(11 downto 0)
           );
end D_LATCH;

architecture Behavioral of D_LATCH is
begin

    process (EN, D)
    begin
        if reset = '1' then
            Q <= (others => '0');
        else
            if (EN = '1') then
              Q <= D;
            end if;
        end if;
    end process;

end Behavioral;

