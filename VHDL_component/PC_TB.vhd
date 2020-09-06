--PC测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY PC_TB IS 
END PC_TB; 
--被测试实体(EUT)须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF PC_TB IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL IPC,CLK,CLR:  STD_LOGIC  := '0'; 
		SIGNAL PCOUT: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
COMPONENT PC  
PORT( 
 IPC,CLK,CLR:IN STD_LOGIC; 
 PCOUT:OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
 ); 
END COMPONENT ;

BEGIN
EUT: PC  PORT MAP (IPC, CLK, CLR, PCOUT);
--clock generation
process
	begin
	clk <= '0'; wait for (clockperiod/2);
	clk <= '1'; wait for (clockperiod/2); 
end process;
--generate reset
process
		begin
		clr <= '0'; wait for 18 ns;
		clr <= '1'; wait;
end process;
--定义输入激励的语句，放在process语句中
--这样wait语句能用来控制经过的时间
	process begin 
		IPC<='1'; wait;
	end process;
end stimulus;