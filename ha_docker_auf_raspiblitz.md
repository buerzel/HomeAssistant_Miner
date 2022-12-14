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

Um die Konfiguration von Docker zu vereinfachen gibt es ein grafisches Userinterface was wir als erste Docker Anwendung installieren.
Dieser Container heißt **portainer** und wird wie folgt installiert:

Zuerst wird ein sogenantes Volume angelegt in dem der Docker Container seine Daten speichern kann. Für portainer müssen wir daher folgendes im Terminal eintragen. An dieser Stelle erstellen wir auch direkt für unser Homeassistant ein Volume was wir später benötigen werden.

```
docker volume create portainer_data

docker volume create homeassistant_data
```
Nachdem dieses Volume angelegt wurde installieren wir mit folgendem Aufruf portainer.

```sh
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```

Nun haben wir einen ersten Container mit der Anwendung portainer erstellt. Diese hilft uns nun bei den weiteren Schritten.

### Portainer (GUI)

#### URL aufrufen
Wir können nun die Kosnole verlassen und an einen anderen PC der im selben Netz ist arbeiten. Wenn wir jetzt in einem Browser die IP unserers Raspiblitz gefolgt von einem Doppelpunkt und der Zahl 9000 eingeben. Kommen wir auf die Weboberfläche des portainers.

Beispiel: IP Raspiblitz = 192.168.0.21 - Dann im Browser folgendes aufrufen:
```
http://192.168.0.21:9000
```

#### Erste Anmeldung

Wenn Du portainer zum ersten Mal aufrufst wirst Du geben ein Passwort einzugeben um den Zugang zu dieser Anwendung zu sichern.

Nachdem Du dies getan hast befindest Du Dich auf der Weboberfläche von portainer und wir können nun darüber jegliche Docker Container installieren.

## Schritt 3. HomeAssistant installieren

<img src="Images/schritt3_1.png" width="80%">

So in etwa sollte die **portainer** Oberfläche bei euch im Browser angezeigt werden. Ist dies der Fall könnt ihr auf das Environment **local** in der Mitte des Bildes klicken.

Danach seit Ihr in dieser Umgebung und bekommt etwa dieses Bild.

<img src="Images/schritt3_2.png" width="80%">

Wundert euch nicht wenn in diesem Bild bereits drei Images angezeigt werden und bei euch nur eins. Ich habe hier schon etwas mehr installiert. :-)

### HA Container

Um nun Homeassistant als Container zu installieren gehen wir wie folgt vor:

Im linken Menü wählst Du den Punkt **Containers**.

<img src="Images/schritt3_3.png" >

Auf der nun aufgerufen Seite findest Du eine Auflistung der bereits installierten Container - bei Dir sollte hier nur der portainer als running stehen.

Wenn Du nun oben rechts auf den Button **Add Container** klickst erhältst Du eine neue Eingabemaske die etwa so aussieht:

<img src="Images/schritt3_4.png" width="90%">

#### Maske ausfüllen und Werte eintragen

Im oberen  Teil dieser Maske werden wir nun folgende Wete ausfüllen:

| Feldname | Wert der eingetragen wird | Bedeutung |
| --- | --- | --- |
| Name: | Homeassistant | Name des Containers |
| Image: | homeassistant/home-assistant:latest | damit wird das Image in der aktuellen Version heruntergeladen |
| Manual network port publishing | host: 8123 -> container: 8123 | Zuerst auf den Button ***+ publish a new network port*** klicken und dann mit den  Werten ausfüllen|

Im unteren Teil der Maske (Advanced container settings) müssen jetzt noch das in [Schritt 2](https://github.com/buerzel/HomeAssistant_Miner/blob/main/ha_docker_auf_raspiblitz.md#schritt-2-docker-l%C3%A4uft---und-nun) angelegte Volume **homeassistant_data** zuordnen.

Die Einträge sollten wie folgt aussehen. Um einen Eintrag anlegen zu können müsst ihr vorher jeweils auf den Button ***+ map additional volume*** klicken.
<img src="Images/schritt3_5.png" width="90%">

Wenn diese Einstellungen getätigt worden sind könnt ihr etwa mittig in diesem Formular auf den Button ***Deploy the Container** klicken.

#### Deploy und Start

Nun wird das Image heruntergeladen und der Container mit euren Einstellungen erstellt. Dies kann einige Minuten dauern.

Wenn der Vorgang abgeschlossen ist sollte nach einem Klick auf den Menüpunkt ***Containers** (links im Menü) folgendes Bild erscheinen:
<img src="Images/schritt3_6.png" width="90%">

Wundert euch nicht wegen der IP Adressen, die werden zur internen Verarbeitung von Docker vergeben.

Eure Homeassistant Umgebung könnte Ihr nun wie folgt aufrufen:

Beispiel: IP Raspiblitz = 192.168.0.21 - Dann im Browser folgendes aufrufen:
```
http://192.168.0.21:8123
```

## WICHTIG

***ToDo....
Anleitung Backup/Restore Container und Docker  bei raspiblitz Update!***

Wenn es ein Update für den Raspiblitz gibt wird die SD Karte komplett neu geflasht und die Container werden weg sein. Daher macht euch von HA auf jedenfall ein Backup.
