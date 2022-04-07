library IEEE;
use ieee.std_logic_1164.all;

ENTITY Logical IS
  GENERIC ( n : INTEGER := 8;
			k : integer := 3);     -- k=log2(n)
  PORT (    ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Selection := [0,0,0]=not,[0,0,1]=or, [0,1,0]= and, [0,1,1]= xor, [1,0,0]=nor, [1,0,1]=nand. 
			y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0); -- Input
            x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0); -- Input
            result: OUT STD_LOGIC_VECTOR(n-1 downto 0)); -- Result
END Logical;
---------------------------------------------------------------
ARCHITECTURE dfl OF Logical IS
begin
-- The boolean Logic is in Documentation
    case ALUFN is
    when "000" => 
        result <= not(y);
    when "001" =>
        result <= x or y;
    when "010" =>
        result <= x and y;
    when "011" =>
        result <= x xor y;
    when "100" =>
        result <= x nor y;
    when "101" => 
        result <= x nand y;
    when others =>
        result <= (others => '0');
    end case;   
end dfl;

