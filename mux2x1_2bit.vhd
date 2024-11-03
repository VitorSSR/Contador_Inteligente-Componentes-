library ieee;

use ieee.std_logic_1164.all;

entity mux2x1_2bit is
    Port (
        A, B : in  std_logic;
        chave : in  std_logic;
        S : out std_logic
    );
end mux2x1_2bit;

architecture selection of mux2x1_2bit is

signal P_and_1, P_and_2, P_or : std_logic;
begin

P_and_1 <= (A and chave);

P_and_2 <= (B and chave);

P_or <= (P_and_1 or P_and_2);

S <= P_or;

end selection;
