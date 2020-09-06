--MAR测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY RAM_TB IS 
END RAM_TB; 
--被测试实体(EUT)须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF RAM_TB IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL WR,CS: STD_LOGIC := '0'; 
		SIGNAL DIN,DOUT: STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";
		SIGNAL ADDR: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
COMPONENT RAM  
 PORT( 
	WR,CS:IN STD_LOGIC; 
	DIN:IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
	DOUT:OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
	ADDR:IN STD_LOGIC_VECTOR(3 DOWNTO 0) ); 
END COMPONENT ;

BEGIN
EUT: RAM  PORT MAP (WR,CS, DIN, DOUT, ADDR);
--定义输入激励的语句，放在process语句中
--这样wait语句能用来控制经过的时间
process begin 
	CS <= '0'; wait for clockperiod;
end process;
process begin 
	WR <= '1'; wait for clockperiod;
end process;
process begin 
	IF (ADDR < "1101") THEN
		ADDR <= ADDR + 1; wait for clockperiod; 
	ELSE
		ADDR <= "0000"; wait for clockperiod; 
	END IF;
end process;
end stimulus;