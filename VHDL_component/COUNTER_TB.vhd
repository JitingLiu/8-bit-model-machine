--COUNTER序列检测器测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY COUNTER_TB IS 
END COUNTER_TB; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF COUNTER_TB IS
		constant clockperiod : time := 100 ns; --声明时钟周期常量
		SIGNAL CLK,CLR,T0,T1,T2,T3,T4,T5,T6,T7:  STD_LOGIC  := '0'; 
COMPONENT COUNTER  
PORT( 
	CLK,CLR:IN STD_LOGIC; 
	T0,T1,T2,T3,T4,T5,T6,T7:OUT STD_LOGIC ); 
END COMPONENT ;
BEGIN
EUT: COUNTER  
PORT MAP (CLK,CLR,T0,T1,T2,T3,T4,T5,T6,T7);
--clock generation
process
	begin
	 CLK <= '0';wait for (clockperiod/2);
	 CLK <= '1';wait for (clockperiod/2);
end process;
--generate reset
process
	begin
	clr <= '0'; wait for 18 ns;
	clr <= '1'; wait;
end process;
end stimulus;