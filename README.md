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

# Komponenty
## clk_en

## up_down_counter
Funguje jako klasický counter s tím rozdílem, že počítá od 0 do 255 a poté začne odečítat zpět do 0. Má vstupy __clk__, __rst__ (z tlačítka btnu) a __en__ (z komponenty clk_en) a výstup __brgh__, neboli jas LEDky.
<img width="1261" height="572" alt="image" src="https://github.com/user-attachments/assets/2e62324f-69ae-47a8-81fe-bd5604bc6af1" />

## pwm_driver

# Authors
Jan Feik, Mathias Schwarzinger
