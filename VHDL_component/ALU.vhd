library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is  
port(
 	rst:in std_logic;
  	acc:in std_logic_vector(7 downto 0);--累加器 	
	dr:in std_logic_vector(7 downto 0);--数据寄存器 		
	alu_add:in std_logic; --add加 	
	alu_sub:in std_logic; --sub减 	
	alu_and:in std_logic; --and与 	
	alu_srl:in std_logic; --srl左移 	
	alu_out:out std_logic_vector(7 downto 0)); --alu计算结果
end ALU;

architecture DATAFLOW of ALU is
signal acc1:std_logic_vector(7 downto 0);
begin
	alu_out <= acc1;
	process(rst, alu_add, alu_sub, alu_and, alu_srl, dr) 
	begin
		if rst='0' then
			acc1 <= "00000000"; 	
		else 
			if alu_add='0' then
				acc1 <= acc + dr; --累加器内容为它本身加上数据寄存器内容
			elsif alu_sub='0' then
				acc1 <= acc - dr; --减法			
			elsif alu_and='0' then
				acc1 <= acc and dr; --与运算		
			elsif alu_srl='0' then				
				acc1 <= acc(6 downto 0)&'0'; --左移
			end if;		
		end if;
	end process;	
end DATAFLOW;