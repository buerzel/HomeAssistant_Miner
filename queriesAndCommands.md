
# Abfragen und Kommandos
Für die Verbindung über ssh besteht die Möglichkeit auch unabhängig vom Miner Infos zu sammeln und interssante Werte abzufragen oder Befehle abzusetzen.

Hier sollen ein paar Anregungen, Ideen und Beispiele gesammelt werden.

<img src="Images/important.png" width="32px" >

**Wichtig:** die Punkte **sensor:** , **switch:** und **shell_command** sind jeweils die Überbegriffe unter denen dann alle Aktionen untergeordnet werden. In der ***configuration.yaml*** stehen sie immer ganz links und dadrunter werden die einzelnen Punkte jeweils mit **-** (Bindestrich) eingeleitet.

---

# Sensoren
In der ***configuration.yaml*** gibt es die Möglichkeit eigene Sensoren anzulegen. So kann man Dinge die eigentlich nicht vorgesehen waren auch abfragen. ;-)

### Blockzeit, Hashrate und Difficulty ###

1. Der erste Eintrag holt die aktuelle Blockzeit :-)
2. Der zweite Eintrag holt beim ckpool den Wert für alle Miner die dort auf meiner Adresse laufen würden.
3. Der dritte Eintrag holt die aktuelle Difficulty.
```yaml
sensor:
  - platform: rest
    name: nextBlock
    unique_id: nextblockid
    resource: https://mempool.space/api/blocks/tip/height
    unit_of_measurement: Block
    value_template: "{{ value }}"
    scan_interval: 500
  - platform: command_line
    command: 'curl -s https://solo.ckpool.org/users/<BTCADRESSE> | jq -r ''.["hashrate1m"]'''
    name: ckpoolHashrate1m
    unique_id: ckpoolHashrate1mId
    unit_of_measurement: Hs
    scan_interval: 60
  - platform: command_line
    command: "curl -s https://mempool.space/api/v1/mining/hashrate/3d | jq -r '.[\"currentDifficulty\"]'"
    name: currentDifficulty
    unique_id: currentDifficulty
    unit_of_measurement: Difficulty
    value_template: "{{ value | float | round(0) }}"
    scan_interval: 500
```
***Anmerkung:*** jeden weiteren Sensor könnt ihr direkt unter dem Punkt **sensor** einfügen. Wie im Beispiel!

### Abfrage zu welcher Uhrzeit(Unix Timestamp -> Uhrzeit) der letzte share beim ckpool eingereicht wurde.
```yaml
- platform: command_line
  command: 'curl -s https://solo.ckpool.org/users/<BTCADRESSE_BEI_CKSOLO> | jq -r ''.["lastshare"]'''
  name: CK Solo Lastshare
  unique_id: cksoloLastShareId
  value_template: "{{ value | int | timestamp_custom('%d.%m.%Y %H:%M:%S')}}"
  scan_interval: 60
```

### Abfrage an die CKpool Übersichtsseite für die bestshare eines bestimmten Worker und die gesamte Hashrate der letzten Minute für alle Worker
```yaml
  - platform: command_line
    command: 'curl -s https://solo.ckpool.org/users/<BTCADRESSE> | jq -r ''.["worker"][0]["bestshare"]'''
    name: cksolo_bestshare
    unique_id: cksoloBestshareId
    unit_of_measurement: shares
    value_template: "{{ value }}"
    scan_interval: 600
  - platform: command_line
    command: 'curl -s https://solo.ckpool.org/users/<BTCADRESSE>  | jq -r ''.["hashrate1m"]'''
    name: ckpoolHashrate1m
    unique_id: ckpoolHashrate1mId
    unit_of_measurement: Hs
    scan_interval: 60
```

### Abfrage an einen anderen Pi welche BTCAdresse gerade fürs Mining genutzt (Unterschiede gibt es bei Apollo -user und Cgminer -u)
```yaml
  - platform: command_line
    name: 'BTC Apollo Adresse'
    unique_id: btcApolloAdrID
    command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB ps -ef | grep SCREEN | sed 's/^.*-user//g;s/-p.*$//g'
    scan_interval: 60
    value_template: "{{ value[:5] + '....' +  value[-20:] }}"
  - platform: command_line
    name: 'BTC Cgminer Adresse'
    unique_id: btcCgminerAdrID
    command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB ps -ef | grep SCREEN | sed 's/^.*-u//g;s/-p.*$//g'
    scan_interval: 60
    value_template: "{{ value[:5] + '....' +  value[-20:] }}"
```
Wer die gesamte Adresse angezeigt bekommen haben möchte tauscht das value_template aus:

