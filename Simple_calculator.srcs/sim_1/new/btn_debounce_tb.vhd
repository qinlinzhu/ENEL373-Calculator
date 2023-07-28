----------------------------------------------------------------------------------
-- Group 19
-- Module Name: btn_debounce_tb - Behavioral
-- Description: 
-- Testbench to test the btn_debounce module, tests all possibilities of
-- the inputs
-- 
-- Dependencies: 
-- CLK100MHZ, BTNC, BTND, BNTL, BTNR, BTNU
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_debounce_tb is
--  Port ( );
end btn_debounce_tb;

architecture Behavioral of btn_debounce_tb is
    component btn_debounce port ( clk : in STD_LOGIC;
           C,D,U,L,R: in STD_LOGIC;
           Q : out STD_LOGIC_vector(4 downto 0));
    end component;
    
    constant ClockPeriod : TIME := 10 ns; -- 100MHZ
    signal clk : std_logic;
    signal C,D,U,L,R: STD_LOGIC := '0';
    signal Q : STD_LOGIC_vector(4 downto 0);
    
    
begin
clock_process: process
begin 

    clk <= '0';
    wait for ClockPeriod / 2;
    clk <= '1';
    wait for ClockPeriod / 2;
end process;

testbench : btn_debounce port map (clk => clk, C => C, D => D, U => U, L => L, R => R, Q => Q);

process 
    begin
    C <= '1'; wait for 50 ns;
    C <= '0';
    D <= '1'; wait for 50 ns;
    D <= '0';
    U <= '1'; wait for 50 ns;
    U <= '0';
    L <= '1'; wait for 50 ns;
    L <= '0';
    R <= '1'; wait for 50 ns;
    R <= '0';
    end process;
end Behavioral;























