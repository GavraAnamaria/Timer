library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity divizor is
	port(CLK: in std_logic; --clk de pe placa
	SEL:out std_logic_vector(1 downto 0);--ultimii 2 b sunt folositi pentru selectia multiplexorului afisorului
	CLK2,CLK3:out std_logic);--clk2 e folosit drept clock pentru timer 
end divizor;				--clk3 folosit in UC pentru schimbarea starilor 

architecture comportamental of divizor is
begin 	 				  
	process (CLK)  
	
	    variable N: std_logic_vector(26 downto 0) := (others=>'1');--=>2^26= aprox. 50 mil.=>t=aprox. 1sec
	    variable NR: std_logic_vector(26 downto 0) := (others=>'0');
	begin	  	 
			if rising_edge(clk) then 
			   	if NR=N then NR:= (others=>'0'); --resetare cand ajunge la final
				  else	  
				  NR:=NR+1;	--numara crescator 
				end if;	
			end if;				 
		
	SEL<=NR(1 downto 0);
	clk2<=NR(26);--clock de o sec
	clk3<=NR(25);--=>2^25=>t= aprox =0,5s
     end process;		   
end comportamental;