library IEEE;
use IEEE.std_logic_1164.all;

entity SomSubBCD is
	port(
	A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
	UPDOWN : in std_logic;
	Cent,Deze,Unid: out std_logic_vector(3 downto 0)
	);
end SomSubBCD;

architecture main of SomSubBCD is

component somadorBCD is
	port(
	Ai,Bi  :  in std_logic_vector(3 downto 0);
	ADDSUB : in std_logic;
	R  : out std_logic_vector(3 downto 0);
	CarryOut : out std_logic
	);
end component;

signal C1,C2,C3 : std_logic ;
signal tmp1,tmp2 : std_logic_vector(3 downto 0); 

begin

S1 : somadorBCD
	port map(
	Ai =>A0,
	Bi =>STEP,
	ADDSUB =>UPDOWN,
	R  => Unid,
	CarryOut =>C1
	);

tmp1 <="000" & C1;
S2 : somadorBCD
	port map(
	Ai =>A1,
	Bi => tmp1,
	ADDSUB =>UPDOWN,
	R  => Deze,
	CarryOut => C2
	);
	
tmp2 <="000" & C2;
S3 : somadorBCD
	port map(
	Ai =>A2,
	Bi =>tmp2,
	ADDSUB =>UPDOWN,
	R  => Cent,
	CarryOut => C3
	);
	
end main;

