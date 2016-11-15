## Liste von Daten anzeigen {#c03-data-list}

### Problem

Ich hab eine Liste von Benutzerdaten und möchte diese in meine View anzeigen.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Eine Liste von Daten
* Die NgFor-Direktive von Angular

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface User {
  firstname: string;
  lastname: string;
}

const users: Array<User> = [
  { firstname: 'Max', lastname: 'Mustermann' },
  { firstname: 'John', lastname: 'Doe' }
];

@Component({
  selector: 'app-root',
  template: `
    <ul>
      <li *ngFor="let user of users">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})
export class AppComponent {
  users: Array<User>;

  constructor() {
    this.users = users;
  }
}
```

__Erklärung__:

* Zeilen 3-6: Interfacedefinition für User-Objekte
* Zeile 17: Nutzung der NgFor-Direktive, um eine Liste anzuzeigen
* Zeile 18: Hier nutzen wir die lokale Variable "user", um Informationen anzuzeigen, wie wir es im Rezept "[Daten einer Komponente in der View anzeigen](#c03-show-data)" getan haben

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen einer Liste von Daten.
Diese hier ist die Kürzeste und auch vermutlich die Einfachste.
Die restlichen Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngFor-Syntax:

Der Stern (__\*__) vor dem __ngFor__ ist essentiell und Teil der Syntax.
Er zeigt an, dass der li-Tag und alle Elemente, die der Tag beinhaltet, als Template für die Instanz der NgFor-Direktive benutzt werden sollen.
Der Teil nach dem __of__ ist der Name der Komponenten-Eigenschaft, die unsere Liste referenziert.
Das Keyword __let__  definiert eine lokale Template-Eingabevariable für die Instanz der NgFor-Direktive.
Diese können wir nur innerhalb des Elementes mit dem ngFor nutzen. Sie hält eine Referenz auf das aktuelle Objekt in der Array.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/02-List_of_Data/index.html)

### Weitere Ressourcen

* Offizielle [NgFor](https://angular.io/docs/ts/latest/api/common/index/NgFor-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu lokalen Variablen und der Template-Syntax gibt es in [Appendix A: Template-Syntax](#appendix-a)

