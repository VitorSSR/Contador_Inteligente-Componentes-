library ieee;
use ieee.std_logic_1164.all;

entity ContadorMain is
	port(
	A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
	ld, max_min, clk, updown: in std_logic;
	Cent,Deze,Unid: out std_logic_vector(3 downto 0)
	);

end ContadorMain;

architecture main of ContadorMain is

	--Somador Subtrator BCD CDU
	Component SomSubBCD is
		port(
		A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
		updown : in std_logic;
		Cent,Deze,Unid: out std_logic_vector(3 downto 0)
		);
	end Component;


	--Comparador_magnitude_12b_soma
	Component comparador_mag_soma is
		port(
			A_comparacao, B_comparacao: IN std_logic_vector(11 downto 0);
			AigualB, AmaiorB_overflow, AmenorB: OUT std_logic
		);

	end Component;

	--Comparador_magnitude_12b_subtracao
	Component comparador_mag_subtracao is
		port(
			A_comparacao, B_comparacao: IN std_logic_vector(11 downto 0);
			AigualB, AmaiorB, AmenorB_overflow: OUT std_logic
		);

	end Component;


	Component mux2x1_4b is
		port (
        		A, B : in  std_logic_vector(3 downto 0);
        		chave : in  std_logic;
        		S : out std_logic_vector(3 downto 0)  
    		);
	end Component;


	--Filtro Mx/Mn
	Component inptctrl is
		 port (load: in std_logic;
				 step: in std_logic;
				 max_min: in std_logic;
				 load_step: out  std_logic;
				 load_min: out std_logic;
				 load_max: out std_logic);
	end Component;




	--Registrador

	Component registrador is
		port(
			inR : in std_logic_vector(3 downto 0);
			clk : in std_logic;
			outR : out std_logic_vector(3 downto 0)
		);
	end Component;


	--DecoderBCD

	Component DecoderBCD is

    		Port ( ENTRADA : in STD_LOGIC_VECTOR (3 downto 0);
           		SAIDA : out STD_LOGIC_VECTOR (6 downto 0)
		);

	end Component;





signal  saida_somador_BCD, max_registrador, min_registrador: std_logic_vector (11 downto 0);

signal  centena,dezena,unidade, saida_mux_min_unidade, saida_mux_min_dezena, saida_mux_min_centena, saida_mux_max_unidade, saida_mux_max_dezena, saida_mux_max_centena, entrada_bcd_centena, entrada_bcd_dezena, entrada_bcd_unidade: std_logic_vector (3 downto 0);

signal saida_bcd_centena, saida_bcd_dezena, saida_bcd_unidade: std_logic_vector(6 downto 0);




begin


somador_subtrator: SomSubBCD port map(SAIDA_REGISTRADOR_CLOCK_CENTENA, SAIDA_REGISTRADOR_CLOCK_DEZENA, SAIDA_REGISTRADOR_CLOCK_UNIDADE, SAIDA_REGISTRADOR_STEP,updown,centena,dezena,unidade);


saida_somador_BCD(11 downto 8)<= centena;

saida_somador_BCD(7 downto 4) <= dezena;

saida_somador_BCD(3 downto 0) <= unidade;



comparar_maximo: comparador_mag_soma port map (saida_somador_BCD, SAIDA_REGISTRADOR_MAXIMO, AigualB, AmaiorB_overflow, AmenorB); --COMPARADOR MÁXIMO

comparar_minimo: comparador_mag_subtracao port map (saida_somador_BCD, SAIDA_REGISTRADOR_MINIMO, AigualB, AmaiorB, AmenorB_overflow);  --COMPARADOR MINIMO



--os 3 mux que pegam o valor minimo

mux_4x1_minimo_unidade: mux2x1_4b port map (saída_somador_BCD(3 downto 0), SAIDA_REGISTRADOR_MINIMO_UNIDADE, AmaiorB_overflow, saida_mux_min_unidade);

mux_4x1_minimo_dezena: mux2x1_4b port map (saída_somador_BCD(7 downto 4), SAIDA_REGISTRADOR_MINIMO_DEZENA , AmaiorB_overflow, saida_mux_min_dezena);

mux_4x1_minimo_centena: mux2x1_4b port map (saída_somador_BCD(11 downto 8), SAIDA_REGISTRADOR_MINIMO_CENTENA , AmaiorB_overflow, saida_mux_min_centena);




--os 3 mux que pegam o valor maximo

mux_4x1_maximo_unidade: mux2x1_4b port map (saída_somador_BCD(3 downto 0), SAIDA_REGISTRADOR_MAXIMO_UNIDADE, AmenorB_overflow, saida_mux_max_unidade);

mux_4x1_maximo_dezena: mux2x1_4b port map (saída_somador_BCD(7 downto 4), SAIDA_REGISTRADOR_MAXIMO_DEZENA , AmenorB_overflow, saida_mux_max_dezena);

mux_4x1_maximo_centena: mux2x1_4b port map (saída_somador_BCD(11 downto 8), SAIDA_REGISTRADOR_MAXIMO_CENTENA , AmenorB_overflow, saida_mux_max_centena);



--DECODERS BCD

entrada_bcd_centena <= (SAIDA_REGISTRADOR_CLOCK_CENTENA(1), SAIDA_REGISTRADOR_CLOCK_CENTENA(2), SAIDA_REGISTRADOR_CLOCK_CENTENA(3), SAIDA_REGISTRADOR_CLOCK_CENTENA(0));

entrada_bcd_dezena <= (SAIDA_REGISTRADOR_CLOCK_DEZENA(1), SAIDA_REGISTRADOR_CLOCK_DEZENA(2), SAIDA_REGISTRADOR_CLOCK_DEZENA(3), SAIDA_REGISTRADOR_CLOCK_DEZENA(0));

entrada_bcd_unidade <= (SAIDA_REGISTRADOR_CLOCK_UNIDADE(1), SAIDA_REGISTRADOR_CLOCK_UNIDADE(2), SAIDA_REGISTRADOR_CLOCK_UNIDADE(3), SAIDA_REGISTRADOR_CLOCK_UNIDADE(0));



decoder_bcd_centena: DecoderBCD port map (entrada_bcd_centena, saida_bcd_centena);

decoder_bcd_dezena: DecoderBCD port map (entrada_bcd_dezena, saida_bcd_dezena);

decoder_bcd_unidade: DecoderBCD port map (entrada_bcd_unidade, saida_bcd_unidade);


end main;
