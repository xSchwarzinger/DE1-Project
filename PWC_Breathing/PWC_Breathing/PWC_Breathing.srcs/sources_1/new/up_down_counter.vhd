library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           brgh : out STD_LOGIC_VECTOR (7 downto 0));
end up_down_counter;

architecture Behavioral of up_down_counter is

    constant C_MAX : integer := 255;
    
    -- Vnitřní signál pro počítání
    signal sig_cnt : integer range 0 to C_MAX := 0;
    
    -- Signál, který určuje směr počítání, když bude 0 tak počítáme nahoru, když 1 tak počítáme dolů.
    signal sig_direction : std_logic := '0';  

begin

    p_counter : process (clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then -- Reset, při kterém začneme počítat opět od nuly nahoru
                sig_cnt <= 0;
                sig_direction <= '0'; 

            elsif en = '1' then
                if sig_direction = '0' then -- počítání nahoru
                    if sig_cnt = C_MAX then -- Pokud jsme dopočítali do 255, otočíme směr počítání a začneme počítat dolů
                        sig_direction <= '1';
                        sig_cnt <= sig_cnt - 1;
                    else
                        sig_cnt <= sig_cnt + 1;
                    end if;
                else -- počítání dolů
                    if sig_cnt = 0 then
                        sig_direction <= '0'; -- Pokud jsme dopočítali do 0, otočíme směr počítání a začneme počítat nahoru
                        sig_cnt <= sig_cnt + 1;
                    else
                        sig_cnt <= sig_cnt - 1;
                    end if;
                end if;
            end if;
        end if;
    end process p_counter;

    -- Převod z int na std_logic_vector
    brgh <= std_logic_vector(to_unsigned(sig_cnt, 8));

end Behavioral;