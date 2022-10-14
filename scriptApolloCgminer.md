# Script um Apollo oder Cgminer Software anzusprechen

Hier findet Ihr die Doku zu dem script miner.sh welches ebenfalls hier im Repo liegt 

[script miner.sh](https://github.com/buerzel/HomeAssistant_Miner/blob/main/miner.sh)

## Konfigurieren

Wenn Du das Script heruntergeladen hast musst Du es noch konfigurieren. Dazu öffne es mit dem Editor Deiner Wahl und trage im Part 1. die gewünschten Strings für die Miner ein. Miner01 -MinerXX.
**Wichtig** jeder Eintrag braucht eine eindeutige Zuordnung (Miner01, Miner02, Miner03 usw.)

Du kannst so entweder jeweils einen Miner mit anderen Credentials, anderen Pools oder anderen Frequenzeinstellungen anlegen.

Falls Du **mehr als zwei Miner** angelegt hast musst Du im Part 2. für jeden weiteren Miner eine weitere ***elif*** Schleife hinzufügen. 

Denk daran die ***#*** Rauten/Hashtags zu entfernen um auszukommentieren.
Beispiel es gibt den Eintrag Miner03
```
#elif [ $1 == "Miner03" ]
#    then
#    /usr/bin/screen -dm $Miner03
#    exit 0;
```


## Ausführung
Das Script wird mit den konfigurierten Parametern aufgerufen.

z.B.:
`./miner.sh Miner01` oder `*./miner.sh stop`

Wichtig wenn Miner01 aufgerufen wird, wird vorher automatisch jeder vorhandene screen beendet. So wird sicher gestellt dass immer nur eine Konfiguration läuft.
