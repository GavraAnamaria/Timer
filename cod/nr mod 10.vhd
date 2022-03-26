  library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL; 

entity num_mod_10 is
	port(EN,R,CU,CD,mode: in std_logic;	--EN=enable, R=reset, CU=clock cand numara crescator, CD=clock cand numara descrescator	,mode=mod numarare(cr/descr)   
	CR,BR:out std_logic;  --CR=carry, BR=borrow	transport nr. cr./descr
	Q:out std_logic_vector (3 downto 0));--cifra
end num_mod_10;

architecture comportamental of num_mod_10 is
begin 
	process (R,EN,CU,CD)
	variable C: std_logic :='0';--carry   
	variable B: std_logic :='0';--borrow   
	variable NR: std_logic_vector(3 downto 0) := (others=>'0');	--contor
	begin
		 	 
	   if R='1' then NR:= (others=>'0');C:='0';B:='0'; --resetare
	   else  			
		    if EN='0' then NR:=NR;	--repaus
		    else			
					if mode='0' then   --mod=0=>numara cr.
						if rising_edge(CU) then
							if NR="1001" then NR:="0000";C:='1'; --nr ajunge la 9=>resetare+transport
							else
								NR:=NR+1; C:='0';--numara cr.-transport=0
							end if;
						end if;
						else		  --mod=1=>numara descr.
							if rising_edge(CD) then	
							if(NR = "0000") then NR:= "1001"; B:= '1'; --numaratorul ajunge la final=> nr=9+imprumut
					        else
						    NR:=NR-1; B:='0'; --numara descr.-imprumut=0
					        end if;	
							end if;
				        end if;
		         end if;    
	  end if;
		Q<=NR;
		CR <= C;  --atribuire de valori
		BR <=B;
	end process;
end comportamental;