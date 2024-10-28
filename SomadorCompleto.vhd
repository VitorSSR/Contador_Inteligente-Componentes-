library IEEE;
use IEEE.std_logic_1164.all;

entity somadorcompleto is
	port(
	A,B,C  :  in std_logic;
	Co,S  : out std_logic
	);
end SomadorCompleto;

architecture main of somadorcompleto is
signal temp : std_logic;

begin 
	temp <= A XOR B;
	S <= C XOR temp;
	Co <= (A AND B) OR (A AND C) OR (C AND B);
	
end main;