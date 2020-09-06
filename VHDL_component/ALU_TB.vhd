--算术逻辑单元ALU测试向量
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

--测试文件的空实体声明
ENTITY ALU_TB IS 
END ALU_TB; 
--被测试实体(EUT)须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus_arch OF ALU_TB IS
	SIGNAL acc, DR: STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"; 
	SIGNAL rst, alu_add, alu_sub: STD_LOGIC := '0';
	signal alu_and, alu_srl: STD_LOGIC := '0'; 
	SIGNAL alu_out: STD_LOGIC_VECTOR(7 DOWNTO 0):= "00000000"; 
COMPONENT ALU  
PORT ( 
 	rst:in std_logic;
  	acc:in std_logic_vector(7 downto 0);--累加器 	
	DR:in std_logic_vector(7 downto 0);--数据寄存器 		
	alu_add:in std_logic; --add加 	
	alu_sub:in std_logic; --sub减 	
	alu_and:in std_logic; --and与 	
	alu_srl:in std_logic; --srl左移 	
	alu_out:out std_logic_vector(7 downto 0) );--alu计算结果
END COMPONENT;

BEGIN
EUT: ALU PORT MAP (rst, acc, DR,  alu_add, alu_sub, alu_and, alu_srl, alu_out);
--generate reset
	process begin
		rst <= '0'; wait for 20 ns;
		rst <= '1'; wait for 80 ns;
	end process;
	process begin --改为1
		alu_add <= '1'; alu_sub <= '1'; alu_and <= '1'; alu_srl <= '1'; wait for 20ns; 
		alu_srl <= '1'; alu_add <= '0'; wait for 20ns;
		alu_add <= '1'; alu_sub <= '0'; wait for 20ns; 
		alu_add <= '1'; alu_sub <= '1'; alu_and <= '0'; wait for 20ns; 
		alu_add <= '1'; alu_sub <= '1'; alu_and <= '1'; alu_srl <= '0'; wait for 20ns;
	end process;
	process begin 
--	IF (acc < "11111111") THEN
--		wait for 20ns;  acc <= acc + 1;
--	ELSE
--		wait for 20ns; acc <= "00000000";
--	END IF;
		acc <= "00000111"; wait;
	end process;
	process begin
		DR <= "00000110"; wait;
	end process;
end stimulus_arch;