# HomeAssistant for BTC Miner

Ziel dieses Projektes ist es Steuerungsbefehle aus der HA Oberfläche über z.B. Schaltflächen an eine Miner Software (Aktuell apollo und cgminer) zu senden um den Miner zu steuern. Geplant ist es bald auch eine Anbindung an S9/19 zu realisieren.

Dazu wird aktuell im Hintergrund eine SSH Verbindung aufgebaut die ein Script [miner.sh](https://github.com/buerzel/HomeAssistant_Miner/blob/main/miner.sh) auf dem entfernten System (z.B. Pi) mit Attributen aufruft. In diesem Script werden Miner Strings, Zugangsdaten etc konfiguriert. Der Aufruf des Script ist dann mit Paramtern möglich.

Dies ermöglicht es entweder via Knopfdrück im HA oder in Abhängigkeit von anderen Dingen (Solaranlage, Uhrzeit, Stromverbauch, Wetter, Lust und Laune) Miner entsprechend zu schalten.

Es sollen hier nach und nach für unterschiedliche Miner Lösungen angeboten werden.
Durch diese Möglichkeit entstehen vielfälltigste Verwendungsmöglichkeiten.
z.B.:
- Eine Solaranlage liefert weniger Strom als Wert X -> nutze daher eine andere Taktfrequenz beim Miner
- Es scheint keine Sonne -> schalte den Miner aus
- Es scheint viel Sonne -> schalte einen weiteren Miner dazu
- Bestimmte Miner an bestimmten Tagen oder zu bestimmten Zeiten an bzw. aus zuschalten
- Miner ausschalten wenn ein Rauchmelder Alarm meldet
- Miner anschalten wenn die Waschmaschine fertig ist um den Trockenraum zu heizen
- ...
- etc.

---

Aktuell sammel ich für jeden Teilbereich eine *.md Datei (Markdown) in der einzelne Arbeitsschritte erklärt werden.
Daher kann es aktuell noch etwas unordentlich sein. ;-)

Diese werden dann aber nach und nach zusammen geführt.

---
## Beispiel
- [Beispiel für ein Zusammenspiel](https://github.com/buerzel/HomeAssistant_Miner/blob/main/example.md)


## Anleitungen:

- [SSH Connect ohne Anmeldung einrichten](https://github.com/buerzel/HomeAssistant_Miner/blob/main/ssh_connect.md)
- [SSH in HA einrichten](https://github.com/buerzel/HomeAssistant_Miner/blob/main/sshHomeAssistant.md)
- [Apollo / Cgminer Software via Script steuern](https://github.com/buerzel/HomeAssistant_Miner/blob/main/scriptApolloCgminer.md)
- [Sammlung von Abfragen für Sensoren und Kommandos](https://github.com/buerzel/HomeAssistant_Miner/blob/main/queriesAndCommands.md)


---


## V4V
Falls Ihr mir ein paar Sats rüberschupsen möchtet, habe ich nichts dagegen.. :-)

Ist aber keine Bedingung.

<img src="Images/donation.jpg" width="30%">


---

All icons on this github md files are from: https://iconarchive.com
