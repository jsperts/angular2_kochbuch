## Das erste und letzte ngFor-Element finden

### Problem

Ich möchte das erste und letzte Element meiner Liste farblich hervorheben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der demo.component.ts-Datei, die in "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  styles: [
      '.first { background-color: red; }',
      '.last { background-color: green; }'
  ],
  template: `
    <ul>
      <li *ngFor="let user of users; let isLast = last; let isFirst = first"
          [ngClass]="{first: isFirst, last: isLast}">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})

...
```

__Erklärung__:

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeilen 6-7: Definition von CSS-Klassen
* Zeile 11: Definiert lokale Variable "isLast" und "isFirst". Die isLast-Variable ist __true__, wenn das aktuelle Element das letzte in der Liste ist, ansonsten ist sie __false__. Die isFirst-Variable ist __true__, wenn das aktuelle Element das erst in der Liste ist, ansonsten ist sie __false__. In diesem Fall sind __last__ und __first__ spezielle ngFor-Konstrukte
* Zeile 12: Hier wird die Klasse "first" gesetzt falls das aktuelle Element das Erste der Liste ist oder "last" falls es das letzte Element der Liste ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element das Erste oder das Letzte in der Liste ist, um die entsprechenden Elemente farblich hervorzuheben.
Wie auch in den vorherigen zwei Rezepten, können wir auch hier die Information, ob ein Element das Erste oder Letzte einer Liste ist, an z. B. einer Methode übergeben.

### Code

Code auf Github: [08-List\_Recipes/03-First\_Last\_ngFor\_Element](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/03-First_Last_ngFor_Element).
Da werden auch die weiteren mögliche Schreibweisen der NgFor-Direktive gezeigt.

### Weitere Ressourcen

* Weitere Informationen zur lokalen Variablen gibt es im [Appendix A: Template-Syntax](#appendix-a)

