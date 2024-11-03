library ieee;

use ieee.std_logic_1164.all;

entity mux2x1_4b is
    port (
        A, B : in  std_logic_vector(3 downto 0);
        chave : in  std_logic;
        S : out std_logic_vector(3 downto 0)
    );
end mux2x1_4b;

architecture selection of mux2x1_4b is

	--mux 2x1 2bit
	component mux2x1_2bit is
		port (
        		A, B : in  std_logic;
        		chave : in  std_logic;
        		S : out std_logic
    		);
	end component;

signal P_and_1, P_and_2, P_or : std_logic;

begin

S3 : mux2x1_2bit port map (A(3), B(3), chave, S(3));
S2 : mux2x1_2bit port map (A(2), B(2), chave, S(2));
S1 : mux2x1_2bit port map (A(1), B(1), chave, S(1));
S0 : mux2x1_2bit port map (A(0), B(0), chave, S(0));


end selection;

