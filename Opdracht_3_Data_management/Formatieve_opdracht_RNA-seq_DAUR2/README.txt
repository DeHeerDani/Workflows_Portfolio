README – Metagenomics project

1. Doel van dit project

In dit project laat ik zien hoe een metagenomics analyse gestructureerd kan worden volgens de Guerrilla Analytics regels.

De data bestaat uit DNA sequencing reads van een mock microbiële gemeenschap. Het doel is om te laten zien hoe je van ruwe data naar resultaten komt via een vaste workflow.

---

2. Mapstructuur

Het project is opgedeeld in verschillende mappen:

- data_raw: originele bestanden (FASTQ en metadata)
- data_processed: bestanden die door de analyse zijn gegenereerd (Kraken2, Bracken, BIOM)
- results: figuren en eindresultaten
- scripts: alle scripts die de analyse uitvoeren
- docs: uitleg en notities
- logs: uitvoerlogs van programma’s

Deze structuur zorgt ervoor dat alles overzichtelijk blijft en dat de analyse opnieuw uitgevoerd kan worden.

---

3. Input data

De originele data bestaat uit:

- HU2_MOCK2_L001_R1_001.fastq.gz
- HU2_MOCK2_L001_R2_001.fastq.gz
- HU_waternet_MOCK2_composition.csv

De FASTQ bestanden bevatten de DNA reads.  
Het CSV bestand bevat de verwachte samenstelling van de mock sample.

---

4. Workflow

De analyse bestaat uit de volgende stapen:

1. Quality control met FastQC
2. Taxonomische classificatie met Kraken2
3. Abundance schatting met Bracken
4. Omzetten naar BIOM formaat
5. Analyse en visualisatie in R

---

5. Resultaten

De resultaten worden opgeslagen als figuren en tabellen in de map results.  
Hierin staan onder andere vergelijkingen tussen de geschatte abundantie en de verwachte samenstelling.

---

6. Opmerking

Dit is een oefenproject waarbij de nadruk ligt op de structuur en niet op de volledige analyse zelf.

De mappen zijn ingericht volgens de Guerrilla Analytics regela.