--MAR测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY MAR_TB IS 
END MAR_TB; 
--被测试实体(EUT)须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF MAR_TB IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL IMAR,CLK: STD_LOGIC  := '0'; 
		SIGNAL ADDR_IN,ADDR_OUT: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
COMPONENT MAR  
PORT( 
	ADDR_IN:IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
	IMAR:IN STD_LOGIC; 
	CLK:IN STD_LOGIC; 
	ADDR_OUT:OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END COMPONENT ;

BEGIN
EUT: MAR  PORT MAP (ADDR_IN, IMAR, CLK, ADDR_OUT);
--clock generation
process
	begin
	clk <= '0'; wait for (clockperiod/2);
	clk <= '1'; wait for (clockperiod/2); 
end process;
--定义输入激励的语句，放在process语句中
--这样wait语句能用来控制经过的时间
process begin 
	IMAR <= '0'; wait;
end process;
process begin 
	IF (ADDR_IN < "1101") THEN
		ADDR_IN <= ADDR_IN + 1; wait for clockperiod; 
	ELSE
		ADDR_IN <= "0000"; wait for clockperiod;
	END IF;
end process;
end stimulus;