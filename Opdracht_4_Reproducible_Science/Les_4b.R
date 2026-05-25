##### 4B

## website link
# https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0242073
## github link
# https://github.com/nyiuab/NBZIMM/blob/master/tutorial/nbmms.md


## onderzoeksvraag
# Hoe kunnen we microbiome veranderingen over tijd goed modelleren met een statistisch model dat rekening houdt met veel nullen en herhaalde metingen?

## korte samenvatting methode en resultaten.
# Dit artikel onderzoekt hoe je longitudinale microbiome data het beste kunt analyseren. 
# De onderzoeksvraag is hoe je zero-inflated en tijdsafhankelijke microbiome data statistisch goed kunt modelleren. 
# Hiervoor ontwikkelen de auteurs een zero-inflated Gaussian mixed model (ZIGMM) met een EM-algoritme. 
# Uit simulaties en echte datasets blijkt dat dit model beter presteert dan bestaande methoden zoals LMM en NBMM. 
# De conclusie is dat ZIGMM efficiënter en robuuster is voor complexe microbiome data met veel nullen en herhaalde metingen.

###-

# Voor deze opdracht heb ik het artikel van PLOS ONE gebruikt over het NBZIMM model voor microbiome data. 
# In het artikel wordt duidelijk uitgelegd wat het doel van het onderzoek is. 
# De onderzoekers wilden een statistisch model ontwikkelen voor het analyseren van longitudinale microbiome data, waarbij rekening wordt gehouden met dingen zoals verschillen tussen metingen over tijd en variatie in sequencing data.
# Het artikel bevat ook een data availability statement waarin wordt uitgelegd waar de data en code beschikbaar zijn. De R code en datasets zijn gedeeld via GitHub, waardoor andere onderzoekers de analyses kunnen proberen te reproduceren. De gebruikte code en data waren beschikbaar via de GitHub repository van NBZIMM. 
# Ook werd in het artikel beschreven waar de gebruikte data vandaan kwamen en dat het ging om microbiome studies met menselijke proefpersonen.
# Verder bevat het artikel professionele contactinformatie van de auteurs en affiliaties van universiteiten en onderzoeksinstellingen. Ook waren er secties aanwezig voor ethiek en funding. 
# Hierin werd aangegeven dat er rekening is gehouden met ethische aspecten van het onderzoek en dat het onderzoek financiële ondersteuning heeft gekregen.
# De code beschikbaarheid van het artikel was goed, omdat zowel de R package als voorbeeldcode openbaar beschikbaar waren. 
# Tijdens het reproduceren van de analyse liep ik wel tegen een probleem aan omdat de NBZIMM package niet meer direct via CRAN geïnstalleerd kon worden met mijn huidige versie van R. 
# Dit kon worden opgelost door de package via GitHub te installeren. 
# Daarna werkte de code succesvol en kon ik een deel van de analyse reproduceren. 
# Hierdoor beoordeel ik de reproduceerbaarheid van het artikel als goed, al waren er wel kleine technische problemen tijdens het installeren van de package.


###- 

# werkt niet
install.packages("NBZIMM")

install.packages("remotes")
library(remotes)

remotes::install_github("nyiuab/NBZIMM")
library(NBZIMM)

data(Romero)

otu = Romero$OTU
sam = Romero$SampleData

N = sam[, "Total.Read.Counts"]

Days = sam$GA_Days
Days = scale(Days)

Age = sam$Age
Age = scale(Age)

Race = sam$Race
preg = sam$pregnant
subject = sam[, "Subect_ID"]

y = otu[,1]

f1 = glmm.nb(
  y ~ Days + Age + Race + preg + offset(log(N)),
  random = ~ 1 | subject
)

summary(f1)

# The shared R code successfully reproduced the negative binomial mixed model analysis described in the article. 
# The model evaluated associations between microbial abundance and variables such as gestational age, age, race, and pregnancy status while accounting for repeated measurements within subjects. 
# The analysis completed successfully without major modifications after installing the NBZIMM package from GitHub.


# De R code van het artikel gebruikt de NBZIMM package om microbiome data te analyseren met een negative binomial mixed model. 
# In de code worden eerst de datasets geladen en daarna worden verschillende variabelen geselecteerd, zoals leeftijd, zwangerschap status en het aantal sequencing reads. 
# Vervolgens wordt met de functie glmm.nb() een statistisch model gemaakt om te onderzoeken of deze variabelen verband hebben met veranderingen in microbiome abundantie over tijd. 
# De code is redelijk overzichtelijk opgebouwd en de introduction bij de GitHub repository legt duidelijk uit wat het doel van de analyse is. Er staan niet veel comments in de code zelf, maar de structuur van de code is wel logisch en daardoor nog redelijk goed te volgen. 
# Daarom geef ik de leesbaarheid van de code een 4 van de 5.
# Voor het reproduceren van de analyse heb ik de R code en data gedownload en een nieuw R project aangemaakt. 
# Tijdens het uitvoeren van de code liep ik eerst tegen een probleem aan omdat de NBZIMM package niet meer beschikbaar was via CRAN voor mijn huidige versie van R. Hierdoor werkte install.packages("NBZIMM") niet. 
# Dit probleem heb ik opgelost door de package rechtstreeks vanaf GitHub te installeren met remotes::install_github(). Daarna kon de code succesvol worden uitgevoerd. 
# Ik heb vervolgens een deel van de analyse gereproduceerd door het negatieve binomial mixed model uit te voeren en de output van het model te verkrijgen. 
# De analyse werkte daarna zonder grote problemen. Daarom beoordeel ik de reproduceerbaarheid van de R code met een 4 van de 5. De code en data waren goed beschikbaar, maar er was wel technische kennis nodig om installatieproblemen op te lossen.





