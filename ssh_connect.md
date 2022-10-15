# Info vorab
Diese Anleitung ist etwas allgemein gehalten. Daher vorab diese Infos!

Wenn Ihr vorhabt euch von HA (SystemA) zu einem Miner/Pi(SystemB) zu verbinden, würde ich aktuell den ***root*** User auf dem SystemB (hier als UserB benannt) benutzen.

Es kann sein, dass ihr euch standadmäßig nicht als root via ssh an SystemB anmelden könnt. Damit dies geht müsst ihr vorab folgendes tun.

Als root user auf SystemB:

Die Datei `/etc/ssh/sshd_config` um folgenden Eintrag erweitern.

```
PermitRootLogin yes
```

Danach den **ssh** Dienst neu starten: `/etc/init.d/ssh restart`


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
Enter file in which to save the key (/root/.ssh/id_rsa):
```

Mit Return bestädtigen. 

Standard ist das Homeverzechnis des Users.


```
Enter passphrase (empty for no passphrase):
```
Hier kannst Du eine Passphrase für den Schlüssel hinterlegen, diese müsste angegeben werden wenn der Schlüssel verwendet wird. 

Für unser Beispiel lassen wir diese Leer! Also einfach Return. Dies wird ***2x*** abgefragt, daher ***zweimal Return***!

Nun wird angezeigt das ein Key erstellt worden ist und wo dieser liegt.

## Schritt 2. Key kopieren

Dieser Key muss nun auf SystemB.

Dazu nutze folgenden Befehl:
`ssh-copy-id UserB@SystemB`
Du musst das Passwort nochmal eingeben und danach sollte der Key kopiert worden sein.


## Schritt 3.


Auf SystemA
```
ssh userB@systemB
```
Und schwups sind wir auf SystemB als UserB ohne Anmeldung!

---

# Besonderheit für HomeAssistant
<img src="Images/important.png" width="32px"> 
Wenn Ihr das mit HA im Terminal macht, werdet ihr als User root einen Key generiern. Damit dieser von der HA Automation genutzt werden kann, sollte dieser nach dem erstellen (ssh-keygen ...) in das /config Verzechnis kopiert werden. 

Dabei wird die Datei **id_rsa** in **ssh** umkopiert.

Du kannst natürlich jeden anderen Namen benutzten, musst diesen dann aber bei den Paramtern berücksichtigen. 
(ssh -i /config/ssh ... oder ssh -i /config/customname)


`cp ~/.ssh/id_rsa ~/config/ssh`
