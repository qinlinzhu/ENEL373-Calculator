----------------------------------------------------------------------------------
-- Group 19
-- Module Name: ALU_tb - Behavioral
-- Description: 
-- Testbench to test the ALU module, takes in two operands -15, and 16 
-- and applies the four different operators onto the operands.
-- 
-- Dependencies: 
-- FSM Clock Divider, Finite State Machine, D_Latches
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
    component ALU port ( A : in std_logic_vector (11 downto 0);
           B : in std_logic_vector (11 downto 0);
           SEL : in std_logic_vector (2 downto 0);
           reset : in std_logic;
           clk : in std_logic;
           out_d : out std_logic_vector (24 downto 0)
           );
    end component;


    constant ClockPeriod : TIME := 200 ns;
    signal clk : std_logic;
    signal reset : std_logic;
    signal SEL: std_logic_vector (2 downto 0);
    signal A, B : std_logic_vector (11 downto 0);
    signal out_d : std_logic_vector (24 downto 0);
    
begin
clock_process : process
begin 
    clk <= '0';
    wait for ClockPeriod / 2;
    clk <= '1';
    wait for ClockPeriod / 2;
end process;

testbench : ALU port map (A => A, B => B, SEL => SEL, reset => reset, 
                clk => clk, out_d => out_d);  

process 
    begin 

    A <= (others=>'0');
    A(11) <= '1';
    A(3 downto 0) <= "1111"; -- A = -15
    B <= (others=>'0');
    B(4) <= '1'; -- B = 16
    SEL <= "001"; wait for 1us;

    SEL <= "010"; wait for 1us;

    SEL <= "011"; wait for 1us;

    SEL <= "100"; wait for 1us;
    end process;
end Behavioral;













