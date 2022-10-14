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
<img src="Images/important.png" width="32px"> Damit HA den id_rsa Key von root nutzen kann, sollte dieser in das /config Verzechnis kopiert werden.

`cp ~/.ssh/id_rsa ~/config/ssh`


### Schritt 3. Via Klick den Miner an und auschalten
Es gibt mnehrere Wege nach Rom. :-)

Ich habe mich primär für folgenden Weg entscheiden: shell_commands und dann HA skripte.

1.)
Lege in der ***configuration.yaml** am Ende folgenden Eintrag an:
```
shell_command:
    Wunschname1: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh Miner01"
    Wunschname2: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh Miner02"
    Wunschname3: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh stop"
---
Als Miner01 usw. die Bezeichnungen verwenden die im miner.sh script definiert wurden.














