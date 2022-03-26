 
 library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity alarma is
	port(BR,Clk2: in std_logic;--BR=1 cand timer-ul ajunge la final,clk2=clock divizat(1sec) 
	NR2:in std_logic_vector(3 downto 0); --perioada de timp pentru care alarma trebuie sa functioneze
	led:out std_logic);--iesirea(ledul=aprins cat timp alarma=pornita)					 
end alarma;

architecture comportamental of alarma is		 	   
begin  
	process (BR,clk2)		  		 	
	variable E: std_logic:='0';	--enable
	variable l: std_logic:='0';	--variabila pentru led
	variable NR: std_logic_vector(3 downto 0) := (others=>'0');--contor
	begin
		if rising_edge(BR) then	 
			E:='1';		   --BR=1=>Enable=1
		else
			E:=E;		   --ramane neschimbat
		 end if;
		if E='0' then 
			NR:="0000" ;l:='0';--initializare
	    else  		--a ajuns la final
	         if (NR2/=0) then  --ledul se aprinde cand BR:=1 daca nr2 nu e 0;
				l:='1';
				else 
				l:='0';
				end if;
		    if clk2='0' and clk2'event then	--incrementare nr
				if (NR=NR2) then 
					l:='0'; E:='0';--numaratorul ajunge la final=>resetare
				else 
			       l:='1'; NR:=NR+1; --ledul e aprins
				end if;
		    end if;	
		 end if;
		 	led<=l;	 
	end process;
end comportamental;