
library ieee;

use ieee.std_logic_1164.all;

entity comparador_mag is

port(
	A_comparacao, B_comparacao: IN std_logic_vector(11 downto 0);
	AigualB, AmaiorB, AmenorB: OUT std_logic
);

end comparador_mag;

architecture comparador of comparador_mag is

signal P_XNor_1, P_XNor_2,P_XNor_3,P_XNor_4,P_XNor_5,P_XNor_6, P_XNor_7, P_XNor_8, P_XNor_9, P_XNor_10, P_XNor_11, P_XNor_12, P_And_1, P_And_2, P_And_3, P_And_4, P_And_5, P_And_6, P_And_7, P_And_8, P_And_9, P_And_10, P_And_11, P_And_12, P_And_13, P_Or, P_Nor: std_logic;


begin

P_XNor_1 <= A_comparacao(11) xnor B_comparacao(11);

P_XNor_2 <= A_comparacao(10) xnor B_comparacao(10);

P_XNor_3 <= A_comparacao(9) xnor B_comparacao(9);

P_XNor_4 <= A_comparacao(8) xnor B_comparacao(8);

P_XNor_5 <= A_comparacao(7) xnor B_comparacao(7);

P_XNor_6 <= A_comparacao(6) xnor B_comparacao(6);

P_XNor_7 <= A_comparacao(5) xnor B_comparacao(5);

P_XNor_8 <= A_comparacao(4) xnor B_comparacao(4);

P_XNor_9 <= A_comparacao(3) xnor B_comparacao(3);

P_XNor_10 <= A_comparacao(2) xnor B_comparacao(2);

P_XNor_11<= A_comparacao(1) xnor B_comparacao(1);

P_XNor_12 <= A_comparacao(0) xnor B_comparacao(0);



P_And_1 <= P_XNor_1 and P_XNor_2 and P_XNor_3 and P_XNor_4 and P_XNor_5 and P_XNor_6 and P_XNor_7 and P_XNor_8 and P_XNor_9 and P_XNor_10 and P_XNor_11 and P_XNor_12; 

P_And_2 <=  A_comparacao(11) and not(B_comparacao(11));

P_And_3 <= P_XNor_1 and A_comparacao(10) and not(B_comparacao(10));

P_And_4 <= P_XNor_2 and P_XNor_1 and A_comparacao(9) and not(B_comparacao(9));

P_And_5 <= P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(8) and not(B_comparacao(8));

P_And_6 <= P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(7) and not(B_comparacao(7));

P_And_7 <= P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(6) and not(B_comparacao(6));

P_And_8 <= P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(5) and not(B_comparacao(5));

P_And_9 <= P_XNor_7 and P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(4) and not(B_comparacao(4));

P_And_10 <= P_XNor_8 and P_XNor_7 and P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(3) and not(B_comparacao(3));

P_And_11 <= P_XNor_9 and P_XNor_8 and P_XNor_7 and P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(2) and not(B_comparacao(2));

P_And_12 <= P_XNor_10 and P_XNor_9 and P_XNor_8 and P_XNor_7 and P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(1) and not(B_comparacao(1));

P_And_13 <= P_XNor_11 and P_XNor_10 and P_XNor_9 and P_XNor_8 and P_XNor_7 and P_XNor_6 and P_XNor_5 and P_XNor_4 and P_XNor_3 and P_XNor_2 and P_XNor_1 and A_comparacao(0) and not(B_comparacao(0));



P_Or <= P_And_2 or P_And_3 or P_And_4 or P_And_5 or P_And_6 or P_And_7 or P_And_8 or P_And_9 or P_And_10 or P_And_11 or P_And_12 or P_And_13;


P_Nor <= P_And_1 nor P_Or;



AmaiorB <= P_Or;   --Overflow na soma

AigualB <= P_And_1;

AmenorB <= P_Nor;  -- Overflow na subtração



end comparador;

--PARA A SOMA NA MAIN    comparar_soma: comparador_mag port map (A_comparacao, B_comparacao, AigualB, AmaiorB (OVERFLOW), AmenorB);

--PARA A SUBTRACAO NA MAIN    comparar_subtracao: comparador_mag port map (A_comparacao, B_comparacao, AigualB, AmaiorB, AmenorB (OVERFLOW));