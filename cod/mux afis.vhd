library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MUX is
	port(NR:in std_logic_vector (15 downto 0); --numatul care trebuie afisat
	sel:in std_logic_vector(1 downto 0); 	   --selectia 
	cifra:out std_logic_vector (3 downto 0);   --cifra afisata
	display_A,display_B,display_C,display_D:out std_logic);	 --display.ul pe care e afisata cifra respectiva
end MUX;

architecture comportamental of MUX is
begin

process(sel)   
variable Anod_activ :std_logic_vector(3 downto 0):=(others=>'0');
begin											  
    case sel is	--selectia se schimba periodic
    when "00" =>
	  Anod_activ := "0111";     --primul anod este activ
	  cifra <= NR(15 downto 12);--e afisata prima cifra(zecile de min)
    when "01" =>
	  Anod_activ := "1011";	   --al doilea anod este activ
	  cifra <= NR(11 downto 8);--este afisata a doua cifra (min)
    when "10" =>
	  Anod_activ := "1101";		--al treilea anod este activ
	  cifra <= NR(7 downto 4);	--este afisata a treia cifra (zecile de sec)
    when others =>
	  Anod_activ := "1110"; 	--ultimul anod e activ
	  cifra <= NR(3 downto 0);  --este afisata ultima cifra(sec)
    end case;	
	display_A <= Anod_activ(3);
	display_B <= Anod_activ(2);
	display_C <= Anod_activ(1);
	display_D <= Anod_activ(0);
end process;  
end comportamental;