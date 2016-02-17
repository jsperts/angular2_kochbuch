## Liste von Daten anzeigen {#c03-data-list}

### Problem

Ich hab eine Liste von Benutzerdaten und ich möchte diese in meine View anzeigen.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Eine Liste von Daten
* Die NgFor-Direktive von Angular

### Lösung

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

interface IUser {
  firstname: string,
  lastname: string
}

const users: Array<IUser> = [{firstname: 'Max', lastname: 'Mustermann'}, {firstname: 'John', lastname: 'Doe'}];

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <ul>
      <li *ngFor="#user of users">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})
class MyApp {
  users: Array<IUser>;
  constructor() {
    this.users = users;
  }
}

export default MyApp;
```

Erklärung:

* Zeile 3-6: Interface Definition für ein User-Objekt
* Zeile 16: Nutzung der NgFor-Direktive, um eine Liste anzuzeigen
* Zeile 17: Hier nutzen wir die lokale Variable "user", um Informationen anzuzeigen wie wir es im Rezept [Daten einer Komponente in der View anzeigen](#c03-show-data) getan haben

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen von einer Liste von Daten. Die hier ist die kürzeste und auch vermutlich die einfachste. Die restlichen Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngFor-Syntax:

Der Stern (\*) vor dem __ngFor__ ist essentiell und Teil der Syntax. Er zeigt an, dass der li-Tag und alle Elemente, die der Tag beinhaltet, als Template für das ngFor benutzt werden sollen. Der Teil nach dem __of__, ist der Name der Komponenten-Eigenschaft die unsere Liste referenziert. Die Raute (#) definiert eine lokale Variable. Diese können wir nur innerhalb des Elementes mit dem ngFor nutzen und hält eine Referenz zum aktuellen Objekt in der Array.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

### Weitere Ressourcen

* Offizielle [NgFor](https://angular.io/docs/ts/latest/api/common/NgFor-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu lokalen Variablen und der Template-Syntax gibt es in [Appendix A: Template-Syntax](#appendix-a)

