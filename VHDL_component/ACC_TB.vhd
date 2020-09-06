--累加器ACC序列检测器测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;

--测试文件的空实体声明
ENTITY ACC_TB IS 
END ACC_TB; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF ACC_TB IS
		constant clockperiod : time := 10 ns; --声明时钟周期常量
		SIGNAL DATA_IN: STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"; --输入
		SIGNAL IA: STD_LOGIC := '0'; --输入控制信号
		SIGNAL EA: STD_LOGIC := '0'; --输出控制信号
		SIGNAL CLK: STD_LOGIC := '0'; 
		SIGNAL DATA_OUT: STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"; --输出  
COMPONENT ACC  
PORT( 
	DATA_IN:IN STD_LOGIC_VECTOR(7 DOWNTO 0); --输入
	IA:IN STD_LOGIC; --输入控制信号
	EA:IN STD_LOGIC; --输出控制信号
	CLK:IN STD_LOGIC; 
	DATA_OUT:OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ); --输出 
END COMPONENT ;

BEGIN
EUT: ACC  PORT MAP (DATA_IN, IA, EA, CLK , DATA_OUT);
--CLK
process
	begin
	 CLK <= '0'; wait for (clockperiod/2);
	 CLK <= '1'; wait for (clockperiod/2);
end process;
--IA周期是CLK的2倍
process
	begin
	 IA <= '0'; wait for (clockperiod);
	 IA <= '1'; wait for (clockperiod);
end process;
--定义输入激励的语句，放在process语句中
--这样wait语句能用来控制经过的时间
process begin 
	IF (DATA_IN < "11111111") THEN
		 wait for 10ns; DATA_IN <= DATA_IN + 1;
	ELSE
		DATA_IN <= "00000000";
	END IF;
end process;
end stimulus;