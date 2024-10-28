library IEEE;
use IEEE.std_logic_1164.all;

entity somadorBCD is
	port(
	Ai,Bi  :  in std_logic_vector(3 downto 0);
	ADDSUB : in std_logic;
	R  : out std_logic_vector(3 downto 0);
	CarryOut : out std_logic
	);
end somadorBCD;

architecture main of somadorBCD is

component somador4 is
	port(
	A_input,B_input  :  in std_logic_vector(3 downto 0);
	Cin : in std_logic;
	Sout  : out std_logic_vector(3 downto 0);
	Cout : out std_logic
	);
end component;

component XORcomp is
	port(
	B :  in std_logic_vector (3 downto 0);
	X : in std_logic ;
	S  : out std_logic_vector (3 downto 0)
	);
end component;

signal temp1,temp2,temp3 : std_logic_vector(3 downto 0); 
signal CarryTemp,circ : std_logic ;


begin

xorc1 : XORcomp
	port map(
	B => Bi,
	X => ADDSUB,
	S => temp1
	);
	
Som1 : somador4 
	port map(
	B_input => temp1,
	A_input => Ai,
	Cin => ADDSUB,
	Sout => temp2,
	Cout=> CarryTemp
	);
	

circ<=  (not CarryTemp AND ADDSUB)OR( not ADDSUB AND( CarryTemp OR(temp2(3) AND(temp2(1) OR temp2(2)))));
xorc2: XORcomp
	port map(
	B(0) =>'0' ,
	B(1) =>circ ,
	B(2) =>circ ,
	B(3) => '0',
	X => ADDSUB,
	S => temp3 
	);
	
CarryOut<= circ;
Som2 : somador4
port map(
	B_input => temp2,
	A_input => temp3,
	Cin => ADDSUB,
	Sout => R
	);
end main;