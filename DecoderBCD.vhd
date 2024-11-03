library ieee;
use ieee.std_logic_1164.all;

entity DecoderBCD is

    Port ( ENTRADA : in STD_LOGIC_VECTOR (3 downto 0);
           SAIDA : out STD_LOGIC_VECTOR (6 downto 0));

end DecoderBCD;


architecture decodificacao of DecoderBCD is


begin

	SAIDA(6) <= ENTRADA(3) or ENTRADA(1) or (ENTRADA(2) and ENTRADA(0)) or (not(ENTRADA(2)) and not(ENTRADA(0)));
	SAIDA(5) <= not(ENTRADA(2)) or (ENTRADA(1) and ENTRADA(0)) or (not(ENTRADA(1)) and not(ENTRADA(0)));
	SAIDA(4) <= ENTRADA(2) or not(ENTRADA(1)) or ENTRADA(0);
	SAIDA(3) <= ENTRADA(3) or (not(ENTRADA(2)) and not(ENTRADA(0))) or (ENTRADA(1) and not(ENTRADA(2))) or (ENTRADA(1) and not(ENTRADA(0))) or (ENTRADA(2) and not(ENTRADA(1)) and ENTRADA(0));
	SAIDA(2) <= (not(ENTRADA(2)) and not(ENTRADA(0))) or (ENTRADA(1) and not(ENTRADA(0)));
	SAIDA(1) <= ENTRADA(3) or (not(ENTRADA(1)) and not(ENTRADA(0))) or (not(ENTRADA(1)) and ENTRADA(2)) or (ENTRADA(2) and not(ENTRADA(0)));
	SAIDA(0) <= ENTRADA(3) or (ENTRADA(2) and not(ENTRADA(1))) or (not(ENTRADA(2)) and ENTRADA(1)) or (ENTRADA(2) and not(ENTRADA(0)));

end decodificacao;

