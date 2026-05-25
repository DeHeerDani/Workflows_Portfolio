# Lees de data in in R met het readxl package.

library(readxl)

data <- read_excel("~/Workflows/Workflows_Portfolio/Opdracht_4_Reproducible_Science/CE.LIQ.FLOW.062_Tidydata.xlsx")
View(data)


# Inspecteer de data. Is de data goed ingelezen? Kloppen de data types voor rawData, compName en compConcentration?

## RawData hoort numeriek te zijn
## compName hoort tekst/factor te zijn
## compConcentration hoort numeriek of factor te zijn afhankelijk van de analyse

class(data$RawData)
class(data$compName)
class(data$compConcentration)

unique(data$compConcentration)

# er zit nog een komma in een van de datapunten.

data$compConcentration <- gsub(",", ".", data$compConcentration)

# komma veranderen voor .

data$compConcentration <- as.numeric(data$compConcentration)

# numeriek van maken


# Maak een scatter plot voor de verschillende chemicaliën en concentraties:
  
## Geef de compConcentration weer op de x-as. Zorg ervoor dat de labels op de x-as leesbaar zijn!
## Geef de RawData weer op de y-as.
## Visualiseer de verschillende chemicaliën met verschillende kleuren.
## Gebruik verschillende symbolen (shape =) voor de expType variabele.
## Controleer of de volgorde op de x-as klopt. Pas zonodig het data type van compConcentration aan.
## Gebruik een log10-transformatie om de x-variabele beter weer te geven.
## Voeg jitter aan de punten toe om te voorkomen dat punten overlappen.

library(ggplot2)

ggplot(data, aes(
  x = compConcentration,
  y = RawData,
  color = compName,
  shape = expType
)) +
  geom_jitter(width = 0.05, height = 0) +
  scale_x_log10() +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    title = "Scatter plot van chemicaliën en concentraties",
    x = "Concentratie",
    y = "RawData"
  )

# Voor de log10-transformatie zijn meetwaarden met concentratie 0 verwijderd uit de plot, omdat een logaritmische transformatie van 0 niet mogelijk is.




# Normaliseer de data voor de negatieve controle (controlNegative). 
# Zorg ervoor dat de gemiddelde waarde voor de negatieve controle gelijk is aan 1 en dat alle andere meetwaarden zijn uitgedrukt als een fractie daarvan. 
# Maak een nieuwe scatter plot met de genormaliseerde waarden.


# gemiddelde negatieve controle
neg_mean <- mean(
  data$RawData[data$expType == "controlNegative"],
  na.rm = TRUE
)

# nieuwe tabel maken met genormliseerde data
data$NormalizedData <- data$RawData / neg_mean



plot_data <- subset(data, compConcentration > 0)

ggplot(plot_data, aes(
  x = compConcentration,
  y = NormalizedData,
  color = compName,
  shape = expType
)) +
  geom_jitter(width = 0.05, height = 0) +
  scale_x_log10() +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    title = "Genormaliseerde scatter plot",
    x = "Concentratie",
    y = "Genormaliseerde RawData"
  )


# De data werd genormaliseerd door alle meetwaarden te delen door het gemiddelde van de negatieve controle (controlNegative). 
# Hierdoor werd de gemiddelde waarde van de negatieve controle gelijk aan 1 en konden andere meetwaarden als relatieve fractie van de controle worden weergegeven. 
# Dit maakt vergelijking tussen experimentele condities eenvoudiger.





## Uitleg van de analyse
# De negatieve controle (controlNegative) is de situatie zonder werkzame stof. Dit laat zien wat de normale waarde is van het aantal nakomelingen.
# De positieve controle is een behandeling waarvan al bekend is dat die effect heeft. 
# Hiermee check je of het experiment goed werkt.
# De vehicle controle is alleen het oplosmiddel zonder stof, om te kijken of dat zelf invloed heeft op de resultaten.
# Deze controles zijn belangrijk om te kunnen zien of verschillen echt door de chemicaliën komen en niet door andere factoren.
# De data is genormaliseerd door alles te delen door het gemiddelde van de negatieve controle. Daardoor wordt de negatieve controle gelijk aan 1. Andere waarden zijn dan relatief ten opzichte hiervan. Dit maakt het makkelijker om de effecten van verschillende stoffen met elkaar te vergelijken.

## vervolgonderzoek.
# 1. Laad het benodigde package: library(drc),
# 2. Gebruik de dataset zonder nul-concentraties en met genormaliseerde waarden.
# 3. Maak een log-logistisch model.
# 4. Bekijk de resultaten.
# 5. Bepaal de IC50 waarde.
# 6. Maak een plot van de dose-response curve.






