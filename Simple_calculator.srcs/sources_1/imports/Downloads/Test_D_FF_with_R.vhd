----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2018 07:33:38 AM
-- Design Name: 
-- Module Name: Test_D_FF_with_Reset plus ENable - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_D_FF_with_R is
    Port ( R : in STD_LOGIC; -- reset 
           D : in std_logic_vector(11 downto 0); -- data binary
           EN : in STD_LOGIC; -- enable
           clk : in STD_LOGIC; -- clock
           Q : out std_logic_vector(11 downto 0)
           ); -- output
end Test_D_FF_with_R;

architecture Behavioral of Test_D_FF_with_R is

begin
  process (clk, R, EN)
    begin
     if R = '1' then 
       Q <= "000000000000" after 5 ns;    
     elsif rising_edge(clk) then
      if EN = '1' then -- when enable is true output everything in d into output
        Q <= D after 5 ns;
      else
        NULL;
      end if;
    end if;
    
  end process;

-- FF plus tristate output  
--  ff : process(CLK)
--  begin
--  if rising_edge(CLK) then
--  Q0 <= D;
--  end if;
--  end process ff;
  
--  Q <= 'Z' when OE = '0' else Q;

end Behavioral;
