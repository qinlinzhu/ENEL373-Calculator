----------------------------------------------------------------------------------
-- Group 19
-- Module Name: transfer_reg - Behavioral
-- Description: 
-- A transfer register to direct the bin_to_bcd to display the correct 
-- information. 
-- 
-- Dependencies: 
-- ALU, D_LATCH, FSM Clock Divider, bin_to_bcd 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transfer_reg is
    Port ( l_in : in STD_LOGIC_VECTOR (11 downto 0);
           r_in : in STD_LOGIC_VECTOR (11 downto 0);
           a_in : in STD_LOGIC_VECTOR (24 downto 0);
           clk : in std_logic;
           start : out std_logic;
           ready : in std_logic;
           en : in std_logic_vector(1 downto 0);
           d_out : out STD_LOGIC_VECTOR (24 downto 0));
end transfer_reg;

architecture Behavioral of transfer_reg is
    signal trannied : STD_LOGIC_VECTOR (24 downto 0);
    signal rst_sync : std_logic;

begin
    process (clk)
        begin
            if rising_edge(clk) then
                
                if rst_sync = '1' then
                    trannied <= (others=>'0');
                    d_out <= trannied;
                    start <= '0';
                     
                else
                    
                    case(EN) is  
                    when "00" => -- Show nothing
                        trannied <= (others=>'0');
                        trannied(24) <= '0';
                        start <= '1';  
                        d_out <= trannied;    
                                       
                    when "01" => -- Show Val1
                        trannied(24) <= l_in(11);
                        trannied(10 downto 0) <= l_in(10 downto 0);
                        start <= '1';
                        d_out <= trannied;
                    when "10" => -- Show Val2
                        trannied(24) <= r_in(11);
                        trannied(10 downto 0) <= r_in(10 downto 0);
                        start <= '1';
                        d_out <= trannied;
                    when "11" => -- Show calculated value
                        trannied <= a_in;
                        start <= '1';
                        d_out <= trannied;
                    when others =>
                        trannied <= (others=>'0');
                        start <= '1';
                        d_out <= trannied;
                    end case;
                end if;

            end if;
    end process;

    
    process (clk)
    begin 
        if rising_edge(clk) then
            if ready = '1' then
                rst_sync <= '0';
            else 
                rst_sync <= '1';
            end if;
        end if;
        
    end process;
              
end Behavioral;
