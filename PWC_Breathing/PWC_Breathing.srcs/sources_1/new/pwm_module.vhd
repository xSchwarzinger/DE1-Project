library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Potřebujeme pro to_integer a unsigned

entity pwm_driver is
    Port ( 
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        brgh    : in  STD_LOGIC_VECTOR (7 downto 0); -- Jas z up_down_counteru
        pwm_out : out STD_LOGIC                      -- Výstup na fyzickou LED
    );
end pwm_driver;

architecture Behavioral of pwm_driver is

    -- Maximální hodnota (pro 8 bitů)
    constant C_MAX : integer := 255;
    
    -- Rychlý volnoběžný čítač
    signal sig_cnt : integer range 0 to C_MAX := 0;

begin

    -- 1. Proces: Rychlý čítač (běží pořád na plných 100 MHz)
    p_pwm_cnt : process (clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_cnt <= 0;
            else
                -- Žádný 'en' tu není, počítá to neustále dokola (pilovitý signál)
                if sig_cnt = C_MAX then
                    sig_cnt <= 0;
                else
                    sig_cnt <= sig_cnt + 1;
                end if;
            end if;
        end if;
    end process p_pwm_cnt;

    -- 2. Komparátor: Tady vzniká samotné blikání
    -- Převedeme vstupní dráty (brgh) zpět na číslo a porovnáme s čítačem
    pwm_out <= '1' when (sig_cnt < to_integer(unsigned(brgh))) else '0';

end Behavioral;