# Installation von HA in einem Docker Container auf einer Raspiblitz Node

***Disclaimer:***
Dies ist ein sehr experimentelles Projekt und ich übernehme keinerlei Verantwortung. :-)
Bitte seid euch im klaren darüber das es ggf. bei falscher Konfiguration auswirkungen auf ggf. geöffnete Lightning Kanäle haben kann.
Daher gut lesen und regelmäßiges Backup beherzigen. ;-)

## Schritt 1. root Zugriff und Docker Installation 

Um Docker zu installieren macht Ihr bitte zuerst ein Update des Betriebssystems auf eurem Raspiblitz.

```
apt-get update

apt-get upgrade
```

Dazu verbindet Ihr euch via SSH auf den Raspiblitz und werdet root.
Wenn Ihr euch als **admin** via SSH am Raspiblitz anmeldet, kommt ihr direkt auf den Auswahldialog (siehe Abbildung) den Ihr über EXIT schließt.

<img src="Images/schritt1_1.png" width="30%">

Jetzt seid Ihr auf der Kommandozeile und könnt mit `sudo -s` zu root werden.

### root Zugriff
Wer sich gerne direkt via root auf dem Raspiblitz anmelden möchte kann folgendes tun:

Auf dem Raspiblitz die Datei `/etc/ssh/sshd_config` um folgenden Eintrag erweitern.

```
PermitRootLogin yes
```

Danach den **ssh** Dienst neu starten: `/etc/init.d/ssh restart`.

Nun ist eine Anmeldung mit **root** via SSH möglich.

### Installation

Nachdem Du als root auf dem System arbeiten kannst und das System auf dem neues Stand hast kannst du Docker installieren.

Dazu folgendes im Terminal als root aufrufen:
```
apt install docker-compose
```

Wenn dieser Vorgang abgeschlossen ist könnt Ihr prüfen ob docker auch schon gestartet wurde.
Dazu `systemctl status docker.service` aufrufen und es müsste ein active oder running zu sehen sein.
Diesen Bildschirm kannst Du mit der Tastenkombination `strg+c` wieder verlassen um zur Konsole zurück zu kehren.

#### Stop und Start
Docker kann mittles der folegnden Befehle gestoppt und gestartet werden.

| Befehl | Aktion |
| --- | --- |
|`systemctl start docker.service`| Docker starten |
|`systemctl stop docker.service` | Docker stoppen |
|`systemctl start docker.service` | Docker prüfen (verlassen mit `str+c`) |


## Schritt 2. Docker läuft - und nun?

Um die Konfiguration von Docker zu vereinfachen gibt es grafisches Userinterface was wir als erstes Docker Anwendung installieren.
Dieser Container heißt **portainer** und wird wie folgt installiert:

Zuerst wird ein sogenantes Volume angelegt in dem der Docker Container seine Daten speichern kann. Für portainer müssen wir daher folgendes im Terminal eintragen:
```sh
docker volume create portainer_data
```
Nachdem dieses Volume angelegt wurde installieren wir mit folgendem Aufruf portainer.

```sh
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```

Nun haben wir einen ersten Container mit der Anwendung portainer erstellt. Diese hilft uns nun bei den weiteren Schritten.

## Portainer (GUI)

### URL aufrufen
Wir können nun die Kosnole verlassen und an einen anderen PC der im selben Netz ist arbeiten. Wenn wir jetzt in einem Browser die IP unserers Raspiblitz gefolgt von einem Doppelpunkt und der Zahl 9000 eingeben. Kommen wir auf die Weboberfläche des portainers.

Beispiel: IP Raspiblitz = 192.168.0.21 - Dann im Browser folgendes aufrufen:
```
http://192.168.0.21:9000
```

### Erste Anmeldung

Wenn Du portainer zum ersten Mal aufrufst wirst Du geben ein Passwort einzugeben um den Zugang zu dieser Anwendung zu sichern.

Nachdem Du dies getan hast befindest Du Dich auf der Weboberfläche von portainer und wir können nun darüber jegliche Docker Container installieren.

## Schritt 3. HomeAssistant installieren
