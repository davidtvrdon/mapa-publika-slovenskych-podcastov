# Mapa publika slovenských podcastov

Interaktívna vizualizácia demografického zloženia publika 107 slovenských podcastov od vydavateľov Petit Press, N Press, Ringier Slovakia Media, BAUER MEDIA Slovakia, News and Media a ZAPO.

Zdroj dát: IAB Slovakia: [Monitoring počúvanosti podcastov (07/2026)](https://www.iabslovakia.sk/iab-monitor/monitoring-pocuvanost-podcastov/)

## Čo ukazuje mapa

Každý bod predstavuje jeden podcast umiestnený podľa dvoch osí:

- **Os X** – podiel žien v publiku (vľavo = prevažne muži, vpravo = prevažne ženy)
- **Os Y** – podiel poslucháčov do 35 rokov (nižšie = staršie publikum, vyššie = mladšie)
- **Veľkosť bodu** – celkový počet prehratí za júl 2026 (audio + video + vlastný hosting)
- **Farba** – automaticky nájdený typ publika (k-means klastrovanie)

## Segmenty publika

| Segment | Popis |
|--------|-------|
| Muži 35+ | Spravodajstvo, ekonomika, politika |
| Ženy 35+ | Vzťahy, zdravie, rodičovstvo |
| Mladšie ženy | Lifestyle, true crime, influenceri |
| Mladší muži | Šport, autá, technológie |
| Najmladšie publikum | Zmiešané, do 27 rokov |
| Vyrovnané, stredný vek | Mix tém, 30–44 rokov |

## Funkcie

- Filtrovanie podľa vydavateľa
- Výber cieľového segmentu
- Fulltextové vyhľadávanie podcastov
- Detail každého podcastu s vekovým a rodovým rozložením
- Porovnanie s priemerom segmentu
- Trend prehratí za posledných 12 mesiacov (august 2025 – júl 2026)

## Metodika

Klastre boli nájdené automaticky (k-means) na základe podielu žien a podielu publika do 35 rokov. Optimálny počet klastrov (6) bol zvolený podľa silhouette skóre. Pri každej aktualizácii dát sa klastrovanie spúšťa znova, ale vychádza z predchádzajúcich centroidov, aby si segmenty zachovali svoj význam v čase. Priemerný vek je odhad z midpointov vekových pásiem. Podcasty bez demografických dát (Ťažký týždeň, Veľké správy, EKG & Milan Lieskovský) neboli zahrnuté.

## Zdroj dát

Demografické dáta pochádzajú z meraní vydavateľov; počty prehratí pokrývajú audio, video aj vlastný hosting. Veľkosť bodov vychádza z prehratí za júl 2026, ktoré sa podarilo priradiť k 96 zo 107 podcastov – zvyšných 11 je vykreslených prerušovaným okrajom. Trend v detaile podcastu pokrýva posledných 12 mesiacov, teda august 2025 – júl 2026.
