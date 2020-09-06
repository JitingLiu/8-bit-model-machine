--model_machine测试向量
LIBRARY ieee  ;  
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE ieee.numeric_std.all  ;
--测试文件的空实体声明
ENTITY model_machine_tb IS 
END model_machine_tb; 
--被测试实体(EUT))须要声明为元件，端口必须与EUT中声明的端口严格匹配
ARCHITECTURE stimulus_arch OF model_machine_tb IS
		constant clockperiod : time := 20 ns; --声明时钟周期常量
		SIGNAL CLK_50M,CLR,rst,clk_out:  STD_LOGIC := '0'; 
		SIGNAL OUTPUT,r_out,d_out:  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
		SIGNAL LD1,ADD1,SUB1,A_AND1,A_SRL1,HALT1: STD_LOGIC:= '0';
COMPONENT model_machine  
PORT(
	CLK_50M,CLR,rst: IN STD_LOGIC;
	clk_out: OUT STD_LOGIC;
	r_out,d_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	LD1,ADD1,SUB1,A_AND1,A_SRL1,HALT1:OUT STD_LOGIC;
	OUTPUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT ;

BEGIN
EUT: model_machine PORT MAP (CLK_50M,CLR,rst,clk_out,r_out,d_out,LD1,ADD1,SUB1,A_AND1,A_SRL1,HALT1,OUTPUT);
--clock generation
process begin
	wait for (clockperiod/2); CLK_50M <= '1';
	wait for (clockperiod/2); CLK_50M <= '0';
end process;
--generate reset
process begin
	clr <= '0'; rst <= '0'; wait for 8 ns;
	clr <= '1'; rst <= '1'; wait;
end process;
end stimulus_arch;
