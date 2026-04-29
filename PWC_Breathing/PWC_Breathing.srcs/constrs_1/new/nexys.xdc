# =================================================
# Nexys A7-50T - Ořezaný XDC pro PWM Breathing LED
# =================================================

# -----------------------------------------------
# Clock (Hodiny 100 MHz)
# -----------------------------------------------
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

# -----------------------------------------------
# Push buttons (Reset)
# -----------------------------------------------
# Mapujeme btnu na fyzický pin M18 (horní tlačítko)
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports { btnu }];

# -----------------------------------------------
# LED (Výstup PWM)
# -----------------------------------------------
# Mapujeme led15 na fyzický pin V11 (úplně levá LED nad přepínači)
set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { led15 }];