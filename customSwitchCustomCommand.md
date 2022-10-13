# Home Assistant: Manuellen Switch anlegen und beliebige Kommandos hinterlegen.

Es gibt in HA die Möglichkeit in der **configuration.yaml** u.a. eigene Switches (Schalter) zu erstellen.

Für dieses Beispiel erstelle ich einen virtuellen Switch (Also kein echtes Gerät!) der bei Betätigung einen Befehl oder ein script ausführen kann.

# Vorbereitung

Damit man die configuration.yaml gut in HA bearbeiten kann, macht es Sinn vorab das Addon FileEditor zu installieren.

---
<img src="/Images/fileEditor.png" width="50%" >

---

Wenn man nun die Benutzerfläche des Editors startet kann man oben links auf dem Ordner Symbol die Datei ***configuration.yaml*** suchen und auswählen.

# Edit Configuration.yaml

Hier mal ein Beispiel wie so ein Eintrag für einen switch aussehen könnte:

```
switch:
  - platform: command_line
    switches:
      apollominer:
        unique_id: apollominerId01
        command_on: "touch /config/mineran.txt"
        command_off: "touch /config/mineraus.txt"
```

