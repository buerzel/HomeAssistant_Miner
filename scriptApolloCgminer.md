# Script um Apollo oder Cgminer Software anzusprechen

Hier findet Ihr die Doku zu dem script miner.sh welches ebenfalls hier im Repo liegt 

[script miner.sh](https://github.com/buerzel/HomeAssistant_Miner/blob/main/miner.sh)

## Konfigurieren

Wenn Du das Scri pt heruntergeladen hast mustt Du es noch konfigurieren. Dazu öffne es mit dem editor Deiner Wahl und trage im Part 1. die gewünschten Strings für die Miner ein. Miner01 -MinerXX.

Falls Du mehr als zwei Miner angelegt hast musst Du im Part 2. für jeden weiteren Miner eine weitere ***elif*** Schleife hinzufügen. 

Denk daran die ***#*** Rauten/Hashtags zu entfernen um auszukommentieren.
```
#elif [ $1 == "MinerXY" ]
#    then
#    /usr/bin/screen -dm $MinerXY
#    exit 0;
```


## Ausführung
Das Script wird mit den konfigurierten Parametern aufgerufen.

z.B.:
```
./miner.sh Miner01
```
