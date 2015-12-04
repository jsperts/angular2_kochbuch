## Liste von Daten anzeigen

### Problem

Ich hab eine Liste von Benutzerdaten und ich möchte diese in meine View anzeigen.

### Zutaten
* Daten einer Komponente in der View anzeigen
* Eine Liste von Daten
* Die NgFor Direktive von Angular

### Lösung

main.ts
```js
import {bootstrap, Component, View} from 'angular2/angular2';

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
      <li *ng-for="#user of users">
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

bootstrap(MyApp);
```

Erklärung:

Zeile 3: Interface definition für ein User-Objekt
Zeile 16: Nutzung der NgFor-Direktive um eine Liste anzuzeigen. Der Stern (\*) for dem ng-for ist essentiell und ist Teil der Syntax. Er zeigt an, dass der li-Tag und alle Elemente die es beinhaltet als Template für das ng-for benutzt werden. Der Teil nach dem "of" definiert die Instanzvariable in der sich unsere Liste befindet. Die Raoute (#) definiert eine lokale Variable. Diese können wir nur innerhalb des Elementes mit dem ng-for nutzen und hält eine Referenz zum aktuellen Objekt in der Array
Zeile 17: Hier nutzen wir die lokale Variable, um Informationen anzuzeigen wie wir es im Rezept [Daten einer Komponente in der View anzeigen](#display_component_data) gemacht haben

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen von einer Liste von Daten. Die hier ist die kürzeste und auch vermutlich die einfachste. Die restliche Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

### Code

Code auf Github: [https://github.com/jsperts/angular2\_kochbuch\_code/tree/master/02-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Recipes_to_Manipulate_the_View/02-List_of_Data)

