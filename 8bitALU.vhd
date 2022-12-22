LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

------------------------
---one bit full adder---
------------------------
--Done by Joseph Aoun/Charbel Ghanime/Hussein Zeineddine
ENTITY onebit IS
	PORT 
	(
		X, Y, Cin : IN std_logic;
		S, Cout   : OUT std_logic
	);
END onebit;

ARCHITECTURE onebit OF onebit IS
BEGIN
	S    <= (X XOR Y) XOR Cin;
	Cout <= (X AND Y) OR (X AND Cin) OR (Y AND Cin);
END onebit;

------------------------
--eight bit full adder--
------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY eightbit IS
	PORT 
	(
	X, Y : IN std_logic_vector(7 DOWNTO 0);
	Cin  : IN std_logic;
	S    : OUT std_logic_vector (7 DOWNTO 0);
	Cout : OUT std_logic
	);
END eightbit;

ARCHITECTURE eightbit OF eightbit IS
	COMPONENT onebit
		PORT 
		(
			X, Y, Cin : IN std_logic;
			S, Cout   : OUT std_logic
		);
	END COMPONENT;
	SIGNAL C : std_logic_vector (0 TO 8);-- this is the result vector
BEGIN
	generator : FOR i IN 0 TO 7 GENERATE
		U1        : onebit
		PORT MAP
		(
			X    => X(i), 
			Y    => Y(i), 
			Cin  => C(i), 
			S    => S(i), 
			Cout => C(i + 1) );
		END GENERATE;
        C(0) <= Cin;
		Cout <= C(8);
        END eightbit;
		----------------------------------
		-----designing the half adder-----
		----------------------------------

		LIBRARY IEEE;
        USE IEEE.std_logic_1164.ALL;

		ENTITY halfadder IS 
        PORT 
		(
			X, Y    : IN std_logic;
			s, Carr : OUT std_logic
		);
	END halfadder;

	ARCHITECTURE behaviorale OF halfadder IS
	BEGIN
		S    <= X XOR Y;
		Carr <= X AND Y;
	END behaviorale;

	-----------------------------------
	-----designing the two's compl-----
	-----------------------------------
	LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;

	ENTITY twocompliment IS
		PORT 
		(
		X : IN std_logic_vector(7 DOWNTO 0);
		C : OUT std_logic_vector(7 DOWNTO 0)
		);
	END twocompliment;

	ARCHITECTURE behhave OF twocompliment IS
		COMPONENT eightbit
			PORT 
			(
				X, Y : IN std_logic_vector(7 DOWNTO 0);
				Cin  : IN std_logic;
				S    : OUT std_logic_vector (7 DOWNTO 0);
				Cout : OUT std_logic
			);
		END COMPONENT;
		SIGNAL Z : std_logic;
		SIGNAL p : std_logic_vector(7 DOWNTO 0);
	BEGIN
		generator : FOR i IN 0 TO 7 GENERATE
			p(i) <= NOT (X(i));
		END GENERATE;
		ut : eightbit
		PORT MAP(X => P, Y => "00000001", Cin => '0', S => c, Cout => Z);
	END behhave;

	-----------------------------
	--one bit full substractor---
	-----------------------------

	LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY full_sub IS
		PORT 
		(
		A, B, Cin    : IN std_logic;
		DIFF, Borrow : OUT std_logic
		);
	END ENTITY;

	ARCHITECTURE dataflow OF full_sub IS
	BEGIN
		DIFF   <= (A XOR B) XOR Cin;
		Borrow <= ((NOT A) AND (B OR Cin)) OR (B AND Cin);

	END dataflow;

	-------------------------------
	--eight bit full substractor---
	-------------------------------

	LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY eightbitsub IS
		PORT 
		(
		A, B : IN std_logic_vector(7 DOWNTO 0);
		Cin  : IN std_logic;
		S    : OUT Std_logic_vector(7 DOWNTO 0);
		Cout : OUT Std_logic
		);
	END eightbitsub;

	ARCHITECTURE eightbitsub OF eightbitsub IS
		COMPONENT eightbit
			PORT 
			(
				X, Y : IN std_logic_vector(7 DOWNTO 0);
				Cin  : IN std_logic;
				S    : OUT std_logic_vector(7 DOWNTO 0);
				Cout : OUT std_logic
			);
		END COMPONENT;
		COMPONENT twocompliment
			PORT 
			(
				X : IN std_logic_vector(7 DOWNTO 0);
				C : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
		SIGNAL Z : std_logic_vector(7 DOWNTO 0);
	BEGIN
		ut : twocompliment
		PORT MAP(B, Z);
		uut : eightbit
		PORT MAP(A, Z, '0', S, Cout);
	END eightbitsub;

	---------------------------
	-----designing minimum-----
	---------------------------

	LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY minimum IS
		PORT 
		(
		X, Y : IN std_logic_vector(7 DOWNTO 0);
		C    : OUT std_logic_vector(7 DOWNTO 0)
		);
	END minimum;

	ARCHITECTURE beeehave OF minimum IS
		COMPONENT eightbitsub
			PORT 
			(
				A, B : IN std_logic_vector(7 DOWNTO 0);
				Cin  : IN std_logic;
				S    : OUT Std_logic_vector(7 DOWNTO 0);
				Cout : OUT Std_logic;
			);
		END COMPONENT;
		SIGNAL suii    : std_logic;
		SIGNAL result : std_logic_vector(7 DOWNTO 0);
	BEGIN
		ut : eightbitsub
		PORT MAP(x, y, '0', result, suii);
        c <= x WHEN x(7) = '1' and y(7) = '0' ELSE
             y WHEN x(7) = '0' and y(7) = '1' ELSE 
		     x WHEN result(7) = '1'           ELSE
		     y;
	END beeehave;

	---------------------------
	-----designing maximum-----
	---------------------------

	LIBRARY IEEE;
	USE IEEE.STD_LOGIC_1164.ALL;

	ENTITY maximum IS
		PORT 
		(
		X, Y : IN std_logic_vector(7 DOWNTO 0);
		C    : OUT std_logic_vector(7 DOWNTO 0)
		);
	END maximum;

	ARCHITECTURE beeehave OF maximum IS
		COMPONENT eightbitsub
			PORT 
			(
				A, B : IN std_logic_vector(7 DOWNTO 0);
				Cin  : IN std_logic;
				S    : OUT Std_logic_vector(7 DOWNTO 0);
				Cout : OUT Std_logic;
			);
		END COMPONENT;
		SIGNAL suii    : std_logic;
		SIGNAL result : std_logic_vector(7 DOWNTO 0);
	BEGIN
		ut : eightbitsub
		PORT MAP(x, y, '0', result, suii);
        c <= y WHEN x(7) = '1' and y(7) = '0' ELSE
             x WHEN x(7) = '0' and y(7) = '1' ELSE
             x WHEN result(7) = '0' ELSE
		     y;
	END beeehave;

	---------------------------------
	-----designing circular right----
	---------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY circularright IS
		PORT 
		(
		A       : IN std_logic_vector(7 DOWNTO 0);
		Shifted : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularright;
	ARCHITECTURE behavorial OF circularright IS
	BEGIN
		shifted(7) <= A(0);
		generated : FOR i IN 7 DOWNTO 1 GENERATE
			shifted(i - 1) <= A(i);
		END GENERATE;
	END behavorial;

	---------------------------------
	-----designing circular left-----
	---------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY circularleft IS
		PORT 
		(
		A       : IN std_logic_vector(7 DOWNTO 0);
		Shifted : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularleft;
	ARCHITECTURE behavorial OF circularleft IS
	BEGIN
		shifted(0) <= A(7);
		gernerated : FOR i IN 6 DOWNTO 0 GENERATE
			shifted(i + 1) <= A(i);
		END GENERATE;
	END behavorial;

	----------------------------------------
	-----designing circularleftwithzero-----
	----------------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY circularleftwithzero IS
		PORT 
		(
		A               : IN std_logic_vector(7 DOWNTO 0);
		Shiftedwihtzero : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularleftwithzero;
	ARCHITECTURE behavorial OF circularleftwithzero IS
	BEGIN
		Shiftedwihtzero(0) <= '0';
		generated : FOR i IN 6 DOWNTO 0 GENERATE
			Shiftedwihtzero(i + 1) <= A(i);
		END GENERATE;
	END behavorial;

	------------------------------------------
	-----designing circularrighttwithzero-----
	------------------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY circularrightwithzero IS
		PORT 
		(
		A               : IN std_logic_vector(7 DOWNTO 0);
		Shiftedwihtzero : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularrightwithzero;
	ARCHITECTURE behavorial OF circularrightwithzero IS
	BEGIN
    	Shiftedwihtzero(7) <= '0';
		generated : FOR i IN 7 DOWNTO 1 GENERATE
			Shiftedwihtzero(i - 1) <= A(i);
		END GENERATE;
	END behavorial;

	--------------------------------------------
	-----designing circularrightreplication-----
	--------------------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY circularrightreplication IS
		PORT 
		(
		A                : IN std_logic_vector(7 DOWNTO 0);
		replicationright : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularrightreplication;
	ARCHITECTURE behavorial OF circularrightreplication IS
	BEGIN
		replicationright(6) <= A(7);
		replicationright(7) <= A(7);

		generated : FOR i IN 6 DOWNTO 1 GENERATE
			replicationright(i - 1) <= A(i);

		END GENERATE;

	END behavorial;

	--------------------------------------------
	-----designing circularleftreplication-----
	--------------------------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;
	ENTITY circularleftreplication IS
		PORT 
		(
		A               : IN std_logic_vector(7 DOWNTO 0);
		replicationleft : OUT std_logic_vector(7 DOWNTO 0)
		);
	END circularleftreplication;
	ARCHITECTURE behavorial OF circularleftreplication IS
	BEGIN
		replicationleft(0) <= A(0);
		replicationleft(1) <= A(7);
		generated : FOR i IN 6 DOWNTO 1 GENERATE
			replicationleft(i + 1) <= A(i);
		END GENERATE;
	END behavorial;

	---------------------------
	-----designing the ALU-----
	---------------------------

	LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

	ENTITY ALU IS
		PORT 
		(
		A, B    : IN std_logic_vector(7 DOWNTO 0);
		Carry   : OUT std_logic;
		Control : IN std_logic_vector(3 DOWNTO 0);
		RESULT  : OUT std_logic_vector(7 DOWNTO 0)
		);
	END ALU;

	ARCHITECTURE behave OF ALU IS
					------------------
		COMPONENT eightbit
			PORT 
			(
				X, Y : IN std_logic_vector(7 DOWNTO 0);
				Cin  : IN std_logic;
				S    : OUT std_logic_vector (7 DOWNTO 0);
				Cout : OUT std_logic
			);
		END COMPONENT;
					------------------
		COMPONENT halfadder
			PORT 
			(
				X, Y    : IN std_logic;
				S, Carr : OUT std_logic
			);
		END COMPONENT;
					------------------
		COMPONENT twocompliment
			PORT 
			(
				X : IN std_logic_vector (7 DOWNTO 0); 
                C    : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT eightbitsub
            PORT 
            (
                A, B : IN std_logic_vector(7 DOWNTO 0);
                Cin  : IN std_logic;
                S    : OUT Std_logic_vector(7 DOWNTO 0);
                Cout : OUT Std_logic
            );
		END COMPONENT;
					------------------
		COMPONENT circularright
			PORT 
			(
				A       : IN std_logic_vector(7 DOWNTO 0);
				Shifted : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT minimum
			PORT 
			(
				X, Y : IN std_logic_vector(7 DOWNTO 0);
				C    : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT maximum
			PORT 
			(
				X, Y : IN std_logic_vector(7 DOWNTO 0);
				C    : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT circularrightwithzero
			PORT 
			(
				A               : IN std_logic_vector(7 DOWNTO 0);
				Shiftedwihtzero : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT circularleft
			PORT 
			(
				A       : IN std_logic_vector(7 DOWNTO 0);
				Shifted : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT circularleftwithzero
			PORT 
			(
				A               : IN std_logic_vector(7 DOWNTO 0);
				Shiftedwihtzero : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT circularrightreplication
			PORT 
			(
				A                : IN std_logic_vector(7 DOWNTO 0);
				replicationright : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
		COMPONENT circularleftreplication
			PORT 
			(
				A               : IN std_logic_vector(7 DOWNTO 0);
				replicationleft : OUT std_logic_vector(7 DOWNTO 0)
			);
		END COMPONENT;
					------------------
                    signal A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, B1, B2, B3, B4, RESULT1, RESULT2, RESULT3, RESULT4, RESULT5, RESULT6, RESULT7, RESULT8, RESULT9, RESULT10: STD_LOGIC_vector(7 downto 0);
                    signal carry1 : STD_LOGIC; 
        
    BEGIN
    	uut1 : eightbit                 PORT MAP (A1, B1, '0',  RESULT1, CARRY);
        uut2:  eightbitsub   			PORT MAP (A2, B2, '0', RESULT2, carry1);
        uut3:  minimum       			PORT MAP (A3, B3, RESULT3);
        uut4:  maximum       			PORT MAP (A4, B4, RESULT4);
        uut5:  circularright 			PORT MAP (A5, RESULT5);
        uut6:  circularleft  		    PORT MAP (A6, RESULT6);
        uut7:  circularrightwithzero    PORT MAP (A7, RESULT7);
        uut8:  circularleftwithzero     PORT MAP (A8, RESULT8);
        uut9:  circularrightreplication PORT MAP (A9, RESULT9);
        uut11: circularleftreplication	PORT MAP (A10, RESULT10);
        controlo: process (CONTROL)
        	BEGIN
            	if(CONTROL = "0001") then 
                	A1 <=A;
                    B1<= B;
                elsif(CONTROL = "0010") then
                	A1<=A;
                    B1<="00000001";
				elsif( CONTROL = "0011") then
                	A2<=A;
                    B2<=B;
                elsif( CONTROL = "0100") then
                	A2<=A;
                    B2<= "00000001";
                elsif( CONTROL = "0110") then
                	A3<= A;
                    B3 <= B;
                elsif( CONTROL = "0111") then
                	A4<= A;
                    B4 <= B;
                elsif( CONTROL = "1000" ) then
                	A5<= A;
                elsif (CONTROL = "1001" ) then
                	A6<=A;
                elsif( CONTROL = "1010") then
                	A7<=A;
                elsif( CONTROL = "1011") then
                	A8<=A;
                elsif( CONTROL = "1100" ) then
                	A9 <= A;
                elsif( CONTROL = "1101" ) then
                	A10<= A;
       END IF;
       END PROCESS;    
END behave;