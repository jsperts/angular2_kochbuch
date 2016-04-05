# Rezepte für ngFor-Listen

In diesem Kapitel befinden sich Rezepte, die uns bei der Arbeit mit Listen helfen, die in der View mittels der NgFor-Direktive angezeigt werden. Wie man solche Listen anzeigen kann wird im Rezept "[Liste von Daten anzeigen](#c03-data-list)" gezeigt.

## Mit dem Index von ngFor-Elementen arbeiten

### Problem

Ich möchte den Index von den ngFor-Elementen in der View anzeigen.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei

### Lösung

{title="app.component.ts Anpassungen", lang=js}
```
...

@Component({
  selector: 'my-app',
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

__Erklärung__:

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeile 7: Definiert eine lokale Variable "i", die den Index für das aktuelle Element referenziert. In dem Fall ist __index__ ein spezielles ngFor-Konstrukt
* Zeile 8: Die lokale Variable "i" für den Index wird mittels [Interpolation](#gl-interpolation) angezeigt

### Diskussion

Hier zeigen wir den Index nur in der View an. Natürlich können wir die lokale Variable "i" auch einer Methode übergeben oder diese nutzen, um etwas zu berechnen. Z. B. können wir in Zeile 8 eine Eins zu der Variable "i" addieren, so dass die Anzeige mit __1__ statt __0__ beginnt. Der Ausdruck dafür wäre __{{i + 1}}__.

### Code

Code auf Github: [08-List\_Recipes/01-ngFor\_Element\_Index](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/01-ngFor_Element_Index).
Da werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit Index gezeigt.

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und Template-Ausdrücken gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Gerade und ungerade ngFor-Elemente unterscheiden

### Problem

Ich möchte, dass gerade Elementen meiner Liste eine andere Farbe als die ungeraden haben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei, die im Rezept "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="app.component.ts Anpassungen", lang=js}
```
...

@Component({
  selector: 'my-app',
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

__Erklärung__:

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeilen 6-13: Definition von CSS-Klassen mittels style-Tags.
* Zeile 15: Definiert lokale Variablen "isEven" und "isOdd" die __true__ oder __false__ sind je nachdem, ob das aktuelle Element gerade oder ungerade ist. In diesem Fall sind __even__ und __odd__ spezielle ngFor-Konstrukte
* Zeile 16: Hier werden die Klassen "green" oder "red" gesetzt je nachdem, ob das aktuelle Element gerade oder ungerade ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element gerade oder ungerade ist, um die richtige CSS-Klasse zu setzen. Natürlich können wir die lokalen Variablen "isOdd" und "isEven" auch einer Methode übergeben oder diese nutzen, um z. B. nur gerade oder nur ungerade Elementen anzuzeigen.

### Code

Code auf Github: [08-List\_Recipes/02-Even\_Odd\_ngFor\_Elements](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/02-Even_Odd_ngFor_Elements).
Da werden auch die weiteren mögliche Schreibweisen der NgFor-Direktive mit even/odd gezeigt.

### Weitere Ressourcen

* Weitere Informationen zur lokalen Variablen gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Das erste und letzte ngFor-Element finden

### Problem

Ich möchte das erste und letzte Element meiner Liste farblich hervorheben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei, die in "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="app.component.ts Anpassungen", lang=js}
```
...

@Component({
  selector: 'my-app',
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

__Erklärung__:

Die Anpassungen betreffen nur die template-Eigenschaft der Komponente. Der Rest bleibt gleich.

* Zeilen 6-13: Definition von CSS-Klassen mittels style-Tags
* Zeile 15: Definiert lokale Variable "isLast" und "i". Die isLast-Variable ist __true__ wenn das aktuelle Element das letzte in der Liste ist, ansonsten ist sie __false__. Die i-Variable nutzen wir, um den aktuellen Index zu speichern. In diesem Fall sind __last__ und __index__ spezielle ngFor-Konstrukte
* Zeile 16: Hier wird die Klasse "first" gesetzt falls das aktuelle Element das Erste der Liste ist oder "last" falls es das letzte Element der Liste ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element das Erste oder das Letzte in der Liste ist, um die entsprechenden Elemente farblich hervorzuheben.
Da es derzeit kein spezielles ngFor-Konstrukt für das erste Element einer Liste gibt, sind wir gezwungen es selbst zu berechnen auf Basis des Indexes.
In der Zukunft wird es vermutlich auch für das erste Element einer Liste ein spezielles Konstrukt geben wie für das Letzte.
Wie auch in den vorherigen zwei Rezepten, können wir auch hier die Information, ob ein Element das Erste oder Letzte einer Liste ist, an z. B. einer Methode übergeben.

### Code

Code auf Github: [08-List\_Recipes/03-First\_Last\_ngFor\_Element](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/03-First_Last_ngFor_Element).
Da werden auch die weiteren mögliche Schreibweisen der NgFor-Direktive mit Index gezeigt.

### Weitere Ressourcen

* Weitere Informationen zur lokalen Variablen gibt es im [Appendix A: Template-Syntax](#appendix-a)

