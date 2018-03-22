# Plán riešenia diplomovej práce
## Motivácia

Katedra informačných sietí v súčasnosti vo viacerých predmetoch poskytuje výučbu, zameranú aj na osvojenie praktických zručností zo správy sieťových prvkov. Za týmto účelom prevádzkuje dve laboratória so sieťovými prvkami. Tieto prvky sú stále vhodné na vyučovanie, avšak ich aktualizácia je čím ďalej náročnejšia. S nástupom systémov virtuálizácie sa objavujú  jednak riešenia výrobcov sieťových prvkov, ktoré sú navrhnuté na beh vo virtualizovanom prostredí, ako aj dostupné riešenia umožňujúce ich využívanie a vlastné budovanie virtuálnych laboratórií. Cieľom práce je analyzovať vyučovanie KIS. Následne na základe analýzy vykonať prieskum dostupnosti virtuálnych sieťových prvkov a rôznych virtualizačných platforiem na ich virtualizáciu. Potom vykonať ich vyhodnotenie podľa stanovených kritérií a vypracovať systém ich nasadenia pre vybrané predmety podľa potrieb katedry.


## Zoznam úloh a ich riešení

### Prieskum dostupných virtualizačných nástrojov + súčasný stav na katedre
- Dôvody, prečo použiť virt. laby
  - ieee explore, sci/scio hub - na stiahnutie clankov z ieee exp
- Dynamips
- WEB-IOU
- Cisco VIRL
- UNetLab
- EVE-ng + rozdiely rôznych verzií (špeciálne pre EVE-ng) - PRIMÁRNE!
- GNS3 - podporný nástroj

### Analýza dostupných virtualizačných nástrojov
- použité ǘývojové technológie (prog jazyk, backend, frontend)
- podpora zariadení, s ktorými sa na danom predmete pracuje
- podpora technológií jednotlivých zariadení
- typ používateľského rozhrania
- prideľovanie portových čísel zariadeniam
- vzdialený prístup ku zariadeniam (telnet, vnc, rdp)
- správa topológií
  - vytvorenie/úprava/uloženie/odstránenie topológie
  - koľko topológií môže mať jeden používateľ spustených
- možnosť práce viac ľudí naraz na rovnakom projekte
- možnosť prepojiť topológiu so živou sieťou

### Porovnanie GNS3 a EVE-ng

### Získavanie zariadení
- zoznam získaných zariadení
  - Dynamips
  - Cisco IOL/IOU
  - QEMU

### Nasadenie EVE-ng servera
  - kde všade bol nasadený
    - vmware
    - fyzický server
  - hardvér

#### Inštalácia
  - Postup
    - Inštalácia Ubuntu Server 16.03
    - Konfigurácia Ubuntu Server
    - Inštalácia EVE-ng do Ubuntu Server
    - Konfigurácia EVE-ng
      - Obnovenie súborov a adresárov
        - Skripty
        - Zariadenia
        - Databázy
      - Automatizácia zálohovania nástrojom "cron"
      - Cisco IOL/IOU licencia
      - Zabezpečenie servera
  - úprava šablón

#### Zabezpečenie
  - Systém
  - SSH
  - Web server
  - Databázový server
  - SSH tunely (pre vzdialený prístup k zariadeniam v topológii)

#### Spravovanie

##### Adresárova štruktúra EVE-ng
-adresárový strom

##### Monitorovanie
- netdata

##### Zálohovanie

### Meranie systémových požiadaviek zariadení

#### Metodika

#### Zoznam meraných zariadení

#### Výsledky

### Výber predmetov, v ktorých je vhodné použiť virtuálne laboratórium

- UROBIT DO TABULKY NIZSIE UVEDENE INFO

- Počítačové siete 1
  - Zariadenia:
    - smerovače: Cisco, Juniper

- Počítačové siete 2
  - Zariadenia:
    - smerovače: Cisco, Juniper

- Projektovanie sietí 1 - PRIMÁRNE!
  - Zariadenia:
    - smerovače: Cisco, Juniper
    - koncové zariadenia: (Linux / Windows) (pre multicast technológie)

- Projektovanie sietí 2 - PRIMÁRNE!
  - Zariadenia:
    - smerovače: Cisco, Juniper, Nokia

- CCNA Security
  - Zariadenia:
    - prepínače: Cisco
    - smerovače: Cisco
    - firewall: Cisco
                
- CCNP Routing & Switching - PRIMÁRNE!
  - Zariadenia
    - prepínače: Cisco
    - smerovače: Cisco

### Analýza technológií, ktoré sa vyučujú vo vybraných predmetoch

- Počítačové siete 1 (CCNA 1, CCNA 2)
  - TODO - konkrétne technológie, vyučované na predmete

- Počítačové siete 2 (CCNA 3, CCNA 4)
  - aktualny stav: zakladny routing (7200) a switching l2 aj l3 (nevieme zatial)
  - TODO - konkrétne technológie, vyučované na predmete

- Projektovanie sietí 1 - PRIMÁRNE!
  - TODO - konkrétne technológie, vyučované na predmete

- Projektovanie sietí 2 - PRIMÁRNE!
  - TODO - konkrétne technológie, vyučované na predmete

-CCNA Security
  - TODO - konkrétne technológie, vyučované na predmete

- CCNP Routing & Switching - PRIMÁRNE!
  - routing
  - TODO - konkrétne technológie, vyučované na predmete

### Výber vhodných zariadení, ktoré podporujú potrebné technológie
- technológia_1:
  - zoznam zariadení, ktoré ju podporujú
- technológia_2:
  - zoznam zariadení, ktoré ju podporujú
- ...

### Testovanie virtuálneho laboratória
- meranie systémových požiadaviek vybraných topológií
- vyhodnotenie kompatibility, výkonnosti, stability, početnosti zariadení atď.
- overenie funkčnosti pri vypracovávaní úloh z vybraných predmetov

#### Počítačové siete 1/2 (CCNA)
- náhrada/doplnok pre nástroj Packet Tracer
- sumárne laboratórne cvičenie “Packet Tracer Packet Tracer Skills Integration Challenge 8.6.1”

#### Projektovanie sietí 1
- náhrada/doplnok Dynamips servera (s takym vykonom, t.j. cca 10/15skupin po 10 routroch)

#### Projektovanie sietí 2
- VPLS
- Seamless MPLS
- MVPN-NG ?
- eVPN ?

### Vyhodnotenie a dokumentácia získaných výsledkov.
- Všetky dokumenty a výsledky práce sú prístupné na stránke https://github.com/kyberdrb/Ing-Projekt_Ing-Virtualne_sietove_laboratoria

### Čo ďalej
  - skonštatovanie, čo som urobil a ako to posunulo vyučovanie na katedre dopredu
  - buducnost projektu + dalsie ulohy
  
(vytvorené s https://dillinger.io/)