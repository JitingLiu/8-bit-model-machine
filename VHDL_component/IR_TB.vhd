--IR测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY IR_TB IS 
END IR_TB; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF IR_TB IS
		constant clockperiod : time := 40 ns; --声明时钟周期常量
		SIGNAL DATA_IN :STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
		SIGNAL IIR, CLK, LD, ADD, SUB, A_AND, A_SRL, HALT:  STD_LOGIC  := '0'; 
COMPONENT IR  
PORT( 
	DATA_IN:IN STD_LOGIC_VECTOR(7 DOWNTO 0); --输入
	IIR:IN STD_LOGIC; --使能。低有效
	CLK:IN STD_LOGIC; 
	LD,ADD,SUB,A_AND,A_SRL,HALT: OUT STD_LOGIC ); 
END COMPONENT ;

BEGIN
EUT: IR PORT MAP ( DATA_IN, IIR, CLK, LD, ADD, SUB, A_AND, A_SRL, HALT );
--clock generation
process
	begin
	 CLK <= '0'; wait for (clockperiod/2); 
	 CLK <= '1'; wait for (clockperiod/2);
end process;
--定义输入激励的语句，放在process语句中
process begin 
	DATA_IN <= "00111110"; wait for clockperiod;
	DATA_IN <= "11000110"; wait for clockperiod;
	DATA_IN <= "00110011"; wait for clockperiod;
	DATA_IN <= "01110001"; wait for clockperiod;
	DATA_IN <= "10110110"; wait for clockperiod;
	DATA_IN <= "01110110"; wait for clockperiod;
end process;
end stimulus;
