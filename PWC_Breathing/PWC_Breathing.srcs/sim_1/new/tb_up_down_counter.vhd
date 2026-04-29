library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_up_down_counter is
end tb_up_down_counter;

architecture tb of tb_up_down_counter is

    component up_down_counter
        port (clk  : in std_logic;
              rst  : in std_logic;
              en   : in std_logic;
              brgh : out std_logic_vector (7 downto 0));
    end component;

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '0';
    signal en   : std_logic := '0'; 
    signal brgh : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : std_logic := '0';

begin

    dut : up_down_counter
    port map (clk  => clk,
              rst  => rst,
              en   => en,
              brgh => brgh);

    clk_gen : process
    begin
        while TbSimEnded /= '1' loop
            clk <= '1'; wait for TbPeriod/2;
            clk <= '0'; wait for TbPeriod/2;
        end loop;
        wait;
    end process;


    stimuli : process
    begin

        rst <= '1';
        en  <= '0';
        wait for 50 ns;
        rst <= '0';
        wait for TbPeriod;
        en <= '1'; 

        wait for 6000 ns;

        en <= '0';
        wait for 100 ns;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;