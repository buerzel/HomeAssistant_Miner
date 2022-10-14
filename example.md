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
Damit HA den id_rsa Key von root nutzen kann, sollte dieser in das /config Verzechnis kopiert werden.

`cp ~/.ssh/id_rsa ~/config/ssh`


### Schritt 3.
- In HA das Kommando für den Schalter (Switch) anpassen um auf dem Pi das script miner.sh ausführen zu können.

Nur ein Beispiel
```
switch:
  - platform: command_line
    switches:
      apollo_miner:
        friendly_name: ApolloMiner
        unique_id: apollo_miner
        command_on: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB touch /tmp/An"
        command_off: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB touch /tmp/Aus"

```


Dies ist nur ein erstes Beispiel. 

