library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----
entity d_ff is
port(d, clk : in std_logic;
	q : out std_logic
);
end d_ff;

architecture arch of d_ff is
signal d1 : std_logic;
begin
	--process(clk,d) begin
	--	if(clk'event and clk='1') then
	--		d1<=d;
	--	else null;
	--	end if;
	--end process;
	
	q <= d1;
	
	process(clk,d) begin
		if(clk'event and clk='1') then
			d1 <= d;
		else null;
		end if;
	end process;
end arch;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture arch of tb is
signal d,clk : std_logic :='0';
signal q : std_logic;
component d_ff is
port(d, clk : in std_logic;
	q : out std_logic
);
end component;
begin
	X1 : d_ff port map(d,clk,q);
	process 
	begin
		wait for 10 ns;
		clk <= not(clk);
	end process;
	
	process 
	begin 
		wait for 7 ns;
		d <= not(d);
	end process;
end arch;