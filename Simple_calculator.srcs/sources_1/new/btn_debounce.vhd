----------------------------------------------------------------------------------
-- Group 19
-- Module Name: btn_debounce - Behavioral
-- Description: 
-- Takes in the inputs of the button on the FPGA board and sends 
-- a chosen std_logic_vector signal to the FSM module
-- 
-- Dependencies: 
-- CLK100MHZ, BTNC, BTND, BNTL, BTNR, BTNU
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_debounce is
    Port ( clk : in STD_LOGIC;
           C,D,U,L,R: in STD_LOGIC;
           Q : out STD_LOGIC_vector(4 downto 0));
end btn_debounce;

architecture Behavioral of btn_debounce is
signal temp : std_logic_vector(4 downto 0);
begin

    process(clk)
    begin
     if(rising_edge(clk)) then
       if C ='1' then
            temp <= "00100";
       elsif D ='1' then
            temp <= "10000";
       elsif U ='1' then
            temp <= "01000";
       elsif L ='1' then
            temp <= "00010";
       elsif R ='1' then
            temp <= "00001";
       
       end if;
     
     end if;
    end process;
    Q <= temp;
end Behavioral;
