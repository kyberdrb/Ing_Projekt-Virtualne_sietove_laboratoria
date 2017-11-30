# Ing-Projekt_Ing-Virtualne_sietove_laboratoria
Inžiniersky projekt - Virtuálne sieťové laboratórium

# TODO - Projekt
*- zdieľať Bombalove GNS3 návody * 
- (Chalani) Urobiť VMware virtuálku pre GNS3 VM na učiteľskom PC a 
otestovať kompatibilitu zariadení + dokumentácia (inštalácia virtuálky, import 
zariadení na GNS3 VM server, zoznam dostupných funkčných zariadení)
- (Chalani) Urobiť VirtualBox virtuálku pre GNS3 VM a otestovať 
kompatibilitu zariadení + dokumentácia (inštalácia virtuálky, import 
zariadení na GNS3 VM server, zoznam dostupných funkčných zariadení)
- (Chalani) Upravovať návody ku GNS3 podľa potreby a overovať ich 
správnosť
- Až po otestovaní VMwareu a VirtualBoxu sa pustiť do inštalácie GNS3 VM 
do LXC kontajnera (podľa návodu v GNS3 dokumentáciách; gns3 inštalovať z 
oficiálneho repozitára) - testovať to isté, čo vo VMwarei a VirtualBoxe
- (Nízka priorita) nahradiť na serveri VMware Player (vrátane všetkých 
virtuálok: EVE-ng a pod.) virtuálku z VMware Workstation Player na VMware 
Workstation Pro, kvôli možnosťi Pro verzie mať spustené viacero 
virtuáliek súčasne


# TODO - Diplomová práca
- *urobiť kostru (obsah) v latexu (vytvoriť šablónu)*
- *kritériá testovania (kompatibilita zariadení, maximálny počet 
zariadení každého typu, stabilita backendu a frontendu, odlišnosti 
oproti ostatným nástrojom) -> v každom nástroji otestovať dve zariadenia 
a zmerať vyťaženie CPU a RAM*
- preskúmať možnosti EVE-ng (ideálne, aby bežala na fyzickom serveri)
    - nainštalovať na fyzický server
- preskúmať možnosti GNS3 (ideálne, aby bežala v LXC kontajneri)
    - vzdialený server:
      - -> VMware (učiteľský PC)
        - nasadiť
        - prepojiť vzdialenú GNS3 VM s GNS3 klientom
        - pridať zariadenia
        - otestovať zariadenia
      - VBox (nedostane IPčku)
      - LXC kontainer
- preskúmať možnosti Dynamips?
- preskúmať možnosti Cisco VIRL?
- urobiť laboratórne cvičenia vo všetkých virtuálnych sieťových 
nástrojoch z predmetov PS1, PS2, PrS1, PrS2, OKS
