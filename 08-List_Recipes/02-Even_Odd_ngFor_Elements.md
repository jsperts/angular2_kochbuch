## Gerade und ungerade ngFor-Elemente unterscheiden

### Problem

Ich möchte, dass gerade Elementen meiner Liste eine andere Farbe als die ungeraden haben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der main.ts-Datei, die in _Liste von Daten anzeigen_ verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtige Farbe zu setzen

### Lösung

{title="main.ts Anpassungen, lang=js}
```
...

@View({
  template: `
    <style>
      .red {
        color: red;
      }
      .green {
        color: green;
      }
    </style>
    <ul>
      <li *ngFor="#user of users; #isEven = even; #isOdd = odd"
      [ngClass]="{red: isOdd, green: isEven}">
         Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})

...
```

Erklärung:

Die Anpassungen betreffen nur die template-Eigenschaft des Komponenten. Der Rest bleibt gleich.

Zeile 5-12: Definition von CSS-Klassen mittels style-Tags.
Zeile 14: Definiert lokale Variable __isEven__ und __isOdd__ die __true__ oder __false__ sind je nach dem, ob das aktuelle Element gerade oder ungerade ist. In diesem Fall sind __even__ und __odd__ spezielle ngFor-Konstrukte
Zeile 15: Hier werden die Klassen __green__ oder __red__ gesetzt je nach dem, ob das aktuelle Element gerade oder ungerade ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element gerade oder ungerade ist, um die richtige CSS-Klasse zu setzen. Natürlich kann man die lokale Variablen __odd__ und __even__ auch einer Funktion übergeben oder sie nutzen um z. B. nur gerade oder nur ungerade Elementen anzuzeigen.

### Code

Code auf Github: [08-List\_Recipes/02-Even\_Odd\_ngFor\_Elements](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/02-Even_Odd_ngFor_Elements)
Da werden auch die weitere mögliche Schreibweisen von ngFor mit even/odd gezeigt.

