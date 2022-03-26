library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity UC is						--unitate de control
	port ( CLK,S,M,START,BR: in std_logic;--clock divizat, buton incrementare secunde, buton incrementare minute, buton pornire/oprire, borrow
	EN:OUT std_logic;	   --enable
	ST : inout std_logic_vector (2 downto 0));--stare curenta
end UC;

architecture unitate of UC is 				  
signal R: std_logic;	  --RESET
signal mode: std_logic;	  --cr/descr
signal NXST: std_logic_vector(2 downto 0);--STAREA URMATOARE
begin	
R <= S and M; 

-------------------------------------------------------STABILIREA STARII URMATOARE----------------------------------------------------------------------------

process (R,BR,CLK)	         
variable x:std_logic_vector(2 downto 0):="000";	
begin    	
       if R = '1' or BR='1' then  --S+M/numaratorul ajunge la 0=>resetare
          x := "000";  
       else
		   if (rising_edge(clk)) then							   				     
           x :=NXST; 			  --trece la starea urmatoare
		   end if;	  
	end if;	
	st<=x;
   end process;
   
-------------------------------------------------------IESIREA DIN STAREA CURENTA----------------------------------------------------------------------------   
   
	process (ST,S,M,START)							 
	variable cr: std_logic:='1'; --1 daca numara crescator /0 daca numara descrescator	   
    variable y:std_logic_vector(2 downto 0):="000";
	begin
	case ST is 	
		
--[RESETARE]--
            When "000" =>y:= "001"; cr:='1';EN<='0';      --reset=>asteptare
--[ASTEPTARE]--			
			When "001" =>EN<='0'; 
			              if M = '1' or S='1' then  	  
					            y:= "100";		        --asteptare=>incrementare	  
			              elsif (START = '1') then 
				               if mode='1' then
					               y:= "010";           --asteptare=>numara cr
				          	   else
						           y:="011" ;			--asteptare=>numara descr
						       end if;
					      else
					         y:= "001";		            --asteptare
				          end if;
--[NUMARARE]--			
		    When "010" => cr:='1';EN<='1';
			               if M = '1' or S='1' then 	   
							   y:="100";    	 	    --numarare=>incrementare 	  
				           elsif (START = '1') then 
					             y:= "001";	            --nr=>asteptare
				           else
					             y:= "010";
				           end if; 
						   
--[NUMARARE DESCRESCATOARE]--			
		    When "011"=> cr:='0';EN<='1';
			             if( START  = '1' ) then  
			                  y:= "001";	            --nr descr=>asteptare  
			             elsif M = '1' or s='1' then 	   
							   y:="100";    	 	    --numarare descr=>incrementare
				         else 
				              y:= "011";
				         end if;			   
--[INCREMENTARE]--						   
		    When "100"=> EN<='1';
			             if( START = '1') then	
				                y:= "011";              --incrementare=>nr descr				
				         else
					            y:= "100";
				         end if;			   

--[STARE NECUNOSCUTA]--		
		    when others=>y:= "000";EN<='0';    --stare necunoscuta=>resetare
		
	end case;  
	mode<=cr;
		nxst<=y;
	end process;

end unitate;
