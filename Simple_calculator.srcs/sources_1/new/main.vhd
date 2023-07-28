----------------------------------------------------------------------------------
-- Group 19
-- Module Name: main - Behavioral
-- Description: 
-- The main file which links all modules together according to the design
-- 
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port ( SW : in STD_LOGIC_VECTOR(15 downto 0);
           CLK100MHZ : in STD_LOGIC;
           BTNC, BTNU, BTNL, BTNR, BTND: in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out std_logic_vector (6 downto 0);
           CA, CB, CC, CD, CE, CF, CG : out STD_LOGIC);
    
end main;

architecture Behavioral of main is

    component counter 
        port (  clk      : in std_logic;
                count    : out std_logic_vector (2 downto 0));
    end component;
    
    
    component BCD_to_7SEG
      Port ( bcd_in: in std_logic_vector (3 downto 0);	-- Input BCD vector
             leds_out: out	std_logic_vector (1 to 7));	-- Output 7-Seg vector 
    end component;
    
    
    component mux_dual_4_to_1
      Port ( curr_count, curr_count2, curr_count3, curr_count4,curr_count5,curr_count6,curr_count7 : in STD_LOGIC_VECTOR (3 downto 0);
            negative_in : in std_logic;
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           AN : out std_logic_vector(7 downto 0);
           num_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;
    

    
    
    component  D_LATCH is
    Port ( D : in std_logic_vector(11 downto 0);
           EN : in  STD_LOGIC;
           reset : in std_logic;
           Q  : out std_logic_vector(11 downto 0)
           );
    end component;
    
    component shift_reg is
    Port ( clk : in STD_LOGIC;
           s : in std_logic;
           r : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (11 downto 0);
           ff_r : out STD_LOGIC;
           q : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    
    
    component Finite_State_Machine
    Port ( clk : in STD_LOGIC;
           btns : in std_logic_vector(4 downto 0);
           SW : in std_logic_vector(15 downto 12);
           latch_en: out std_logic;
           reg_en: out std_logic;
           reset : out std_logic;
           alu_sel: out std_logic_vector(2 downto 0);
           tranny_sel: out std_logic_vector(1 downto 0);
           LED : out std_logic_vector (6 downto 0)
           );
       
    end component;
    
    component ALU
    Port ( A : in std_logic_vector (11 downto 0);
           B : in std_logic_vector (11 downto 0);
           SEL : in std_logic_vector (2 downto 0);
           clk : in std_logic;
           reset : in std_logic;
           out_d : out std_logic_vector (24 downto 0));
    end component;
    
    
    component transfer_reg is
    Port ( l_in : in STD_LOGIC_VECTOR (11 downto 0);
           r_in : in STD_LOGIC_VECTOR (11 downto 0);
           a_in : in STD_LOGIC_VECTOR (24 downto 0);
           clk : in std_logic;
           ready : in std_logic;
           start : out std_logic;
           en : in std_logic_vector(1 downto 0);
           d_out : out STD_LOGIC_VECTOR (24 downto 0));
    end component;
    
   component btn_debounce is
    Port ( clk : in STD_LOGIC;
           C,D,U,L,R: in STD_LOGIC;
           Q : out STD_LOGIC_vector(4 downto 0));
    end component;
    
    signal btns:std_logic_vector(4 downto 0);
    signal ff_signal,ff_rsig, reset, ready, clk1, start, binbcd_clk, fsm_clk, mux_clk, reg_signal, negative_sig:std_logic;
    signal bcd_out:std_logic_vector (3 downto 0);
    signal tranny_sig : std_logic_vector (1 downto 0);
    signal alu_signal,selct: std_logic_vector (2 downto 0);
    signal reg_temp, shift_temp:std_logic_vector (11 downto 0);
    signal result_temp, bin_temp : std_logic_vector (24 downto 0);
    signal bcd_temp:std_logic_vector (27 downto 0);
    

begin
    ClockDivider_MAIN: entity work.clock_divider
        GENERIC MAP (INPUT_FREQUENCY => 100000000, OUTPUT_FREQUENCY => 1000)
        PORT MAP (in_clock => CLK100MHZ, enable => '1', out_clock => clk1);
    ClockDivider_MUX: entity work.clock_divider
        GENERIC MAP (INPUT_FREQUENCY => 100000000, OUTPUT_FREQUENCY => 2000)
        PORT MAP (in_clock => CLK100MHZ, enable => '1', out_clock => mux_clk);
        
    ClockDivider_BINBCD: entity work.clock_divider
        GENERIC MAP (INPUT_FREQUENCY => 100000000, OUTPUT_FREQUENCY => 100000) 
        PORT MAP (in_clock => CLK100MHZ, enable => '1', out_clock => binbcd_clk);
        
    ClockDivider_FSM: entity work.clock_divider
        GENERIC MAP (INPUT_FREQUENCY => 100000000, OUTPUT_FREQUENCY => 5000) 
        PORT MAP (in_clock => CLK100MHZ, enable => '1', out_clock => fsm_clk);
        
    debounce_btnc : btn_debounce port map(clk => CLK100MHZ, C => BTNC,D => BTND,U => BTNU,L=>BTNL,R=>BTNR, Q => btns);
 
    FSM_map : Finite_State_Machine port map (SW => SW(15 downto 12), clk => fsm_clk, btns => btns, latch_en => ff_signal, reg_en => reg_signal, alu_sel => alu_signal, tranny_sel => tranny_sig, reset => reset, LED => LED);
    
    Reg : D_LATCH port map(reset => reset, D => SW(11 downto 0), EN => ff_signal, Q => reg_temp);
    
    Reg2 : D_LATCH port map(reset => reset, D => SW(11 downto 0), EN => reg_signal, Q => shift_temp);
    
    Reg3 : transfer_reg port map (ready => ready, start => start, clk => fsm_clk, l_in =>reg_temp, r_in => shift_temp, a_in => result_temp, en =>tranny_sig, d_out => bin_temp);
    
    ALU_map : ALU port map (reset => reset, clk => fsm_clk, A => reg_temp, B => shift_temp, sel => alu_signal, out_d => result_temp);
   
   
    Bin_to_BCD: entity work.bin_to_bcd
        PORT MAP (reset => '0', clock => binbcd_clk, start => start, bin => bin_temp, bcd => bcd_temp, negative_out => negative_sig, ready => ready);
  
    Sel_map: counter port map(clk =>mux_clk, count=>selct);
    Multiplexer_map : mux_dual_4_to_1 port map(negative_in => negative_sig, curr_count => bcd_temp(3 downto 0), curr_count2 => bcd_temp(7 downto 4), curr_count3 => bcd_temp(11 downto 8), curr_count4 => bcd_temp(15 downto 12), 
                                                curr_count5 => bcd_temp(19 downto 16), curr_count6 => bcd_temp(23 downto 20), curr_count7 => bcd_temp(27 downto 24),sel => selct, num_out => bcd_out, AN => AN);
    

    segment_map : BCD_to_7SEG port map(bcd_in => bcd_out, leds_out(1) => CA, leds_out(2) => CB, leds_out(3) => CC, leds_out(4) => CD, leds_out(5) => CE,leds_out(6) => CF, leds_out(7) => CG);

end Behavioral;
