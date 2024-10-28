library ieee;
use ieee.std_logic_1164.all;

entity inptctrl is
    port (load: in std_logic;
			 step: in std_logic;
			 max_min: in std_logic;
			 load_step: out  std_logic;
          load_min: out std_logic;
			 load_max: out std_logic);
end inptctrl;

architecture log of inptctrl is

signal I0: std_logic;

begin
  I0 <= load and (not max_min);
  load_step <= step and I0;
  load_min <= (not step) and I0;
  load_max <= max_min and load;
  
end log;