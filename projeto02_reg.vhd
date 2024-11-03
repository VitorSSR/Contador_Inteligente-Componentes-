library ieee;
use ieee.std_logic_1164.all;

entity projeto02_reg is
	port(
	load		: in std_logic;
	max_min	: in std_logic;
	step		: in std_logic;
	clear		: in std_logic;
	a2			: in std_logic_vector(3 downto 0);
	a1			: in std_logic_vector(3 downto 0);
	a0			: in std_logic_vector(3 downto 0);
	Smax03	: out std_logic_vector(3 downto 0);
	Smax02	: out std_logic_vector(3 downto 0);
	Smax01	: out std_logic_vector(3 downto 0);
	Smin03	: out std_logic_vector(3 downto 0);
	Smin02	: out std_logic_vector(3 downto 0);
	Smin01	: out std_logic_vector(3 downto 0);
	Sstep		: out std_logic_vector(3 downto 0)
	);
end projeto02_reg;

architecture log of projeto02_reg is

component inptctrl is
    port (load, step, max_min					: in std_logic;
			 load_step, load_min, load_max	: out  std_logic);
end component;

component registrador is
	port(clk					: in std_logic;
		  clr, set, inR	: in std_logic_vector(3 downto 0);
		  outR				: out std_logic_vector(3 downto 0));
end component;

signal lstep	: std_logic;
signal lmin		: std_logic;
signal lmax		: std_logic;

signal clr_step_dir	: std_logic_vector(3 downto 0);
signal clr_step_esq	: std_logic_vector(3 downto 0);
signal clr_max_dir	: std_logic_vector(3 downto 0);
signal clr_max_esq	: std_logic_vector(3 downto 0);
signal clr_min_dir	: std_logic_vector(3 downto 0);
signal clr_min_esq	: std_logic_vector(3 downto 0);

begin

clr_step_dir <= clear & clear & clear & '0';
clr_step_esq <= "000" & clear;
clr_max_dir <= '0' & clear & clear & '0';
clr_max_esq <= clear & "00" & clear;
clr_min_dir <= clear & clear & clear & clear;
clr_min_esq <= "0000";

inptctrl1 : inptctrl port map(load, step, max_min, lstep, lmin, lmax);

reg_max_3 : registrador port map(lmax, clr_max_dir, clr_max_esq, a2, Smax03);
reg_max_2 : registrador port map(lmax, clr_max_dir, clr_max_esq, a1, Smax02);
reg_max_1 : registrador port map(lmax, clr_max_dir, clr_max_esq, a0, Smax01);
  
reg_min_3 : registrador port map(lmin, clr_min_dir, clr_min_esq, a2, Smin03);
reg_min_2 : registrador port map(lmin, clr_min_dir, clr_min_esq, a1, Smin02); 
reg_min_1 : registrador port map(lmin, clr_min_dir, clr_min_esq, a0, Smin01);
  
reg_step : registrador port map(lstep, clr_step_dir, clr_step_esq, a0, Sstep);

end log;