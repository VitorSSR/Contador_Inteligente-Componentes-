library ieee;
use ieee.std_logic_1164.all;

entity registrador is
	port(
	clk : in std_logic;
	clr : in std_logic_vector(3 downto 0);
	set : in std_logic_vector(3 downto 0);
	inR : in std_logic_vector(3 downto 0);
	outR : out std_logic_vector(3 downto 0)
	);
end registrador;

architecture main of registrador is

component  ffd is
   port (ck, clr, set, d : in  std_logic;
                       q : out std_logic);
end component;

begin

ffd1 : ffd
	port map(
	ck => clk,
	clr => clr(0),
	set => set(0),
	d => inR(0),
	q => outR(0)
	
	);
	
ffd2 : ffd
	port map(
	ck => clk,
	clr => clr(1),
	set => set(1),
	d => inR(1),
	q => outR(1)
	
	);

ffd3 : ffd
	port map(
	ck => clk,
	clr => clr(2),
	set => set(2),
	d => inR(2),
	q => outR(2)
	
	);
	
ffd4 : ffd
	port map(
	ck => clk,
	clr => clr(3),
	set => set(3),
	d => inR(3),
	q => outR(3)
	
	);



end main;