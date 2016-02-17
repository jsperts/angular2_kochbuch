## Mit dem Index von ngFor-Elementen arbeiten

### Problem

Ich möchte den Index von den ngFor-Elementen in der View anzeigen.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei

### Lösung

{title="app.component.ts Anpassungen, lang=js}
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

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeile 6: Definiert eine lokale Variable "i" die den Index für das aktuelle Element referenziert. In dem Fall ist __index__ ein spezielles ngFor-Konstrukt
* Zeile 7: Die lokale Variable "i" für den Index wird mittels [Interpolation](#gl-interpolation) angezeigt

### Diskussion

Hier zeigen wir den Index nur in der View an. Natürlich kann man die lokale Variable "i" auch einer Methode übergeben oder sie nutzen, um etwas zu berechnen. Z. B. kann man in Zeile 7 eine __Eins__ zu der Variable "i" addieren, so dass die Anzeige mit __1__ statt __0__ beginnt. Der Ausdruck dafür wäre _{{i + 1}}_.

### Code

Code auf Github: [08-List\_Recipes/01-ngFor\_Element\_Index](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/01-ngFor_Element_Index).
Da werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit Index gezeigt.

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und Template-Ausdrücken gibt es im [Appendix A: Template-Syntax](#appendix-a)

