## Mit dem Index von ngFor-Elementen arbeiten

### Problem

Ich möchte den Index von meinen ngFor-Elementen wissen, so dass ich diesen in der View anzeigen kann.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der main.ts-Datei, die in _Liste von Daten anzeigen_ verwendet wird

### Lösung

{title="main.ts Anpassungen, lang=js}
```
...

@View({
  template: `
    <ul>
      <li *ngFor="#user of users; #i = index">
        Index: {{i}},
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})

...
```

Erklärung:

Die Anpassungen betreffen nur die template-Eigenschaft des Komponenten. Der Rest bleibt gleich.

Zeile 6: Definiert eine lokale Variable __i__ die den Index für das aktuelle Element referenziert. In dem Fall ist __index__ ein spezielles ngFor-Konstrukt
Zeile 7: Die lokale Variable __i__ für den Index wird mittels [Interpolation](#gl-interpolation) angezeigt

### Diskussion

Hier zeigen wir den Index nur in der View an. Natürlich kann man die lokale Variable __i__ auch einer Funktion übergeben oder sie nutzen um etwas zu berechnen. Z. B. kann man in Zeile 7 eine __Eins__ zu der Variable __i__ addieren, so dass die Anzeige mit __1__ statt __0__ beginnt. Der Ausdruck dafür wäre _{{i + 1}}_.

### Code

Code auf Github: [08-List\_Recipes/01-ngFor\_Element\_Index](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/01-ngFor_Element_Index)
Da werden auch die weitere mögliche Schreibweisen von ngFor mit Index gezeigt.

