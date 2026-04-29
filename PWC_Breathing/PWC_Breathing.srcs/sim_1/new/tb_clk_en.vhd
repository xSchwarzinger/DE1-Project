library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clk_en is

end tb_clk_en;

architecture Behavioral of tb_clk_en is
    signal clk  : std_logic := '0';
    signal rst  : std_logic := '0';
    signal ce   : std_logic;
    constant C_CLK_PERIOD : time := 10 ns;

begin

    uut : entity work.clk_en_pwm
        generic map (G_MAX => 10) 
        port map (
            clk => clk,
            rst => rst,
            ce  => ce
        );

    p_clk_gen : process
    begin
        clk <= '0';
        wait for C_CLK_PERIOD / 2;
        clk <= '1';
        wait for C_CLK_PERIOD / 2;
    end process p_clk_gen;

    p_stimulus : process
    begin
        rst <= '1';             
        wait for 20 ns;
        rst <= '0';             
        wait for 200 ns;        
        
        wait;                   
    end process p_stimulus;

end Behavioral;