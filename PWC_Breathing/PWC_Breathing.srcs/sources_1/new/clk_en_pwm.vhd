library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_en_pwm is
generic (G_MAX : positive := 1000); 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : out STD_LOGIC);
end clk_en_pwm;

architecture Behavioral of clk_en_pwm is


    signal sig_pwm_en : integer range 0 to G_MAX-1;

begin

    process (clk) is
    begin
        if rising_edge(clk) then  
            if rst = '1' then     
                ce      <= '0';   
                sig_pwm_en <= 0;     

            elsif sig_pwm_en = G_MAX-1 then
                ce      <= '1';
                sig_pwm_en <= 0; 

            else
                ce      <= '0';
                sig_pwm_en <= sig_pwm_en + 1; 

            end if;  
        end if;      
    end process;

end Behavioral;