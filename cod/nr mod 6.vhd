library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity num_mod_6 is
	port(EN,R,CU,CD,mode: in std_logic;	--EN=enable, R=reset, CU=clock cand numara crescator, CD=clock cand numara descrescator, mode=mod numarare(cr/descr)    
	CR,BR:out std_logic;  --transport
	Q:out std_logic_vector (3 downto 0));--cifra
end num_mod_6;

architecture comportamental of num_mod_6 is
begin 
	process (R,EN,CU,CD)
	variable C: std_logic :='0'; --carry  
		variable B: std_logic :='0';--borrow
	variable NR: std_logic_vector(3 downto 0) := (others=>'0');--contor
	begin
		
	  if R='1' then NR:= (others=>'0');C:='0';B:='0';	--resetare
	  else
            if EN='0' then NR:=NR;		--repaus
		    else
				if mode='0' then 	--=>numara cr.
					
						if rising_edge(CU) then 
							if NR="0101" then NR:="0000";C:='1';--nr=5=>resetare+transport
							else
								NR:=NR+1; C:='0';--numara cr.
							end if;
						end if;
						else 	 --=>numara descr.
						if rising_edge(CD) then 
							if(NR = "0000") then NR:= "0101"; B:= '1'; --nr. ajunge la final=>nr=5+imprumut
					        else
						    NR:=NR-1; B:='0';	 --numara descr.
					        end if;
				        end if;
			        end if;	
		  end if;
	end if;
				
		Q<=NR;
		CR <= C;--atribuirea valorilor
		BR <=B;
	end process;
end comportamental;