library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_tb is
end;

architecture bench of ALU_tb is

  component ALU
  	PORT 
  	(
  	A, B                     : IN std_logic_vector(7 DOWNTO 0);
  	Carry                    : OUT std_logic;
  	Control                  : IN std_logic_vector(3 DOWNTO 0);
    RESULT					 : OUT std_logic_vector(7 DOWNTO 0)
  	);
  end component;

  signal A, B: std_logic_vector(7 DOWNTO 0);
  signal Carry: std_logic;
  signal Control: std_logic_vector(3 DOWNTO 0);
  signal RESULT: std_logic_vector(7 DOWNTO 0);

begin

  uut: ALU port map ( A       => A,
                      B       => B,
                      Carry   => Carry,
                      Control => Control,
                      RESULT  => RESULT );

  stimulus: process
  begin
  
    A<= "11001101";
    B<= "00000010";
    Control <= "1101";

    wait;
  end process;


end;