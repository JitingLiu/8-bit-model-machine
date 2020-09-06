
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;

--测试文件的空实体声明
ENTITY CTRL_TB IS 
END CTRL_TB; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus OF CTRL_TB IS
		constant clockperiod : time := 10 ns; --声明时钟周期常量
		SIGNAL LD,ADD,SUB,A_AND,A_SRL,HALT: STD_LOGIC := '0'; 
		SIGNAL CLK: STD_LOGIC := '0'; 
		SIGNAL T0,T1,T2,T3,T4,T5,T6,T7: STD_LOGIC := '0'; 
		SIGNAL IPC,IMAR,IDR,EDR,IA,EA,ALU_ADD,ALU_SUB,ALU_AND,ALU_SRL,IIR: STD_LOGIC := '0'; --输出 
COMPONENT CTRL  
	PORT( 
	LD,ADD,SUB,A_AND,A_SRL,HALT:IN STD_LOGIC; --操作指令信号
	CLK:IN STD_LOGIC; 
	T0,T1,T2,T3,T4,T5,T6,T7:IN STD_LOGIC; --节拍脉冲
	IPC,IMAR,IDR,EDR,IA,EA,ALU_ADD,ALU_SUB,ALU_AND,ALU_SRL,IIR:OUT STD_LOGIC ); --输出为十一个控制信号
END COMPONENT ;

BEGIN
EUT: CTRL  PORT MAP (LD,ADD,SUB,A_AND,A_SRL,HALT,CLK,T0,T1,T2,T3,T4,T5,T6,T7,
						IPC,IMAR,IDR,EDR,IA,EA,ALU_ADD,ALU_SUB,ALU_AND,ALU_SRL,IIR);
--CLK
process
	begin
	 CLK <= '0'; wait for (clockperiod/2);
	 CLK <= '1'; wait for (clockperiod/2);
end process;
--ADD周期是CLK的2倍
process
	begin
	 ADD <= '0'; wait for (clockperiod);
	 ADD <= '1'; wait for (clockperiod);
end process;
--LD周期是CLK的2倍
process
	begin
	 LD <= '0'; wait for (clockperiod);
	 LD <= '1'; wait for (clockperiod);
end process;
--SUB周期是CLK的2倍
process
	begin
	 SUB <= '0'; wait for (clockperiod);
	 SUB <= '1'; wait for (clockperiod);
end process;
--A_AND周期是CLK的2倍
process
	begin
	 A_AND <= '0'; wait for (clockperiod);
	 A_AND <= '1'; wait for (clockperiod);
end process;
--A_SRL周期是CLK的2倍
process
	begin
	 A_SRL <= '0'; wait for (clockperiod);
	 A_SRL <= '1'; wait for (clockperiod);
end process;
--HALT周期是CLK的2倍,与他们相反
process
	begin
	 HALT <= '1'; wait for (clockperiod);
	 HALT <= '0'; wait for (clockperiod);
end process;
--节拍脉冲
process
	begin
	T0 <= '0'; T1 <= '0';T2 <= '0';T3 <= '0';T4 <= '1';T5 <= '1';T6 <= '1';T7 <= '1'; wait for (clockperiod*2);
	T0 <= '1'; T1 <= '1';T2 <= '1';T3 <= '1';T4 <= '0';T5 <= '0';T6 <= '0';T7 <= '0'; wait for (clockperiod*2);
end process;

end stimulus;