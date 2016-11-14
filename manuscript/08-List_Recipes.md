# Rezepte für ngFor-Listen

In diesem Kapitel befinden sich Rezepte, die uns bei der Arbeit mit Listen helfen, die in der View mittels der NgFor-Direktive angezeigt werden. Wie man solche Listen anzeigen kann, wird im Rezept "[Liste von Daten anzeigen](#c03-data-list)" dargestellt.

## Mit dem Index von ngFor-Elementen arbeiten

### Problem

Ich möchte den Index der ngFor-Elemente in der View anzeigen.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: `
    <ul>
      <li *ngFor="let user of users; let i = index">
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

* Zeile 7: Definiert eine lokale Variable "i", die den Index für das aktuelle Element referenziert. In diesem Fall ist __index__ ein spezielles ngFor-Konstrukt
* Zeile 8: Die lokale Variable "i" für den Index wird mittels [Interpolation](#gl-interpolation) angezeigt

### Diskussion

Hier zeigen wir den Index nur in der View an. Natürlich können wir die lokale Variable "i" auch einer Methode übergeben oder diese nutzen, um etwas zu berechnen. Z. B. können wir in Zeile 8 eine Eins zu der Variable "i" addieren, so dass die Anzeige mit __1__ statt __0__ beginnt. Der Ausdruck dafür wäre __{{i + 1}}__.

### Code

Code auf Github: [08-List\_Recipes/01-ngFor\_Element\_Index](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/01-ngFor_Element_Index).
Dort werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit Index gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/01-ngFor_Element_Index/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und Template-Ausdrücken gibt es in [Appendix A: Template-Syntax](#appendix-a)

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

Code auf Github: [08-List\_Recipes/02-Even\_Odd\_ngFor\_Elements](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/02-Even_Odd_ngFor_Elements).
Dort werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit even/odd gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/02-Even_Odd_ngFor_Elements/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Das erste und das letzte ngFor-Element finden

### Problem

Ich möchte das erste und das letzte Element meiner Liste farblich hervorheben.

### Zutaten
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei, die in "Liste von Daten anzeigen" verwendet wird
* [CSS-Klasse dynamisch setzen](#c03-dynamic-classes), um die CSS-Klasse mit der richtigen Farbe zu setzen

### Lösung

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
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
* Zeile 11: Definiert die lokalen Variablen "isLast" und "isFirst". Die isLast-Variable ist __true__, wenn das aktuelle Element das Letzte in der Liste ist, ansonsten ist sie __false__. Die isFirst-Variable ist __true__, wenn das aktuelle Element das Erste in der Liste ist, ansonsten ist sie __false__. In diesem Fall sind __last__ und __first__ spezielle ngFor-Konstrukte
* Zeile 12: Hier wird die Klasse "first" gesetzt, falls das aktuelle Element das Erste der Liste ist oder "last" falls es das letzte Element der Liste ist

### Diskussion

Hier nutzen wir die Information, ob das aktuelle Element das Erste oder das Letzte in der Liste ist, um die entsprechenden Elemente farblich hervorzuheben.
Wie auch in den vorherigen zwei Rezepten können wir hier die Information, ob ein Element das Erste oder das Letzte einer Liste ist, z. B. an eine Methode übergeben.

### Code

Code auf Github: [08-List\_Recipes/03-First\_Last\_ngFor\_Element](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/03-First_Last_ngFor_Element).
Dort werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/03-First_Last_ngFor_Element/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Die Performance mit trackBy verbessern

### Problem

Ich habe eine große Liste von Objekten, die ich mit NgFor anzeige und ich möchte die Liste durch eine Liste ersetzen, die größtenteils die gleichen Objekte enthält.

### Zutaten

* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der app.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface User {
  firstname: string,
  lastname: string,
  id: number
}

const users: Array<User> = [
  {firstname: 'Max', lastname: 'Mustermann', id: 0},
  {firstname: 'John', lastname: 'Doe', id: 1}
];

@Component({
  selector: 'app-root',
  template: `
    <ul>
      <li *ngFor="let user of users; trackBy:trackById">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})
export class AppComponent {
  users = users;

  constructor() {...}

  trackById(index: number, user: User) {
    return user.id;
  }
}
```

__Erklärung__:

Damit wir "trackBy" effizient nutzen können, müssen die Objekte in unserem Array eine Eigenschaft, deren Wert für jedes Objekt eindeutig ist, besitzen.
Wir haben hier eine Eigenschaft namens "id" benutzt.

* Zeilen 9-12: Array mit User-Objekten die einen eindeutigen Wert für die id-Eigenschaft besitzen
* Zeile 18: Hier nutzen wir die spezielle Eigenschaft "trackBy" der NgFor-Direktive mit der trackById-Methode der Klasse (siehe Zeilen 29-31)
* Zeilen 29-31: Methode, die wir in Kombination mit der trackBy-Eigenschaft in Zeile 18 nutzen

### Diskussion

Es kann zu Performance-Problemen kommen, wenn wir NgFor mit großen Listen nutzen und wir später die Liste durch eine Neue ersetzen.
In solchen Fällen können wir trackBy nutzen. Angular wird dann nur die DOM-Elemente ersetzen, die sich tatsächlich geändert haben.
Ohne trackBy muss Angular die komplete Liste im DOM neu generieren, da es nicht wissen kann, dass sich ggf. viele Elemente gar nicht geändert haben.

Damit Angular erkennen kann, welche Elemente sich geändert haben, müssen wir eine trackBy-Methode (hier "trackById") definieren.
Diese erhält den Index und ein Listen-Element als Parameter und gibt den Wert der eindeutigen Eigenschaft (hier "user.id") zurück.
Wenn jetzt die Liste ersetzt wird, wird Angular durch die neue Liste gehen und für jedes Element die trackBy-Methode aufrufen.
Falls der zurückgegebene Wert schon bekannt ist (z. B. das Element mit ID 1 war schon in der alten Liste), wird Angular das Element mit dem schon bekannten Element vergleichen.
Wenn das alte sich vom neuem Element unterscheidet, wird das DOM aktualisiert.
Falls diese gleich sind, bleibt das DOM so wie es ist.
Elemente, die noch nicht bekannt sind, werden hinzugefügt und alte Elemente, die sich nicht mehr in der Liste befinden, werden aus dem DOM entfernt.

Das Code-Beispiel auf Github ist ausführlicher als das Beispiel hier. Dort können wir auch sehen, wie sich in jedem Fall das DOM verändert, wenn wir auf den "New List" Button klicken.
Am einfachsten ist es, in den Chrome DevTools sich die Elemente im DOM anzuschauen und gleichzeitig auf den Button zu klicken.
In den Varianten ohne "trackBy" wird sich die komplette Liste ändern und in den Varianten mit "trackBy" nur das zweite Element der Liste.

### Code

Code auf Github: [08-List\_Recipes/04-Improve\_Performance\_with\_trackBy](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/04-Improve_Performance_with_trackBy).
Dort werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit trackBy gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/04-Improve_Performance_with_trackBy/index.html)

