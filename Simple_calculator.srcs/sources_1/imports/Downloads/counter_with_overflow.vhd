----------------------------------------------------------------------------------
-- Group 19
-- Module Name: counter_with_overflow - Behavioral
-- Description: 
-- Counter that counts up to 8 which acts as the select line for the mux
-- to turn on a 7-seg display.
-- 
-- Dependencies: 
-- MUX Clock Divider
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    port (
        clk      : in std_logic;
        count    : out std_logic_vector (2 downto 0);
        overflow : out std_logic);
end counter;

architecture Behavioral of counter is
    constant MAX_COUNT : integer := 8;
begin
    process (clk)
        variable counter : integer range 0 to MAX_COUNT := 0;
    begin
        if rising_edge(clk) then
            if counter = MAX_COUNT then
                -- Reset counter and assert overflow
                counter := 0;
             ----assert overflow here--
            else
                -- Increment counter and reset overflow
                counter := counter + 1;
              --reset overflow here---
            end if;

            -- Convert value of counter to std_logic_vector
            count <= std_logic_vector(to_unsigned(counter, count'length));
        end if;
    end process;
end Behavioral;