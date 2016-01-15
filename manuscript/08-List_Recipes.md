# Rezepte für ngFor-Listen

In diesem Kapitel befinden sich Rezepte die uns bei der Arbeit mit Listen helfen die in der View mittels ngFor angezeigt werden. Wie man solche Listen anzeigen kann wird im Rezept [Liste von Daten anzeigen](#c03-data-list) gezeigt.

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

## Das erste und letzte ngFor-Element finden

### Problem

Ich möchte das erste und letzte Element meiner Liste farblich hervorheben.

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

Die Anpassungen betreffen nur die template-Eigenschaft des Komponenten. Der Rest bleibt gleich.

Zeile 5-12: Definition von CSS-Klassen mittels style-Tags
Zeile 14: Definiert lokale Variable __isLast__ und __i__. Die __isLast__ Variable ist __true__ wenn das aktuelle Element das letzte in der Liste ist, ansonsten ist sie __false__. Die __i__ Variable nutzen wir um den aktuellen Index zu speichern. In diesem Fall sind __last__ und __index__ spezielle ngFor-Konstrukte
Zeile 15: Hier wird die Klasse __first__ gesetzt falls das aktuelle Element der Liste ist oder __last__ falls es das letzte Element der Liste ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element das erste oder das letzte in der Liste ist, um die entsprechende Elementen farblich hervorzuheben. Da es derzeit kein spezielles ngFor-Konstrukt für das erste Element einer Liste gibt, sind wir gezwungen es selbst zu berechne auf Basis des Indexes. In der Zukunft wird es vermutlich auch für das erste Element einer Liste ein spezielles Konstrukt geben wie für das letzte. Wie auch in den vorherigen zwei Rezepten, können wir auch hier die Information, ob ein Element das erste oder letzte einer Liste ist, an z. B. einer Funktion übergeben.

### Code

Code auf Github: [08-List\_Recipes/03-First\_Last\_ngFor\_Element](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/03-First_Last_ngFor_Element)
Da werden auch die weitere mögliche Schreibweisen von ngFor mit Index gezeigt.

