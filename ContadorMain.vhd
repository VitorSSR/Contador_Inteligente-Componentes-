library IEEE;
use IEEE.std_logic_1164.all;

entity ContadorMain is
	port(
	A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
	UPDOWN : in std_logic;
	Cent,Deze,Unid: out std_logic_vector(3 downto 0)
	);

end ContadorMain;

architecture main of ContadorMain is

	--Somador Subtrator BCD CDU
	Component SomSubBCD is
		port(
		A2,A1,A0,STEP :  in std_logic_vector(3 downto 0);
		UPDOWN : in std_logic;
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


	--Filtro Mx/Mn
	Component inptctrl is
		 port (load: in std_logic;
				 step: in std_logic;
				 max_min: in std_logic;
				 load_step: out  std_logic;
				 load_min: out std_logic;
				 load_max: out std_logic);
	end Component;


	--Registradores Mx Mn e Step
	Component circ_reg is
		port (ld, step, max_min, clk : in bit;
				a2, a1, a0             : in bit_vector(3 downto 0);
				mx_reg, mi_reg         : out bit_vector(11 downto 0);
				st_reg                 : out bit_vector(3 downto 0));
	end entity Component;


	--Registrador de 4 bits
	Component reg4 is
		port(d : in bit_vector(3 downto 0);
			  clk, ld : in bit;
			  q : out bit_vector(3 downto 0));
	end Component;
