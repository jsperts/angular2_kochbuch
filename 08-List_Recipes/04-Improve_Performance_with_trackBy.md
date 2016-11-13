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

