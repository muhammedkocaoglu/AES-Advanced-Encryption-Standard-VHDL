----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2020 12:40:35 PM
-- Design Name: 
-- Module Name: tb_aes - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_aes is
--  Port ( );
end tb_aes;

architecture Behavioral of tb_aes is

component generatekey is
	port(
		x             : in std_logic_vector(127 downto 0);
		message       : in std_logic_vector(127 downto 0);
		
		--Output:
		z1,z2,z3,z4   : out std_logic_vector(31 downto 0)

	);
end component;

signal x,message   : std_logic_vector(127 downto 0);
signal z1,z2,z3,z4 : std_logic_vector(31 downto 0);

begin

uut : generatekey port map (x=>x , message=>message , z1=>z1 , z2=>z2 , z3=>z3 , z4=> z4);


--test case--
stim_procc: process
begin
    x <= x"2B7E151628AED2A6ABF7158809CF4F3C";
    message <= x"3243F6A8885A308D313198A2E0370734";
    wait for 20ns;
    
    x <= x"45534b49534548495245454531323334";
    message <= x"4d5548414d4d45444b4f43414f474c55";
    wait for 20ns;
    
    x <= x"00000000000000000000000000000004";
    message <= x"00000000000000000000000000000004";
    wait for 20ns;
   
wait;

end process;

end Behavioral;
