# Bill Split App

## Structuur

* Personen
    * Add -> Event & setter
    * Delete -> Event & setter
    * Alle oproepen -> Getter
    * Specifiek -> Getter
    * Betaald -> Getter & setter

* Tasks
    * Add -> Event & setter
    * Delete -> Event & setter
    * Edit -> Event & setter
    * Betaald -> Getter & setter
    * Alle oproepen -> Getter
    * Specifiek -> Getter

* IOU
    * Add -> Event & setter
    * Delete -> Event & setter
    * Edit -> Event & setter
    * Specifiek -> Getter
        * Per persoon
        * Per task

* Berekening
    * Omzetting percentage <> euro en omgekeerd -> Event & setter
    * Gelijk verdelen -> Setter
    * Individueel -> Setter

## Structuur JSON files
### Tasks (Bills)
```
[
        {

            "id": 1,
            "title": "Paul's Boutique",
            "type": "resto",
            "price": 25.65,
            "timestamp": 1386260176,
            "paid": true
        }

]
```

### Persons
```
[
    {
        "id": 1,
        "name": "Justin Timberlake",
        "image": "url",
        "task_id": 1,
        "moderator": true
    }
]
```

### Iou (I owe you)
```
[
        {
            "price": 25.65,
            "person_id": 1,
            "task_id": 1,
            "paid": true
        }
]
```