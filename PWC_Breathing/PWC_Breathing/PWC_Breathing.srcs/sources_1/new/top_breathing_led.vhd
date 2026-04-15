library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definice vstupů a výstupů
entity top_breathing_led is
    Port (
        clk   : in  STD_LOGIC; 
        btnu  : in  STD_LOGIC; 
        led15 : out STD_LOGIC  -- Výstup na LED
    );
end top_breathing_led;

architecture Behavioral of top_breathing_led is

   -- 1. Definice vnitřních signálů
    signal sig_cnt_en : std_logic;
    signal cnt_out    : std_logic_vector(7 downto 0);

begin

    -- 2. Zapojení bloku CLK_EN
    CLK_EN : entity work.clk_en
        port map (
            clk        => clk,
            rst        => btnu,
            ce => sig_cnt_en
        );

    -- 3. Zapojení bloku UP_DOWN_COUNTER
    COUNTER : entity work.up_down_counter
        port map (
            clk     => clk,
            rst     => btnu,
            en      => sig_cnt_en,
            brgh => cnt_out
        );

    -- 4. Zapojení bloku PWM_DRIVER
    PWM : entity work.pwm_driver
        port map (
            clk        => clk,
            rst        => btnu,
            brgh => cnt_out, 
            pwm_out      => led15
        );

end Behavioral;