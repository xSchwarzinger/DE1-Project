# DE1-Projekt
Tento repozitář obsahuje soubory z našeho projektu ve VHDL pro předmět Digitální elektronika 1.
# Projekt
1 - PWM Breathing
# Funkcionalita
Náš program bude postupně rozsvicovat a zhasínat LED tak, aby simuloval nádech a výdech. Celý systém funguje na principu digitálního řízení jasu pomocí pulzně šířkové modulace (PWM). Základem jsou dva frekvenční děliče (clk_en a clk_en_pwm), které z vysokofrekvenčního hodinového signálu FPGA (100 MHz) vytvářejí dva různé časové impulsy. Pomalejší impuls řídí obousměrný čítač (up_down_counter), který plynule zvyšuje a snižuje 8bitovou hodnotu jasu v čase, čímž vytváří efekt „dýchání“. Rychlejší impuls pak určuje pracovní frekvenci PWM driveru, který tuto hodnotu jasu porovnává s vnitřním rychlým čítačem. Výsledkem je digitální signál s proměnlivou střídou, který po připojení k LED diodě lidské oko vnímá jako plynulou změnu intenzity svitu bez viditelného blikání.
## Použité součástky na desce:
  ### BTNU
  Funguje jako reset tlačítko. Vždy vrátí dýchání na začátek nádechu.
  ### LD 15
  LEDka, kterou jsme vybrali - bude simulovat dýchání
# Blokové schéma
<img width="1203" height="495" alt="261625c3-45dd-4885-a048-1a631533f656" src="https://github.com/user-attachments/assets/f63bf44e-c6f2-4871-a7a8-ab20342afc7e" />



# Moduly
## clk_en
Slouží jako metronom. Generuje krátký puls __ce__, který trvá jeden takt hlavních hodin a opakuje se v intervalu daném parametrem G_MAX (Nastaveno na 1 000 000). To umožňuje synchronně řídit pomalé procesy, jako je změna jasu LED, při zachování 100MHz frekvence systému.
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset; vynuluje čítač i vstup\
__ce__ - Výstupní puls
### Testbench
<img width="1064" height="169" alt="Screenshot 2026-04-29 125029" src="https://github.com/user-attachments/assets/631e569f-9136-43d9-82d5-a5dd4bf7293e" /> \
[Odkaz na TestBench](https://github.com/xSchwarzinger/DE1-Project/blob/main/PWC_Breathing/PWC_Breathing.srcs/sim_1/new/tb_ckl_en.vhd)


## clk_en_pwm
Modul slouží jako vysokorychlostní metronom pro PWM driver. Generuje krátký puls __ce__, který se opakuje v intervalu daném parametrem G_MAX (Nastaveno na 1 000). Na rozdíl od základního modulu clk_en je tento určen pro mnohem častější generování pulzů, což zajišťuje vysokou frekvenci PWM a tím i plynulé stmívání LED bez viditelného blikání.
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset; vynuluje čítač i vstup\
__ce__ - Výstupní puls
### Testbench
<img width="1032" height="171" alt="Screenshot 2026-04-29 125112" src="https://github.com/user-attachments/assets/04d6aeed-3fb5-406c-b340-3aae02e7d96f" /> \
[Odkaz na TestBench](https://github.com/xSchwarzinger/DE1-Project/blob/main/PWC_Breathing/PWC_Breathing.srcs/sim_1/new/tb_clk_en_pwm.vhd)




## up_down_counter
Funguje jako klasický counter s tím rozdílem, že generuje 8bitovou hodnotu (0–255), která se plynule zvyšuje a snižuje, čímž vytváří trojúhelníkový průběh signálu. 
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset; vrací čítač na 0 a nastavuje směr počítání nahoru\
__en__ - Vstup pro povolení čítání (připojuje se k výstupu ce modulu clk_en)\
__brgh__ - 8bitový výstupní vektor (0–255) reprezentující aktuální jas
### Testbench
<img width="1041" height="272" alt="image" src="https://github.com/user-attachments/assets/7c8e0ceb-cfb5-4ac3-b85c-3bc6fd2a7760" /> \
[Odkaz na TestBench](https://github.com/xSchwarzinger/DE1-Project/blob/main/PWC_Breathing/PWC_Breathing.srcs/sim_1/new/tb_up_down_counter.vhd)

## pwm_driver
Tento modul slouží jako digitálně-analogový převodník využívající __PWM__. Převádí 8bitovou hodnotu jasu na digitální signál, jehož střída odpovídá požadované intenzitě svitu LED.
### Porty:
__clk__ - Hlavní hodinový signál\
__rst__ - Synchronní reset\
__brgh__ - 8bitový vstupní vektor (0–255) reprezentující aktuální jas\
__pwm_out__ - Výstupní PWM signál připojený přímo na fyzickou LED.
### Testbench
<img width="965" height="210" alt="Screenshot 2026-04-29 131216" src="https://github.com/user-attachments/assets/9927260b-854e-4c9c-a397-9842db7967cb" /> \
[Odkaz na TestBench](https://github.com/xSchwarzinger/DE1-Project/blob/main/PWC_Breathing/PWC_Breathing.srcs/sim_1/new/tb_pwm_driver.vhd)
# Využití prostředků
<img width="496" height="109" alt="image" src="https://github.com/user-attachments/assets/42538f97-248f-4295-867e-e0f19d083358" /> \
# Video demonstrace 
<img width="600" height="456" alt="IMG_3718" src="https://github.com/user-attachments/assets/e11924f7-72a9-49f4-861e-dc317213b143" />




# Využité zdroje
* Byl použit modul clk_en, který jsme vytvářeli v laboratorních cvičeních DE1
* Ke generování některých testbenchů jsme použili webovou stránku [Lapinoo.net](https://vhdl.lapinoo.net/) , tyto testbenche jsme později upravili.




# Autoři
Jan Feik, Mathias Schwarzinger
