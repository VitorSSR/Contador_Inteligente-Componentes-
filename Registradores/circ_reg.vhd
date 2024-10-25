library ieee;
use ieee.std_logic_1164.all;

-- cleber
entity cleber is
    port (step, max_min, ld   : in bit;
          mx_ld, mi_ld, st_ld : out bit);
end entity cleber;

architecture main of cleber is
    
begin
    
    mx_ld <= ld and max_min;
    mi_ld <= ld and not(max_min) and not(step);
    st_ld <= ld and not(max_min) and step;
    
end architecture main;

-- entidade top-level
entity circ_reg is
port (ld, step, max_min, clk : in bit;
a2, a1, a0             : in bit_vector(3 downto 0);
mx_reg, mi_reg         : out bit_vector(11 downto 0);
st_reg                 : out bit_vector(3 downto 0));
end entity circ_reg;


architecture main of circ_reg is
   signal mx_ld_s : bit;
	signal mi_ld_s : bit;
	signal st_ld_s : bit;

    component cleber is
        port (step, max_min, ld   : in bit;
              mx_ld, mi_ld, st_ld : out bit);
    end component;

    component reg4 is
        port(d       : in bit_vector(3 downto 0);
             clk, ld : in bit;
             q       : out bit_vector(3 downto 0));
    end component;
    
begin

    clb : cleber port map(step => step, max_min => max_min, ld => ld,
                          mx_ld => mx_ld_s, mi_ld => mi_ld_s, st_ld => st_ld_s);

    -- Registrador de Maximo

    max0: reg4 port map(d => a0,      
                        clk => clk, ld => mx_ld_s,
                        q => mx_reg(3 downto 0));

    max1: reg4 port map(d => a1,      
                        clk => clk, ld => mx_ld_s, 
                        q => mx_reg(7 downto 4));

    max2: reg4 port map(d => a2,      
                        clk => clk, ld => mx_ld_s, 
                        q => mx_reg(11 downto 8));
                        
    -- Registrador de Minimo
    
    min0: reg4 port map(d => a0,      
                        clk => clk, ld => mi_ld_s, 
                        q => mi_reg(3 downto 0));

    min1: reg4 port map(d => a1,      
                        clk => clk, ld => mi_ld_s, 
                        q => mi_reg(7 downto 4));

    min2: reg4 port map(d => a2,      
                        clk => clk, ld => mi_ld_s, 
                        q => mi_reg(11 downto 8));
    
    -- Registrador de Step
    
    st: reg4 port map(d => a0,      
                      clk => clk, ld => st_ld_s, 
                      q => st_reg);
    
end architecture main;
