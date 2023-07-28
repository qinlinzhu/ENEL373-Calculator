----------------------------------------------------------------------------------
-- Group 19
-- Module Name: ALU - Behavioral
-- Description: 
-- Calculates the operands depending on which SEL line was chosen.
-- Outputs the calculated value
-- 
-- Dependencies: 
-- FSM Clock Divider, Finite State Machine, D_Latches
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( A : in std_logic_vector (11 downto 0);
           B : in std_logic_vector (11 downto 0);
           SEL : in std_logic_vector (2 downto 0);
           reset : in std_logic;
           clk : in std_logic;
           out_d : out std_logic_vector (24 downto 0));
end ALU;

architecture Behavioral of ALU is
signal result : std_logic_vector (24 downto 0);
signal rst_sync : std_logic;
constant MAX_B : integer := 24;
  


begin
    process (clk)
    begin 
        if rising_edge(clk) then
            if reset = '1' then
                rst_sync <= '1';
            else 
                rst_sync <= '0';
            end if;
        end if;
        
    end process;
    process(A, B, SEL)
        variable a_unsigned : unsigned(21 downto 0);
        variable b_unsigned : unsigned(21 downto 0);
        variable product : unsigned(21 downto 0);
        variable temp : unsigned(21 downto 0);
        variable a_unsigned_short : unsigned(10 downto 0);
        variable b_unsigned_short : unsigned(10 downto 0);

        
    
    begin 
        a_unsigned:= "00000000000" & unsigned(A(10 downto 0));
        b_unsigned := "00000000000" & unsigned(B(10 downto 0));
        a_unsigned_short := unsigned(A(10 downto 0));
        b_unsigned_short := unsigned(B(10 downto 0));


    case(SEL) is
    when "000" => -- Non operating select line
        if rst_sync = '1' then
            a_unsigned := (others => '0');
            b_unsigned := (others => '0');
            a_unsigned_short := (others => '0');
            b_unsigned_short := (others => '0');
        end if;
    when "001" => -- Add numbers together
        
        result <= (others => '0');
        if A(11) = '1' and B(11) = '1' then
            result(24) <= '1';
            result(21 downto 0) <= std_logic_vector(a_unsigned + b_unsigned);
        elsif A(11) = '0' and B(11) = '0' then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(a_unsigned + b_unsigned);
        else
            if (A(10 downto 0) < B(10 downto 0)) and (A(11) = '1') then
                result(24) <= '0';
                result(21 downto 0) <= std_logic_vector(b_unsigned - a_unsigned);
                
            elsif (A(10 downto 0) < B(10 downto 0)) and (B(11) = '1') then
                result(24) <= '1';
                result(21 downto 0) <= std_logic_vector(b_unsigned - a_unsigned);
            
            elsif (A(10 downto 0) > B(10 downto 0)) and (A(11) = '1') then
                result(24) <= '1';
                result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
                
            elsif (A(10 downto 0) > B(10 downto 0)) and (B(11) = '1') then
                result(24) <= '0';
                result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
            elsif (A(10 downto 0) = B(10 downto 0)) then
                result(24) <= '0';
                result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
            end if;
        end if;
        

    when "010" => -- Subtract first value with the second value
        result <= (others => '0');
        if (A(11) = '1' and B(11) = '1') and (A(10 downto 0) < B(10 downto 0)) then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(b_unsigned - a_unsigned);
        elsif (A(11) = '1' and B(11) = '1') and (A(10 downto 0) > B(10 downto 0)) then
            result(24) <= '1';
            result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
        elsif (A(11) = '1' and B(11) = '1') and (A(10 downto 0) = B(10 downto 0)) then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
            
        elsif (A(11) = '0' and B(11) = '0') and (A(10 downto 0) < B(10 downto 0)) then
            result(24) <= '1';
            result(21 downto 0) <= std_logic_vector(b_unsigned - a_unsigned);
        elsif (A(11) = '0' and B(11) = '0') and (A(10 downto 0) > B(10 downto 0)) then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
            
        elsif (A(11) = '0' and B(11) = '0') and (A(10 downto 0) = B(10 downto 0)) then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(a_unsigned - b_unsigned);
            
        elsif (A(11) = '1') then
            result(24) <= '1';
            result(21 downto 0) <= std_logic_vector(b_unsigned + a_unsigned);
            
        elsif (B(11) = '1') then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(b_unsigned + a_unsigned);
            
        end if;
        
    when "011" => -- multiply the two values together
        result <= (others => '0');
        product := a_unsigned_short * b_unsigned_short;
        if (A(11) = '0' and B(11) = '0') or (A(11) = '1' and B(11) = '1') then
            result(24) <= '0';
            result(21 downto 0) <= std_logic_vector(product);
            
        else
            result(24) <= '1';
            result(21 downto 0) <= std_logic_vector(product);
        end if;
        
    when "100" => -- the absolute value of the first value
        result <= (others => '0');
        result(24) <= '0';
        result(23 downto 0) <= std_logic_vector(to_unsigned((to_integer(a_unsigned)),24));
        

    when others =>
        null;
    
    
    end case;
    out_d <= result;
    
    end process;
    
    
end Behavioral;

