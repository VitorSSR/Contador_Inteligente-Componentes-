library IEEE;
use IEEE.std_logic_1164.all;

entity somador4 is
	port(
	A_input,B_input  :  in std_logic_vector(3 downto 0);
	Cin : in std_logic;
	Sout  : out std_logic_vector(3 downto 0);
	Cout : out std_logic
	);
end somador4;

architecture main of somador4 is

component SomadorCompleto is
	port(
	A,B,C  :  in std_logic;
	Co,S  : out std_logic
	);
end component;

-- Sinais intermediários para os carries entre os somadores
    signal carry_intermediate : std_logic_vector(2 downto 0);

begin

    -- Instância para o bit 0
    S1 : SomadorCompleto
        port map (
            A  => A_input(0),
            B  => B_input(0),
            C => Cin,
            Co => carry_intermediate(0),
            S  => Sout(0)
        );

    -- Instância para o bit 1
    S2 : SomadorCompleto
        port map (
            A  => A_input(1),
            B  => B_input(1),
            C => carry_intermediate(0),  -- Carry do estágio anterior
            Co => carry_intermediate(1),
            S  => Sout(1)
        );

    -- Instância para o bit 2
    S3 : SomadorCompleto
        port map (
            A  => A_input(2),
            B  => B_input(2),
            C => carry_intermediate(1),  -- Carry do estágio anterior
            Co => carry_intermediate(2),
            S  => Sout(2)
        );

    -- Instância para o bit 3
    S4 : SomadorCompleto
        port map (
            A  => A_input(3),
            B  => B_input(3),
            C => carry_intermediate(2),  -- Carry do estágio anterior
            Co => Cout,                   -- Carry de saída final
            S  => Sout(3)
        );

end main;