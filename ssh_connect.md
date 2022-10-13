# SSH Connect ohne Passwort einrichten

Um sich von System A auf B via ssh verbinden zu können wird folgender Befehl verwendet:
```
ssh userB@systemB
```
Dabei wird man natürlich nach dem Passwort von UserB auf dem SystemB gefragt.

Um diesen Vorgang aber zu vereinfachen kann man den ssh key von UserA auf dem SystemB hinterlegen und sich somit ***ohne*** Passwort anmelden.

## Schritt 1. Auf System A

```
ssh-keygen -t rsa
```
Es folgen einige Abfragen:

```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/USER/.ssh/id_rsa):
```

Mit Return bestädtigen oder einen beliebigen Pfad angeben. 

Standard ist das Homeverzechnis des Users.

---

```
Enter passphrase (empty for no passphrase):
```
Hier kannst Du eine Passphrase für den Schlüssel hinterlegen, diese müsste angegeben werden wenn der Schlüssel verwendet wird. 

Für unser Beispiel lassen wir diese Leer! Also einfach Return. Dies wird ***2x*** abgefragt, daher ***zweimal Return***!

---

Nun wird angezeigt das ein Key erstellt worden ist und wo dieser liegt.

## Schritt 2. Erstelle .ssh Verzeichnis auf SystemB
Nun melde Dich (diesmal noch mit normal mit Passwort) auf SystemB als UserB an.

Erzeugen dort, falls nicht vorhanden, das Verzeichnis .ssh im Homeverzeichnis von UserB.

```
mkdir .ssh
```

## Schritt 3. Schlüssel von UserA (SystemA) wird in das Homeverzechnis von UserB (SystemB) kopiert

Im dritten und letzten Schritt wird der Zugriff mit dem anfangs erzeugten Schlüssel eingerichtet.

Das geht am sichersten von SystemA aus mit folgendem Befehl (***wobei Du ein letztes Mal das Passwort eingeben musst - danach sollte es ohne gehen***):

Auf SystemA als UserA:
```
cat ~/.ssh/id_rsa.pub | ssh b@B 'cat >> .ssh/authorized_keys'
Dabei wird der öffentliche Teil des Schlüsselpaares beim Benutzer b an die Textdatei .ssh/authorized_keys angehängt. In dieser Datei können auch mehrere Schlüssel erlaubt werden - einer pro Zeile.

Wenn Sie alles richtig gemacht haben, muss jetzt ein Einloggen ohne Passwort möglich sein
