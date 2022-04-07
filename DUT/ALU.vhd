library IEEE;
use ieee.std_logic_1164.all;

ENTITY ALU IS
  GENERIC ( n : INTEGER := 8;
			k : integer := 3);     -- k=log2(n)
  PORT (    ALUFN: IN STD_LOGIC_VECTOR (1 DOWNTO 0); -- [1,dc]=Logical, [0,1]= shift, [0,0]= AdderSub.
			logical,shifter,addersub: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0); -- Input
            Cin: in STD_LOGIC_VECTOR(1 downto 0);-- Cin(1) for shifter ,Cin(0) for AdderSub
            ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0); -- Result
			Zero,Neg,Carry: OUT STD_LOGIC); -- carry out output
END ALU;
------------------------------------------------------------------------
ARCHITECTURE dfl OF ALU IS
signal reg_out:STD_LOGIC_VECTOR(n-1 downto 0); -- Result
signal zcheck:STD_LOGIC_VECTOR(n downto 0);-- zero register check, for n bit or
begin
zcheck(0) <= '0';

select_result : for i in 0 to n-1 generate 
--Selection := [1,dc]=Logical, [0,1]= shift, [0,0]= AdderSub.
    reg_out(i) <= (ALUFN(1)and logical(i)) or (not(ALUFN(1)) and((ALUFN(0) and shifter(i))or (not(ALUFN(0)) and addersub(i))));
    zcheck(i+1) <= reg_out(i)or zcheck(i); -- n bit or.
end generate;

Carry <= not(ALUFN(1))and((not(ALUFN(0))and Cin(0)) or (ALUFN(0) and Cin(1)));-- Cin(1) for shifter ,Cin(0) for AdderSub
Zero <= not(zcheck(n));
Neg<= reg_out(n-1);
ALUout <= reg_out;

end dfl;