LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
---------------AdderSubtractor--------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT (    sctr: IN STD_LOGIC_VECTOR(1 DOWNTO  0); --LSB control, '1' SUB , '0' ADD, MSB control negative(X)
			x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            cout: OUT STD_LOGIC;-- carry out
            s: OUT STD_LOGIC_VECTOR(n-1 downto 0));-- Result
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE dfl OF AdderSub IS
SIGNAL reg,xsigned,negctr,result, y_vector : std_logic_vector(n-1 DOWNTO 0); -- reg for carries, xsigned = x if Adder / not(x) if Substractor 
BEGIN	

negctr <= sctr(0) or sctr(1); -- negative control (substruct X from Y or the vector 0
with sctr(1) select
	y_vector <= y 		      when '0',
	y_vector <= (others => 0) when '1';	

	Sign:		for i in 0 to n-1 generate
				xsigned(i) <= x(i) XOR negctr;
	end generate;

	
	first : FA port map(
			xi => xsigned(0),
			yi => y_vector(0),
			cin => sctr(0),
			s => result(0),
			cout => reg(0)
	);
	
	
	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => xsigned(i),
			yi => y_vector(i),
			cin => reg(i-1),
			s => result(i),
			cout => reg(i)
		);
	end generate;
	
		with 
	s<= result;
	cout <= ((reg(n-1))and not(sctr))or(sctr and result(n-1)); -- msb if subtractor, carry from the last FA if Adder

END dfl;

