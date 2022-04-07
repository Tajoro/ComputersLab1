LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY mux2_1 IS
	PORT (  x0,x1: IN STD_LOGIC;
			ctr: IN STD_LOGIC;
			s: OUT STD_LOGIC);
END mux2_1;
--------------------------------------------------------
ARCHITECTURE str_mux2_1 OF mux2_1 IS
BEGIN
	s<=(x0 and not(ctr)) or (x1 and ctr);
END str_mux2_1;

