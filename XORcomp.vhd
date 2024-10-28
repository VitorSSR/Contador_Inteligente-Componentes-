library IEEE;
use IEEE.std_logic_1164.all;

entity XORcomp is
	port(
	B :  in std_logic_vector (3 downto 0);
	X : in std_logic ;
	S  : out std_logic_vector (3 downto 0)
	);
end XORcomp;

architecture main of XORcomp is
begin 

S(0) <= B(0) XOR X;
S(1) <= B(1) XOR X;
S(2) <= B(2) XOR X;
S(3) <= B(3) XOR X;

end main;