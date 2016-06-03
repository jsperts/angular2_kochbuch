## Die Performance mit trackBy verbessern

### Problem

Ich habe eine große Liste von Objekten, die ich mit NgFor anzeige und ich möchte die Liste durch eine Liste ersetzen, die größtenteils die gleichen Objekte enthält.

### Zutaten

* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen in der demo.component.ts-Datei

### Lösung

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface IUser {
  firstname: string,
  lastname: string,
  id: number
}

const users: Array<IUser> = [
  {firstname: 'Max', lastname: 'Mustermann', id: 0},
  {firstname: 'John', lastname: 'Doe', id: 1}
];

@Component({
  selector: 'demo-app',
  template: `
    <ul>
      <li *ngFor="let user of users; trackBy:trackById">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})
export class DemoAppComponent {
  users = users;

  constructor() {...}

  trackById(index: number, user: IUser) {
    return user.id;
  }
}
```

__Erklärung__:

Damit wir "trackBy" effizient nutzen können, brauchen die Objekte in unserem Array eine Eigenschaft deren Wert für jedes Objekt eindeutig ist.
Wir haben hier eine Eigenschaft namens "id" benutzt.

* Zeilen 9-12: Array mit IUser-Objekt die einen eindeutigen Wert für die id-Eigenschaft haben
* Zeile 18: Hier nutzen wir die spezielle Eigenschaft "trackBy" der NgFor-Direktive mit der trackById-Methode der Klasse (siehe Zeilen 29-31)
* Zeilen 29-31: Methode die wir in Kombination mit der trackBy-Eigenschaft auf Zeile 18 nutzen

### Diskussion

Es kann zu Performance-Probleme kommen, wenn wir NgFor mit große Listen nutzen und wir später die Liste durch eine neue ersetzen.
In solchen Fällen können wir trackBy nutzen und Angular wird nur die DOM-Elemente ersetzen die sich tatsächlich geändert haben.
Ohne trackBy müsste Angular die komplete Liste im DOM neu generieren, da es nicht wissen kann, dass sich ggf. viele Elemente gar nicht geändert haben.

Damit Angular erkennen kann welche Elemente sich geändert haben, müssen wir eine trackBy-Methode (hier "trackById") definieren.
Diese bekommt den Index und ein Listen-Element als Parameter und gibt zurück den Wert der eindeutigen Eigenschaft (hier "user.id").
Wenn jetzt die Liste ersetzt wird, wird Angular durch die neue Liste gehen und für jedes Element wird die trackBy-Methode aufgerufen.
Falls der zurückgegebene Wert schon bekannt ist (z. B. das Element mit ID 1 war schon in der alten Liste), wird Angular das Element mit dem schon bekannten Element vergleichen.
Wenn das alte sich vom neuem Element unterscheidet, wird das DOM aktualisiert.
Falls diese gleich sind, bleibt das DOM so wie es ist.
Elemente die noch nicht bekannt sind, werden hinzugefügt und alte Elemente die nicht mehr in der Liste sind, werden aus dem DOM entfernt.

Das Code-Beispiel auf Github ist ausführlicher als das Beispiel hier und damit können wir auch sehen wie sich in jedem Fall das DOM verändert, wenn wir auf den "New List" Button klicken.
Am einfachsten ist es in dem Chrome DevTools die Elemente im DOM sich anzuschauen und gleichzeitig auf den Button zu klicken.
In den Varianten ohne "trackBy" wird sich die komplette Liste ändern und in den Varianten mit "trackBy" nur das zweite Element der Liste.

### Code

Code auf Github: [08-List\_Recipes/04-Improve\_Performance\_with\_trackBy](https://github.com/jsperts/angular2_kochbuch_code/tree/master/08-List_Recipes/04-Improve_Performance_with_trackBy).
Da werden auch die weiteren möglichen Schreibweisen der NgFor-Direktive mit trackBy gezeigt.

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/08-List_Recipes/04-Improve_Performance_with_trackBy/index.html

