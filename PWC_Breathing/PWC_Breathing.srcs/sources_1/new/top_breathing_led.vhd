library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_breathing_led is
    Port (
        clk   : in  STD_LOGIC; 
        btnu  : in  STD_LOGIC; 
        led15 : out STD_LOGIC  -- Výstup na LED
    );
end top_breathing_led;

architecture Behavioral of top_breathing_led is
    signal sig_cnt_en : std_logic; 
    signal sig_pwm_en : std_logic; 
    signal cnt_out    : std_logic_vector(7 downto 0);

begin

    CLK_EN_BREATH : entity work.clk_en
        generic map (G_MAX => 500000)
        port map (
            clk => clk,
            rst => btnu,
            ce  => sig_cnt_en
        );

    CLK_EN_PWM : entity work.clk_en_pwm
        generic map (G_MAX => 1000)
        port map (
            clk => clk,
            rst => btnu,
            ce  => sig_pwm_en
        );

    COUNTER : entity work.up_down_counter
        port map (
            clk  => clk,
            rst  => btnu,
            en   => sig_cnt_en,
            brgh => cnt_out
        );

    PWM : entity work.pwm_driver
        port map (
            clk     => clk,
            rst     => btnu,
            en      => sig_pwm_en, 
            brgh    => cnt_out, 
            pwm_out => led15
        );

end Behavioral;