# HomeAssistant for BTC Miner

Ziel dieses Projektes ist es Steuerungsbefehle aus der HA Oberfläche über z.B. Schaltflächen an einen Miner bzw. Pi zu senden um den Miner zu steuern.
Dazu wird im Hintergrund eine SSH Verbindung aufgebaut die ein Script (miner.sh) mit Attributen aufruft. In diesem Script werden Miner Strings, Zugangsdaten etc konfiguriert.

Dies ermöglicht es entweder via Knopfdrück im HA oder in Abhängigkeit von anderen Dingen (Solaranlage) Miner entsprechend zu schalten.

Es sollen hier nach und nach für unterschiedliche Miner Lösungen angeboten werden.
Durch diese Möglichkeit entstehen vielfälltigste Aufbaumöglichkeiten.
z.B.:
- Solaranlage liefert weniger Strom als Wert X, nutze daher eine andere Taktfrequenz beim Miner
- Keine Sonne, schalte den Miner aus
- Sehr viel Sonne, schalte einen weiteren Miner dazu
- Bestimmte Miner an bestimmten Tagen oder zu bestimmten Zeiten zu steuern.
- Miner ausschalten wenn ein Rauchmelder Alarm meldet
- etc.

---

Aktuell sammel ich für jeden Teilbereich eine *.md Datei (Markdown) in der einzelne Arbeitsschritte erklärt werden.

Diese werden dann nach und nach zusammen geführt.

---
## Beispiel
- [Beispiel für ein Zusammenspiel](https://github.com/buerzel/HomeAssistant_Miner/blob/main/example.md)


## Anleitungen:

- [SSH Connect ohne Anmeldung einrichten](https://github.com/buerzel/HomeAssistant_Miner/blob/main/ssh_connect.md)
- [SSH in HA einrichten](https://github.com/buerzel/HomeAssistant_Miner/blob/main/sshHomeAssistant.md)
- [Apollo / Cgminer Software via Script steuern](https://github.com/buerzel/HomeAssistant_Miner/blob/main/scriptApolloCgminer.md)



---


## V4V
Falls Ihr mir ein paar Sats rüberschupsen möchtet, habe ich nichts dagegen.. :-)
Ist aber keine Bedingung und ich erwarte es auch nicht.

<img src="Images/donation.jpg" width="30%">
