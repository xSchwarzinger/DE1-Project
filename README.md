[Uploading Untitled Diagram.drawio…]()
# DE1-Project
This repository contains files form our VHDL project for Digital Electronics 1
# Project
1 - PWM Breathing
# Funkcionalita
Náš program bude postupně rozsvicovat a zhasínat LED tak, aby simuloval nádech a výdech.\
## Použité součástky na desce:
  ### BTNU
  Funguje jako reset tlačítko. Vždy vrátí dýchání na začátek nádechu.
  ### LED 15
  LEDka, kterou jsme vybrali - bude simulovat dýchání
# Blokové schéma
<img width="844" height="322" alt="image" src="https://github.com/user-attachments/assets/bc7a2856-1f1d-4dc3-ada6-a1c598086dec" />

# Moduly
## clk_en
Slouží jako metronom. Generuje krátký puls __ce__, který trvá jeden takt hlavních hodin a opakuje se v intervalu daném parametrem G_MAX. To umožňuje synchronně řídit pomalé procesy, jako je změna jasu LED, při zachování 100MHz frekvence systému.
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset; vynuluje čítač i vstup\
__ce__ - Výstupní puls

## up_down_counter
Funguje jako klasický counter s tím rozdílem, že generuje 8bitovou hodnotu (0–255), která se plynule zvyšuje a snižuje, čímž vytváří trojúhelníkový průběh signálu. 
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset; vrací čítač na 0 a nastavuje směr počítání nahoru\
__en__ - Vstup pro povolení čítání (připojuje se k výstupu ce modulu clk_en)\
__brgh__ - 8bitový výstupní vektor (0–255) reprezentující aktuální jas

<img width="1261" height="572" alt="image" src="https://github.com/user-attachments/assets/2e62324f-69ae-47a8-81fe-bd5604bc6af1" />
Simulace __up_down_counter__, která ukazuje jak se při hodnotě 255 mění směr počítání signálu

## pwm_driver
Tento modul slouží jako digitálně-analogový převodník využívající __PWM__. Převádí 8bitovou hodnotu jasu na digitální signál, jehož střída odpovídá požadované intenzitě svitu LED.
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset\
__brgh__ - 8bitový vstupní vektor (0–255) reprezentující aktuální jas\
__pwm_out__ - Výstupní PWM signál připojený přímo na fyzickou LED.

# Authors
Jan Feik, Mathias Schwarzinger
