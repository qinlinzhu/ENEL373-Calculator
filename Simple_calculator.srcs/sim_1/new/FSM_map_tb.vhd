----------------------------------------------------------------------------------
-- Group 19
-- Module Name: FSM_map_tb - Behavioral
-- Description: 
-- Testbench to test the FSM module, tests all possibilities of the
-- inputs
-- 
-- Dependencies: 
-- FSM Clock Divider, SW, btn_debounce
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FSM_map_tb is
--  Port ( );
end FSM_map_tb;

architecture Behavioral of FSM_map_tb is
    component Finite_State_Machine port (clk : in STD_LOGIC;
           btns : in std_logic_vector(4 downto 0);
           SW : in std_logic_vector(15 downto 12);
           reset : out std_logic;
           latch_en: out std_logic;
           reg_en: out std_logic;
           alu_sel: out std_logic_vector(2 downto 0);
           tranny_sel: out std_logic_vector(1 downto 0);
           LED : out std_logic_vector (6 downto 0)
           );
    end component;
    
    constant ClockPeriod : TIME := 200 ns;
    signal clk : std_logic;
    signal reset, latch_en, reg_en : std_logic;
    signal tranny_sel: std_logic_vector(1 downto 0);
    signal alu_sel: std_logic_vector(2 downto 0);
    signal btns : std_logic_vector(4 downto 0);
    signal LED : std_logic_vector (6 downto 0);
    signal SW : std_logic_vector(15 downto 12);
    
begin
clock_process : process
begin 
    clk <= '0';
    wait for ClockPeriod / 2;
    clk <= '1';
    wait for ClockPeriod / 2;
end process;

testbench : Finite_State_Machine port map (SW => SW(15 downto 12), clk => clk, btns => btns, latch_en => latch_en, reg_en => reg_en,
                 alu_sel => alu_sel, tranny_sel => tranny_sel, reset => reset, LED => LED);

process
    begin
    -- Cycle through all btns
    btns <= "00100"; wait for 1 us;
    btns <= "00010"; wait for 1 us;
    btns <= "00100"; wait for 1 us;
    btns <= "00000"; wait for 1 us;
    -- Cycle through all operator switches
    SW <= "1000"; wait for 1 us;
    SW <= "0100"; wait for 1 us;
    SW <= "0010"; wait for 1 us;
    SW <= "0001"; wait for 1 us;
    SW <= "0000"; wait for 1 us;
    
    
    end process;
end Behavioral;











