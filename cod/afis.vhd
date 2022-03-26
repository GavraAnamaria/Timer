library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity afisaj is
	port(NR:in std_logic_vector (15 downto 0);--numarul care trebuie afisat 
	sel:in std_logic_vector (1 downto 0);	--selectia multiplexorului
	display_A,display_B,display_C,display_D:out std_logic;--display activ
	A,B,C,D,E,F,G:out std_logic);	--catozi			 
end afisaj;

architecture structural of afisaj is

  component MUX is							 --multiplexor
	port(NR:in std_logic_vector (15 downto 0);
	sel:in std_logic_vector(1 downto 0); 
	cifra:out std_logic_vector (3 downto 0);
	display_A,display_B,display_C,display_D:out std_logic);
end component;

component DCD is								 --decodificator
	port(NR:in std_logic_vector (3 downto 0);
	A,B,C,D,E,F,G:out std_logic);				 
end component;
					 
signal cifra:std_logic_vector(3 downto 0);	 

begin 	   						  
	C2:MUX port map(NR,sel,cifra,display_A,display_B,display_C,display_D);	--activeaza anozii si selecteaza cifra care trebuie afisata in functie de anodul activ
	C3:DCD port map(cifra,A,B,C,D,E,F,G);	   --afisea	cifra selectata activand catozii corespunzatori
end structural;	 
