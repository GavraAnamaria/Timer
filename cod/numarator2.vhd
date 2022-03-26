library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity num is		
	port(M,S,EN,CLK: in std_logic;--M,S=butoane pt. incrementat min/sec	  EN=enable
	ST:in std_logic_vector (2 downto 0);--starea generata de UC
	BR:out std_logic;	--borrow=1 cand ajunge la 00:00  
    Q:out std_logic_vector (15 downto 0));	--numarul
end num;

architecture structural of num is

component num_mod_6 is		 --numara 0->5
	port(EN,R,CU,CD,mode: in std_logic;	 --pentru zecile de secunde 
	CR,BR:out std_logic;
	Q:out std_logic_vector (3 downto 0));
end component;

component num_mod_10 is			 --numara 0->9 
	port(EN,R,CU,CD,mode: in std_logic;  --pentru secunde,minute si zeci de minute
	CR,BR:out std_logic;
	Q:out std_logic_vector (3 downto 0));
end component;

component MUX_nr is		  --iesirea=clk pt. min./sec.
	port(sel,clk,buton:in std_logic;    	
	clk1:out std_logic);	
end component;


signal CLK1,clk11,clk12,clk21,clk22,CLK23,clk31,clk32,R,CR,selM,selS,mode:std_logic; 	--semnale interne	   
begin  
	process(ST,M,S)--pt. determinarea selectiilor multiplexoarelor
	begin		   --sel=0=>functionare normala/sel=1=>incrementare minute/secunde

if ST(2)='1' then --stare=incrementare(100)
	selM<='1';	 --selectia pentru multiplexorul  minutelor
	
	if s='1'  then--se incrementeaza secundele
		 selS<='1'; --selectia pentru multiplexorul secundelor
	
	else	      --se incrementeaza minutele
	     selS<=selS; --selectia nu se schimba
    end if;

else --alta stare
	  selS<='0'; --functionare normala
	  selM<='0';
end if;	

		end process;
		
	R<= not ST(0) and not ST(1) and not ST(2); 	   --ST=000=>R=1;
	mode<=ST(0);                                   --mode=0=>cr(st=010)/mode=1=>descr(st=011)	 
	     --SECUNDE--
	C0: MUX_nr port map (selS,clk,S,clk1);	 --clk1=clk/S(incrementare)
	C1: num_mod_10 port map (EN,R,CLK1,CLK,mode,clk11,clk12,Q(3 downto 0));	--clk1=clk/clock corespunzator incrementarii ; clk=clock divizat
	C2: num_mod_6 port map (EN,R,clk11,clk12,mode,clk21,clk22,Q(7 downto 4));  --transportul de la primul numarator(CR=clk11/BR=clk12) e folosit drept clock
	     --MINUTE--
	C3: MUX_nr port map (selM,clk21,M,clk23); --clk23=clk21/M(incrementare)
	C4: num_mod_10 port map (EN,R,clk23,clk22,mode,clk31,clk32,Q(11 downto 8));  --transportul de la al doilea numarator(CR=clk21/BR=clk22) e folosit drept clock		
	C5: num_mod_10 port map (EN,R,clk31,clk32,mode,CR,BR,Q(15 downto 12));			  --clk23=clk21/clock corespunzator incrementarii(M)
																					  --BR=utilizat ca semnal pentru activarea alarmei
end structural;