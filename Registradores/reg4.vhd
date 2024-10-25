-- Registrador de 4 bits 

library ieee;
use ieee.std_logic_1164.all;

-- Latch D

entity latchd is
	port (d, clk: in bit;
	  	   q: out bit);
end entity;

architecture main of latchd is
begin
	process (d, clk)
	begin
		if(clk = '1') then
			q <= d;
		end if;
	end process;
end architecture;
  
-- Flip flop D

entity ffd is
	port (d, clk: in bit;
		    q: out bit
      );
end entity;

architecture main of ffd is
	signal q_d: bit := '0';

	component latchd is
		port (d, clk: in bit;
			    q: out bit);
	end component;
  
begin
	
	l1: latchd port map (
		d => d, clk => not(clk), q => q_d);

	l2: latchd port map (
		d => q_d, clk => clk, q => q);
end architecture;

-- Registrador de 4 Bits

entity reg4 is
   port(d : in bit_vector(3 downto 0);
        clk : in bit;
        q : out bit_vector(3 downto 0));
end entity reg4;

architecture main of reg4 is

   component ffd is
      port(d, clk: in bit;
           q: out bit);
   end component;
begin
   
   ffs: for k in 0 to 3 generate
      ff: ffd port map (d => d(k), clk => clk,
         		q => q(k));
   end generate ffs;
   
end architecture main;
