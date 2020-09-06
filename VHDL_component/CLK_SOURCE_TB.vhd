--CLK_SOURCE测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY CLK_SOURCE_TB IS 
END CLK_SOURCE_TB; 

--被测试实体(EUT)须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF CLK_SOURCE_TB IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL CLK_50M, CLK: STD_LOGIC := '0'; 
COMPONENT CLK_SOURCE IS
	PORT( 
	CLK_50M:IN STD_LOGIC; --时钟频率为 50MHZ 即周期为 20ns
	CLK: OUT STD_LOGIC ); --时钟周期为 0.2s
END COMPONENT ;

BEGIN
EUT: CLK_SOURCE PORT MAP ( CLK_50M, CLK );
--clock generation
process begin
	 wait for (clockperiod/2);  CLK_50M <= '1';
	 wait for (clockperiod/2);  CLK_50M <= '0';
end process;
end stimulus;