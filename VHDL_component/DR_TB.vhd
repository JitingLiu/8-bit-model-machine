--DR测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY DR_TB IS 
END DR_TB; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF DR_TB IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL IDR,EDR,CLK:  STD_LOGIC  := '0'; 
		SIGNAL DATA_IN,DATA_OUT:  STD_LOGIC_VECTOR(7 downto 0)  := "00000000"; 
COMPONENT DR  
PORT( 
 DATA_IN:IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
 IDR:IN STD_LOGIC; 
 EDR:IN STD_LOGIC; 
 CLK:IN STD_LOGIC; 
 DATA_OUT:OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ); 
END COMPONENT ;

BEGIN
EUT: DR PORT MAP ( DATA_IN, IDR, EDR, CLK, DATA_OUT );
--clock generation
process begin
	wait for (clockperiod/2); clk <= '1';
	wait for (clockperiod/2); clk <= '0';
end process;
--IDR
process begin
	wait for (clockperiod); IDR <= '1';
	wait for (clockperiod); IDR <= '0';
end process;
--EDR
process begin
	wait for (clockperiod); EDR <= '1';
	wait for (clockperiod); EDR <= '0';
end process;
--定义输入激励的语句，放在process语句中
--这样wait语句能用来控制经过的时间
	process begin 
IF (DATA_IN < "11111111") THEN
		 wait for (clockperiod*2); DATA_IN <= DATA_IN + 1;
	ELSE
		DATA_IN <= "00000000";
	END IF;
	end process;
end stimulus;