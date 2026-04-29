library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pwm_driver is
end tb_pwm_driver;

architecture Behavioral of tb_pwm_driver is
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal en      : std_logic := '0';
    signal brgh    : std_logic_vector(7 downto 0) := "00000000";
    signal pwm_out : std_logic;

    constant C_CLK_PERIOD : time := 10 ns;

begin

    uut : entity work.pwm_driver
        port map (
            clk     => clk,
            rst     => rst,
            en      => en,
            brgh    => brgh,
            pwm_out => pwm_out
        );


    p_clk_gen : process
    begin
        clk <= '0'; wait for C_CLK_PERIOD / 2;
        clk <= '1'; wait for C_CLK_PERIOD / 2;
    end process;



 p_stimulus : process
    begin
        rst <= '1'; wait for 50 ns;
        rst <= '0';
        
        brgh <= "01010000"; 
        

        for i in 0 to 500 loop
            en <= '1'; wait for 10 ns; 
            en <= '0'; wait for 10 ns;
        end loop;

        brgh <= "11001000"; 
        
        for i in 0 to 500 loop
            en <= '1'; wait for 10 ns; 
            en <= '0'; wait for 10 ns;
        end loop;

        wait;
    end process;
end Behavioral;