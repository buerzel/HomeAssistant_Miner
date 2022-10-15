# Beispiel für ein mögliches Zusammenspiel HA und Mining

In der folgenden Grafik soll kurz schematisch das Zusammenspiel zwischen HA und einem Pi erklärt werden an dem ein Miner (z.B. Apollo oder Compac) hängt.

<img src="Images/ueberblick.png">

---
 Um diesen Aufbau zu realisieren müssen folgende Schritte vorab erledigt werden.
 * [SSH Zugriff ohne Passwort auf den Pi ](https://github.com/buerzel/HomeAssistant_Miner/blob/main/ssh_connect.md)
 * [Das Script zum steuern des/der Miner herunterladen und konfigurieren](https://github.com/buerzel/HomeAssistant_Miner/blob/main/scriptApolloCgminer.md)

Die jeweiligen Anleitungen sind verlinkt. ;-)

## Anleitungen erledigt und nun?

### Schritt. 1
- Das [miner.sh](https://github.com/buerzel/HomeAssistant_Miner/blob/main/miner.sh) Script auf den Miner Pi legen (***z.B.: /home/user/miner.sh***) und konfigurieren.
- Anleitung [hier](https://github.com/buerzel/HomeAssistant_Miner/blob/main/scriptApolloCgminer.md)
- ggf. das script Ausführbar machen `chmod +x miner.sh`
- Testen ob das script lokal funktioniert.

### Schritt 2.
<img src="Images/important.png" width="32px"> Damit HA den id_rsa Key von root nutzen kann, sollte dieser in das /config Verzechnis kopiert werden.

`cp ~/.ssh/id_rsa ~/config/ssh`


### Schritt 3. Via Klick den Miner an und auschalten
Es gibt mnehrere Wege nach Rom. :-)

Ich habe mich primär für folgenden Weg entscheiden: shell_commands und dann HA skripte.

#### 1.)
Lege in der ***configuration.yaml*** am Ende folgenden Eintrag an:
```
shell_command:
    wunschname1: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh Miner01"
    wunschname2: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh Miner02"
    wunschname3: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh stop"
```
Als Miner01 usw. die Bezeichnungen verwenden die im miner.sh script definiert wurden.

Danch HA Konfig prüfen und neustarten. [WICHTIG beachten](https://github.com/buerzel/HomeAssistant_Miner/blob/main/example.md#-wichtig)

#### 2.)

Jetzt in der HA Oberfläche die Punkte ***Einstellungen -> Automatisierungen & Szenen -> Skripte*** auswählen.

#### 3.)
Hier ein neues Skript anlegen.

Die Punkte Name, Symbol, ID mit einem guten Namen bezeichnen.

Der Modus wird auf ***Einzeln*** gestellt.

Im Abschnitt Sequenz wird der vorhandene Punkt (Device Action) gelöscht. Dazu auf die drei Punkte rechts von device action und löschen.

Dann fügst Du eine neue Aktion ein (***+ Aktion hinzufügen***).

Dazu wählst ***Dienst ausführen***.

In dem Textfeld gibst Du nun den Namen an den Du unter Punkt *1.)* definiert hast. z.B. Wunschname1. Durch das autocomplete feld wird dir direkt das passende shell_command angezeigt. Dieses kannst Du nun auswählen und das Skript speichern.

#### 4.)

Nun gehst Du auf das Dashboard (Lovelace) und kannst DOrt eine neue Karte hinzufügen. Dort kannst Du nun Deine unter Punkt *3.* angelegte Entität eintragen. Es ist der Name des angelegten Skriptes in der HA Oberfläche.


---

Nun kannst Du via Klick über die HA Oberfläche direkt das Kommando an den Pi senden um den Miner auszuschalten oder einen anderen Miner oder eine andere Kombination zu nutzen.

Viel Spass beim ausprobieren.


--- 

# <img src="/Images/info.png" width="32"> WICHTIG! 

Nachdem eine Änderung in der configuration.yaml getätigt wurde muss oben rechts aus speichern geklickt werden. Dabei muss ein kleines grünes Häckchen auftauchen sonst ist die Syntax falsch.

Nun muss HA neu gestartet werden.

Dazu klickst du auf den Hauptmenüpunkt ***Entwicklerwerkzeuge*** (Hammersymbol) links in der Leiste.

Nun musst Du erst links auf den Punkt ***Konfiguration prüfen*** klicken und wenn alles ok ist kannst Du neustarten anklicken.

<img src="/Images/neustart.png">




