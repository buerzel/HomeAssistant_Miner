# Beispiel für ein mögliches Zusammenspiel HA und Mining

In der folgenden Grafik soll kurz schematisch das Zusammenspiel zwischen HA und einem Pi erklärt werden an dem ein Miner (z.B. Apollo oder Compac) hängt.

<img src="Images/ueberblick.png">

---
 Um diesen Aufbau zu realisieren müssen folgende Schritte vorab erledigt werden.
 * [SSH Zugriff ohne Passwort auf den Pi ](https://github.com/buerzel/HomeAssistant_Miner/blob/main/ssh_connect.md)
 * [In Ha einen custom Switch anlegen](https://github.com/buerzel/HomeAssistant_Miner/blob/main/customSwitchCustomCommand.md)
 * [Ein Script zum steuern des/der Miner erstellen](https://github.com/buerzel/HomeAssistant_Miner/blob/main/scriptApolloCgminer.md)

Die jeweiligen Anleitungen sind verlinkt. ;-)

## Anleitungen erledigt und nun?

### Schritt. 1
- Das [miner.sh](https://github.com/buerzel/HomeAssistant_Miner/blob/main/miner.sh) Script auf den Miner Pi legen (***z.B.: /home/user/miner.sh***) und konfigurieren.
- ggf. das script Ausführbar machen `chmod +x miner.sh`
- Testen ob das script lokal funktioniert.

### Schritt 2.
- In HA das Kommando für den schalter anpassen um auf dem Pi das script miner.sh ausführen zu können.

Nur ein Beispiel
```
switch:
  - platform: command_line
    switches:
      apollominer01:
        unique_id: apollominerId01
        command_on: "ssh UserB@SystemB:/home/user/miner.sh Miner01"
        command_off: "ssh UserB@SystemB:/home/user/miner.sh Miner02"
```

Nun sollte jedesmal wenn der Schalter betätigt wird erst der aktuelle Prozess beendet werden und dann ein neuer gestartet werden.

Dies ist nur ein erstes Beispiel. 

Eine Idee wäre einfach für jeden Miner einen eigenen Schalter zu bauen und der Off Status sorgt nur dafür das der jeweilige Prozess beendet wird.
