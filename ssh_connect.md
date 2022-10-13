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

Für unser Beispiel lassen wir diese Leer! Also einfach Return. Dies wird 2x abgefragt, daher zweimal Return!

---
