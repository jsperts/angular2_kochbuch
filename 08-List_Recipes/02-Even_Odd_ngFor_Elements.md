## Gerade und ungerade ngFor-Elemente unterscheiden

### Problem

Ich möchte, dass gerade Elemente meiner Liste eine andere Farbe als ungerade erhalten.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei, die im Rezept "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  styles: [
    '.red { color: red; }',
    '.green { color: green; }'
  ],
  template: `
    <ul>
      <li *ngFor="let user of users; let isEven = even; let isOdd = odd"
          [ngClass]="{red: isOdd, green: isEven}">
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
* Zeile 11: Definiert lokale Variablen "isEven" und "isOdd" die, je nachdem ob das aktuelle Element gerade oder ungerade ist, __true__ oder __false__ sind. In diesem Fall sind __even__ und __odd__ spezielle ngFor-Konstrukte
* Zeile 12: Hier werden, je nachdem, ob das aktuelle Element gerade oder ungerade ist, die Klassen "green" oder "red" gesetzt

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element gerade oder ungerade ist, um die richtige CSS-Klasse zu setzen. Natürlich können wir die lokalen Variablen "isOdd" und "isEven" auch einer Methode übergeben oder diese nutzen, um z. B. nur gerade oder nur ungerade Elemente anzuzeigen.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/02-Even_Odd_ngFor_Elements).
Dort werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit even/odd gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/02-Even_Odd_ngFor_Elements/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen gibt es in [Appendix A: Template-Syntax](#appendix-a)

