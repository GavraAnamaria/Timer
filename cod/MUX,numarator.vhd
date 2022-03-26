library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MUX_nr is
	port(sel,clk,buton:in std_logic; --selectia ,clock, buton pentru incrementarea minutelor/secundelor	
	clk1:out std_logic);	   --clock pentru min/sec
end MUX_nr;

architecture comportamental of MUX_nr is
begin

process(sel,clk,buton)   --selecteaza clock ul obisnuit/corespunzator incrementarii													 
begin											  
   	
if sel='1' then
		CLK1<=buton;	--clock.ul pt secunde/minute = semnalul generat de la butonul=> se incrementeaza secundele/minutele cand este apasat butonul			   
	 else	
		clk1<=clk;	--secundele/minutele se incrementeaza in mod normal,dupa o sec/dupa un min.
     end if;
	 
	 
end process;
 
end comportamental;