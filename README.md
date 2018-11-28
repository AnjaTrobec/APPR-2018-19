# Analiza podatkov s programom R, 2018/19

# Anja Trobec

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/AnjaTrobec/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/AnjaTrobec/APPR-2018-19/master?urlpath=rstudio) RStudio

## Tematika
# Poroke in razveze v Sloveniji
V svojem projektu bom analizirala podatke o porokah in razvezah v Sloveniji. Osredotočila se bom na obdobje med letom 2011 do leta 2017. Analizirala bom:
* povprečno starost ženina in neveste pri vstopu v prvo zakonsko zvezo,
* število sklenjenih zakonskih zvez med Slovenci letno (pri tej spremenljivki bom zajela daljše časovno obdobje, da bo vidna razlika med številom porok danes in do 30 let nazaj),
* število porok po regijah – prebivalci katerih regij so bolj nagnjeni k poroki, kje po Sloveniji se poročajo bolj mladi, itd.
* koliko zakonskih zvez je sklenjeno letno med istospolnimi partnerji,
* število razvez po regijah,
* koliko je zakonskih razvez z otroki in koliko brez,
* število zakonskih razvez v posameznem letu,
* povprečno trajanje zakonske zveze do ločitve,
* koliko je ovdovelih ljudi v Sloveniji (kakšne so razlike v številu med spoloma – občutno več vdov).

Cilj je pokazati, da se ljudje vedno manj poročajo, se poročajo vedno starejši in vedno več se ločujejo. Podatke bom poiskala na Statističnem uradu Republike Slovenije.
* https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=05E2006S&ti=&path=../Database/Dem_soc/05_prebivalstvo/15_sestava_preb/10_05E20_zakonski_stan/&lang=2
* https://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=05M5001S&ti=&path=../Database/Dem_soc/05_prebivalstvo/35_05M50_istospolne_skupnosti/&lang=2
 

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
