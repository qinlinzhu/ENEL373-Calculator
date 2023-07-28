----------------------------------------------------------------------------------
-- Group 19
-- Module Name: mux_dual_4_to_1 - Behavioral
-- Description: 
-- decides which 7-segment display to turn on and sends the value of the 
-- selected 7-segment display value to BCD_to_7SEG.
-- 
-- Dependencies: 
-- bin_to_bcd, counter
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_dual_4_to_1 is
    Port ( curr_count, curr_count2, curr_count3, curr_count4,curr_count5,curr_count6,curr_count7 : in STD_LOGIC_VECTOR (3 downto 0);
            negative_in : in std_logic;
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           AN : out std_logic_vector(7 downto 0);
           num_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
end mux_dual_4_to_1;

architecture Behavioral of mux_dual_4_to_1 is

begin
  p1: process(curr_count, curr_count2, curr_count3, curr_count4,curr_count5,curr_count6,curr_count7,negative_in, sel)
    begin
      if sel = "000" then 
        num_out <= curr_count(3 downto 0);
        AN <= "11111110"; 
      elsif sel = "001" then
        num_out <= curr_count2(3 downto 0);
        AN <= "11111101";
      elsif sel = "010" then
        num_out <= curr_count3(3 downto 0);
        AN <= "11111011";
      elsif sel = "011" then
        num_out <= curr_count4(3 downto 0);
        AN <= "11110111";
      elsif sel = "100" then
        num_out <= curr_count5(3 downto 0);
        AN <= "11101111";
      elsif sel = "101" then
        num_out <= curr_count6(3 downto 0);
        AN <= "11011111";
      elsif sel = "110" then
        num_out <= curr_count7(3 downto 0);
        AN <= "10111111";
      elsif sel = "111" then
        AN <= "01111111";      
        if negative_in = '1' then
            num_out <= "1010";
            
        else
            AN <= "11111111";
        end if;
    
   
      end if;
    end process;  

end Behavioral;
