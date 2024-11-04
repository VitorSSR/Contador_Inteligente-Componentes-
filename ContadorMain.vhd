library ieee;
use ieee.std_logic_1164.all;

entity ContadorMain is
	port(
	A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
	load_button, clock_button, max_min_button, updown_button: in std_logic;
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

	Component registrador_2 is
		port(
			clk : in std_logic;
			clr : in std_logic_vector(3 downto 0);
			set : in std_logic_vector(3 downto 0);
			inR : in std_logic_vector(3 downto 0);
			outR : out std_logic_vector(3 downto 0)
		);
	end Component;


	--Parte inicial 

	Component projeto02_reg is

		port(
			load, max_min, step, clear	: in std_logic;
			a2, a1, a0 : in std_logic_vector(3 downto 0);
			Smax03, Smax02, Smax01, Smin03, Smin02, Smin01, Sstep	: out std_logic_vector(3 downto 0)
		);

	end Component;


	--DecoderBCD

	Component DecoderBCD is

    		Port ( ENTRADA : in STD_LOGIC_VECTOR (3 downto 0);
           		SAIDA : out STD_LOGIC_VECTOR (6 downto 0)
		);

	end Component;





signal step_button, clear_button, AigualB_maximo, AmenorB_maximo,  AigualB_minimo, AmaiorB_minimo, AmaiorB_overflow, AmenorB_overflow : std_logic;

signal  saida_somador_BCD, saida_registrador_maximo, saida_registrador_minimo: std_logic_vector (11 downto 0);

signal   centena,dezena,unidade, saida_mux_min_unidade, saida_mux_min_dezena, saida_mux_min_centena, saida_mux_max_unidade, saida_mux_max_dezena, saida_mux_max_centena, entrada_bcd_centena, entrada_bcd_dezena, entrada_bcd_unidade: std_logic_vector (3 downto 0);

signal saida_registador_maximo_centena, saida_registador_maximo_dezena, saida_registador_maximo_unidade, saida_registador_minimo_centena, saida_registador_minimo_dezena, saida_registador_minimo_unidade, saida_registador_step: std_logic_vector (3 downto 0);

signal clr, set, set_intermediario, reset_intermediario, clear_intermediario, saida_registrador_intermediario_centena, saida_registrador_intermediario_dezena, saida_registrador_intermediario_unidade : std_logic_vector(3 downto 0);

signal saida_bcd_centena, saida_bcd_dezena, saida_bcd_unidade: std_logic_vector(6 downto 0);




begin


registradores_iniciais:  projeto02_reg port map(load_button, max_min_button, step_button, clear_button, A2, A1, A0, saida_registador_maximo_centena, saida_registador_maximo_dezena, saida_registador_maximo_unidade, saida_registador_minimo_centena, saida_registador_minimo_dezena, saida_registador_minimo_unidade, saida_registador_step);




saida_registrador_maximo(11 downto 8)  <= saida_registador_maximo_centena;

saida_registrador_maximo(7 downto 4)  <= saida_registador_maximo_dezena;

saida_registrador_maximo(3 downto 0)  <= saida_registador_maximo_unidade;



saida_registrador_minimo(11 downto 8)  <= saida_registador_minimo_centena;

saida_registrador_minimo(7 downto 4)  <= saida_registador_minimo_dezena;

saida_registrador_minimo(3 downto 0)  <= saida_registador_minimo_unidade;



--registradores intermediarios


set_intermediario <= ('0','0','0','0');

reset_intermediario <= ('0','0','0','0');

clear_intermediario <= ('0','0','0','0');



registrador_intermediario_centena: registrador_2 port map (clock_button, clear_intermediario, set_intermediario, saida_mux_max_centena, saida_registrador_intermediario_centena);


registrador_intermediario_dezena: registrador_2 port map (clock_button, clear_intermediario, set_intermediario, saida_mux_max_dezena, saida_registrador_intermediario_dezena);


registrador_intermediario_unidade: registrador_2 port map (clock_button, clear_intermediario, set_intermediario, saida_mux_max_unidade, saida_registrador_intermediario_unidade);



--soma/subtracao
somador_subtrator: SomSubBCD port map(saida_registrador_intermediario_centena, saida_registrador_intermediario_dezena, saida_registrador_intermediario_unidade, saida_registador_step, updown_button, centena, dezena, unidade);




--vetor para saída do somador bcd

saida_somador_BCD(11 downto 8)<= centena;

saida_somador_BCD(7 downto 4) <= dezena;

saida_somador_BCD(3 downto 0) <= unidade;



comparar_maximo: comparador_mag_soma port map (saida_somador_BCD, saida_registrador_maximo, AigualB_maximo, AmaiorB_overflow, AmenorB_maximo); --COMPARADOR MÁXIMO

comparar_minimo: comparador_mag_subtracao port map (saida_somador_BCD, saida_registrador_minimo, AigualB_minimo, AmaiorB_minimo, AmenorB_overflow);  --COMPARADOR MINIMO



--os 3 mux que pegam o valor minimo

mux_4x1_minimo_unidade: mux2x1_4b port map (unidade , saida_registador_minimo_unidade, AmaiorB_overflow, saida_mux_min_unidade);

mux_4x1_minimo_dezena: mux2x1_4b port map (dezena , saida_registador_minimo_dezena, AmaiorB_overflow, saida_mux_min_dezena);

mux_4x1_minimo_centena: mux2x1_4b port map (centena, saida_registador_minimo_centena , AmaiorB_overflow, saida_mux_min_centena);




--os 3 mux que pegam o valor maximo

mux_4x1_maximo_unidade: mux2x1_4b port map (saida_mux_min_unidade, saida_registador_maximo_unidade, AmenorB_overflow, saida_mux_max_unidade);

mux_4x1_maximo_dezena: mux2x1_4b port map (saida_mux_min_dezena, saida_registador_maximo_dezena , AmenorB_overflow, saida_mux_max_dezena);

mux_4x1_maximo_centena: mux2x1_4b port map (saida_mux_min_centena, saida_registador_maximo_centena , AmenorB_overflow, saida_mux_max_centena);




--DECODERS BCD


entrada_bcd_centena <= (saida_registrador_intermediario_centena(1), saida_registrador_intermediario_centena(2), saida_registrador_intermediario_centena(3), saida_registrador_intermediario_centena(0));

entrada_bcd_dezena <= (saida_registrador_intermediario_dezena(1), saida_registrador_intermediario_dezena(2), saida_registrador_intermediario_dezena(3), saida_registrador_intermediario_dezena(0));

entrada_bcd_unidade <= (saida_registrador_intermediario_unidade(1), saida_registrador_intermediario_unidade(2), saida_registrador_intermediario_unidade(3), saida_registrador_intermediario_unidade(0));



decoder_bcd_centena: DecoderBCD port map (entrada_bcd_centena, saida_bcd_centena);

decoder_bcd_dezena: DecoderBCD port map (entrada_bcd_dezena, saida_bcd_dezena);

decoder_bcd_unidade: DecoderBCD port map (entrada_bcd_unidade, saida_bcd_unidade);



Cent <= centena;

Deze <= dezena;

Unid <= unidade;

end main;
