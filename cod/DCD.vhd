library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity DCD is	   --decodificator
	port(NR:in std_logic_vector (3 downto 0);--cifra afisata
	A,B,C,D,E,F,G:out std_logic);		--catozii		 
end DCD;

architecture comportamental of DCD is
begin 
	process (NR)				  
	variable V: std_logic_vector(6 downto 0) := (others=>'0'); --fiecare cifra reprezinta un catod
	begin
		case NR is
			when "0000" => V:="1111110"; --=>0
			when "0001" => V:="0110000"; --=>1
			when "0010" => V:="1101101"; --=>2          
			when "0011" => V:="1111001"; --=>3
			when "0100" => V:="0110011"; --=>4
			when "0101" => V:="1011011"; --=>5
			when "0110" => V:="0011111"; --=>6
			when "0111" => V:="1110000"; --=>7
			when "1000" => V:="1111111"; --=>8
			when "1001" => V:="1111011"; --=>9
		    when others=> v:="1111111";	 --=>8 pentru erori
		end case;
		A <=V(6); 
		B <=V(5);
		C <=V(4);
		D <=V(3);	 --atribuirea de val pt. catozi
		E <=V(2);
		F <=V(1);
		G <=V(0);
	end process;
end comportamental;

		