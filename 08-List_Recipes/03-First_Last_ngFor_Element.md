## Das erste und letzte ngFor-Element finden

### Problem

Ich möchte das erste und letzte Element meiner Liste farblich hervorheben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei, die in "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="app.component.ts Anpassungen, lang=js}
```
...

@View({
  template: `
    <style>
      .first {
        background-color: red
      }
      .last {
        background-color: green
      }
    </style>
    <ul>
      <li *ngFor="#user of users; #isLast = last; #i = index"
      [ngClass]="{first: i === 0, last: isLast}">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})

...
```

Erklärung:

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeile 5-12: Definition von CSS-Klassen mittels style-Tags
* Zeile 14: Definiert lokale Variable "isLast" und "i". Die isLast-Variable ist __true__ wenn das aktuelle Element das letzte in der Liste ist, ansonsten ist sie __false__. Die i-Variable nutzen wir um den aktuellen Index zu speichern. In diesem Fall sind __last__ und __index__ spezielle ngFor-Konstrukte
* Zeile 15: Hier wird die Klasse __first__ gesetzt falls das aktuelle Element der Liste ist oder "last" falls es das letzte Element der Liste ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element das erste oder das letzte in der Liste ist, um die entsprechenden Elemente farblich hervorzuheben.
Da es derzeit kein spezielles ngFor-Konstrukt für das erste Element einer Liste gibt, sind wir gezwungen es selbst zu berechne auf Basis des Indexes.
In der Zukunft wird es vermutlich auch für das erste Element einer Liste ein spezielles Konstrukt geben wie für das letzte.
Wie auch in den vorherigen zwei Rezepten, können wir auch hier die Information, ob ein Element das erste oder letzte einer Liste ist, an z. B. einer Methode übergeben.

### Code

Code auf Github: [08-List\_Recipes/03-First\_Last\_ngFor\_Element](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/03-First_Last_ngFor_Element).
Da werden auch die weiteren mögliche Schreibweisen der NgFor-Direktive mit Index gezeigt.

### Weitere Ressourcen

* Weitere Informationen zur lokalen Variablen gibt es im [Appendix A: Template-Syntax](#appendix-a)