komplette Ansicht value_template: "{{ value }}"
gekürzte Ansicht `value_template: "{{ value[:5] + '....' +  value[-20:] }}"`



### CPU Abfrage auf einem Pi für das Apollo und Cgminer Binary**
Bitte beachte den Parameter **-f** beim **cut** Befehl. dieser zählt den Abstand zur Ausgabe für die CPU. Falls kein Wert zurückgeliefert wird, kann es sein das der Abstand nicht mehr stimmt.

```yaml
- platform: command_line
    name: 'CPU Apollo'
    unique_id: cpuApolloId
    command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB top -bn 1 | grep apollo | cut -d' ' -f25
    value_template: "{{ value }}"
    unit_of_measurement: '%'
    scan_interval: 60
- platform: command_line
    name: 'CPU Cgminer'
    unique_id: cpuCgminerId
    command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB top -bn 1 | grep cgminer | cut -d' ' -f22
    value_template: "{{ value }}"
    unit_of_measurement: '%'
    scan_interval: 60
```

### Apollo Infos Abfragen über die Datei apollo-miner.* (json datei)
Die Datei wird immer nach dem Start neu angelegt mit einer anderen Nummer ( z.B. apollo-miner.3232323243243434). Damit die Nummer keine Rolle spielt, laufen die Abfragen auf die Wildcard (*).

In dieser Datei werden regelmäßig alle Infos zum Apollo Miner abgelegt während des minings.
Da es sich um eine json datei handelt, kann die sehr schnell abgefragt werden.

***! Da diese Datei immer im UserVerzeichnis des User der das Apollo Binary gestartet hat angelegt wird, wird in unserem Fall die Datei unter /root zu finden sein. GGF. Mußt Du das den Pfad anpassen.*** z.B. `/bin/cat /USERB/apollo-miner.*`

#### Die aktuelle Lüfterumdrehung
```yaml
- platform: command_line
  command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB "/bin/cat apollo-miner.*  | jq -cr '.[\"fans\"][\"0\"][\"rpm\"]' | jq -r '.[]' "
  name: apollo_fans
  unique_id: apolloFansId
  unit_of_measurement: rpm
  value_template: "{{ value }}"
  scan_interval: 60
```

#### Aktuelle Durchschnittstemperatur
```yaml
- platform: command_line
  command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB "/bin/cat apollo-miner.*  | jq -cr '.[\"temperature\"][\"avr\"]'' "
  name: apollo_temp
  unique_id: apolloTempId
  unit_of_measurement: Grad
  value_template: "{{ value }}"
  scan_interval: 60
```

#### Aktuelle Watt Pro GHs Angabe
```yaml
- platform: command_line
  command: ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB "/bin/cat apollo-miner.* | jq -r '.[\"master\"][\"wattPerGHs\"]' "
  name: apollo_wattPerGHs
  unique_id: apolloWattPerGHsId
  unit_of_measurement: W/GHS
  value_template: "{{ value }}"
  scan_interval: 60
```

---



# Command (z.B. via Switch, Button oder als Aktion in der Automatisierung)

Ein Beispiel für die Einbindung eines Befehls in HA über die ***configuration.yaml***

Hier wird auf dem Pi das miner.sh script mit Parameter ausgeführt.
```yaml
shell_command:
  kommando1: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh Miner01"
  kommando2: "ssh -i /config/ssh -o 'StrictHostKeyChecking=no' UserB@SystemB bash /home/miner.sh stop"
```

--- 

# Sonstiges
Ein Beispiel für eine spezielle Abfrage auf die Webseite der MiningGruppe: http://solomining.info:8080/reward.
Es soll das Feld Reward für einen bestimmten user ausgelesen werden.
Da es sich um eine JSON Ausgabe handelt kann dies mit dem jq Befehl für einen Sensor funktionieren.

Da die Ausgabe auf dieser Seite Backslashes ```\``` enthält müssen diese durch den Paramter **-j** zuerst bereinigt werden.

Im folgenden Beispiel wollen wir den aktuellen Reward des User OangePill21 als Sensorwert in HA ausgeben.

```yaml
- platform: command_line
  command: 'curl -s http://solomining.info:8080/reward | jq -j | jq -r ''.[] | select(.workername | contains("OrangePill21")) | .["reward"]'''
  name: Reward Pille
  unique_id: rewardPilleId
  unit_of_measurement: BTC
  value_template: "{{ value }}"
  scan_interval: 120
```

Um es an eure Wünsche anzupassen müssen User (hier OrangePill21) und ggf. reward ersetzt werden.
