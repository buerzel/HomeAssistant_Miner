# Abfragen und Kommandos
Für dieVerbindung über ssh besteht die Möglichkeit auch unabhängig vom Miner Infos zu sammeln und interssante werte abzufragen oder Befehle abzusetzen.

Hier sollen ein paar Anregungen, Ideen und Beispiele gesammelt werden.


## Sensoren
In der ***configuration.yaml*** gibt es die Möglichkeit eigene Sesoren anzulegen. So kann man Dinge die eigentlich nicht vorgesehen waren auch abfragen. ;-)

Ein kleines Beispiel wir so ein Eintrag in der ***configuration.yaml*** aussehen kann:

1. Der erste Eintrag holt die aktuelle Blockzeit :-)
2. Der zweite Eintrag holt beim ckpool den Wert für alle miner die dort auf meiner Adresse laufen würden.
```
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
```
***Anmerkung:*** jeden weiteren sensor könnt ihr direkt unter dem Punkt **sensor** einfügen. Wie im Beipeil!

---

Abfrage an die CKpool Übersichtsseite
```
command: 'curl -s https://solo.ckpool.org/users/3KoiL9Dgz4NhWjF8XrUxMZQgeABdTUjoeb | jq -r ''.["worker"][0]["bestshare"]'''
```


## Kommandos
