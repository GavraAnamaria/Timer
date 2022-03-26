library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity timer is
	port ( CLK,S,M,START: in std_logic;	--clk=clock de la placa, S,M,START=butoane pentru incrementare/ pornire-oprire
	NR2:in std_logic_vector(3 downto 0)	; --nr de secunde pentru care alarma e pornita
	led:out std_logic;	  --=1=>alarma pornita
	display_A,display_B,display_C,display_D:out std_logic;--display-urile pe care e afisata numarul
	A,B,C,D,E,F,G:out std_logic);	   --catozii
end timer;

architecture structural of timer is 
component divizor is					--divizon
	port(CLK: in std_logic; 
	SEL:out std_logic_vector(1 downto 0);
	CLK2,CLK3:out std_logic);
end component;

component UC is							--unitate de control
	port ( CLK,S,M,START,BR: in std_logic;
	EN:OUT std_logic;
	ST: inout std_logic_vector (2 downto 0));
end component;

component num is						 --numarator
	port(M,S,EN,CLK: in std_logic;
	ST:in std_logic_vector (2 downto 0);
	BR:out std_logic; 	  
	Q:out std_logic_vector (15 downto 0));
end component;

component afisaj is						 --afisorul
	port(NR:in std_logic_vector (15 downto 0); 
	sel:in std_logic_vector (1 downto 0);
	display_A,display_B,display_C,display_D:out std_logic;
	A,B,C,D,E,F,G:out std_logic);				 
end component; 

component alarma is			
	port(BR,Clk2: in std_logic;
	NR2:in std_logic_vector(3 downto 0)	;
	led:out std_logic);					 
end component;

signal CLK2,CLK3,BR,EN:std_logic;  --clk divizat pt. numarare/schimbare stare,Borrow pt. activare alarma, enable 
signal Q:std_logic_vector(15 downto 0);--numar de afisat
signal ST:std_logic_vector(2 downto 0);	--starea
signal SEL:std_logic_vector(1 downto 0);--selectie multiplexor

begin			 
	C0: divizor port map (CLK,SEL,CLK2,CLK3);--divizeaza frecventa placii=>perioada mai mare
	C1: UC port map (CLK3,S,M,START,BR,EN,ST); --genereaza strea 
	C2: num port map (M,S,EN,CLK2,ST,BR,Q);  --genereaza numar
    C3: afisaj port map (Q,SEL,display_A,display_B,display_C,display_D,A,B,C,D,E,F,G);	--afiseaza numar
	C4: alarma port map (BR,CLK2,NR2,led); 	   --seteaza alarma

end structural;