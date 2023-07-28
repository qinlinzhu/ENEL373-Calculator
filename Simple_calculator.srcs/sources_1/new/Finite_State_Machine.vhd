----------------------------------------------------------------------------------
-- Group 19
-- Module Name: Finite_State_Machine - Behavioral
-- Description: 
-- Takes in the input of buttons and switches on the fpga board and
-- sends the according signals to other modules
-- 
-- Dependencies: 
-- FSM Clock Divider, SW, btn_debounce
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Finite_State_Machine is
    Port ( clk : in STD_LOGIC;
           btns : in std_logic_vector(4 downto 0);
           SW : in std_logic_vector(15 downto 12);
           reset : out std_logic;
           latch_en: out std_logic;
           reg_en: out std_logic;
           alu_sel: out std_logic_vector(2 downto 0);
           tranny_sel: out std_logic_vector(1 downto 0);
           LED : out std_logic_vector (6 downto 0)
           );
           
end Finite_State_Machine;

architecture Behavioral of Finite_State_Machine is
 type m_states is (IDLE ,VAL1,VAL2, ADD, SUB, MULTIPLY, POWER);
 signal state : m_states;
 

begin
    process(clk, btns, SW)
    begin
        if (btns ="00100") then -- Center button
            state <= IDLE;
        end if;
        case btns is
            when "00010" => state <= VAL1; -- Left Button
            when "00001" => state <= VAL2; -- Right Button
            when others =>
                null;
        end case;
        
        case SW is
      
            when "1000" => state <= ADD; -- Most significant bit switch
            when "0100" => state <= SUB; -- Second most significant bit switch
            when "0010" => state <= MULTIPLY; -- Third " switch
            when "0001" => state <= POWER; -- Fourth switch
            when others =>
                null;
        end case;
        
        if (rising_edge (clk)) then
            case state is 
                when IDLE =>
                    reset <= '1';
                    LED <="0000001"; 
                    tranny_sel <="00";
                    alu_sel <="000";
                    
         
                
                 when VAL1 =>
                    reset <= '0';
                    LED <="0000010";
                    latch_en <= '1';
                    reg_en <= '0';
                    alu_sel <="000";
                    tranny_sel <="01";  
                    
                     
                        
                 when VAL2 =>
                    reset <= '0';
                    LED <="0000100";

                    latch_en <= '0';
                    reg_en <= '1';
                    
                    alu_sel <="000";
                    tranny_sel <="10"; 
                   
                
                    
                  when ADD =>
                    reset <= '0';
                    LED <="0001000"; 
                    alu_sel <="001";
                    tranny_sel <="11";
                 
                    
                     
                        
                  when SUB =>
                    reset <= '0';
                    LED <="0010000";
                    alu_sel <="010";
                    tranny_sel <="11";
                    
                    
                  when MULTIPLY =>
                    reset <= '0';
                    LED <="0100000";
                    alu_sel <="011";
                    tranny_sel <="11";
                   
                    
                  when POWER =>
                    reset <= '0';
                    LED <="1000000";
                    alu_sel <="100";
                    tranny_sel <="11";
              
                  when others =>
                    reset <= '0';
                    null;
                  
            end case;
          end if;
    end process;
    

end Behavioral;
