# Rezepte um mit der Anzeige zu interagieren

In diesem Kapitel geht es, um die verschiedene Möglichkeiten die uns Angular anbietet um Daten einer Komponente in der View anzuzeigen. Desweiteren zeigen wir Möglichkeiten um CSS-Klassen und Styles zu ändern, abhängig von den Daten die wir in unsere Komponente haben. Auch das Ein- und Ausblenden von Teilen des DOMs abhängig von einer Kondition, wird hier gezeigt. Möglichkeiten wie wir auf Nutzer-Input wie z. B. auf Klicks reagieren können, werden auch hier behandelt.

## Daten einer Komponente in der View anzeigen {#c03-show-data}

### Problem

Ich möchte Daten die in meinem TypeScript-Code sind, in der View anzeigen damit der Nutzer die sieht.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Dummy Daten in der Komponente

### Lösung 1

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
class MyApp {
  name: string;

  constructor() {
    this.name = 'Max';
  }
}

...
```

Erklärung:

Um Daten anzuzeigen müssen wir zwei Sachen machen. Erstens müssen wir dem Template sagen welche Variablen es anzeigen soll und zweitens müssen wir diese Variablen in unsere Klasse definieren.
Um den Code übersichtlicher zu gestalten, nutzen wir hier Backticks (\`) für das template-Attribut statt Anführungszeichen ('). Das ermöglicht uns das HTML in mehreren Zeilen aufzuspalten ohne mehrere Strings mit Hilfe von Pluszeichen konkatenieren zu müssen.

* Zeile 9: Hier sagen wir Angular das "name" [interpoliert](#gl-interpolation) werden soll. Instanzvariablen die in doppelte geschweifte Klammern sind, werden evaluiert und im DOM durch deren Wert ersetzt
* Zeile 13: [Typdefinition](#c01-basic-types) für die Instanzvariable
* Zeile 16: Wert Zuweisung für die Instanzvariable "name". Wichtig ist, dass der Name der Variable genau so im Template geschrieben wird wie in der Klasse

### Lösung 2


{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
class MyApp {
  name = 'Max';
}

...
```

Erklärung:

In dieser Lösung wird "name" nicht im Konstruktor initialisiert sondern als Variable in der Klasse.
Für die Schreibweise in Lösung 2 brauchen wir weniger Code, es ist aber Geschmackssache welche von den beiden Schreibweisen man benutzt. Von der Funktionalität her sind beide gleich.
Siehe auch [TypeScript-Klassen](#c01-classes).

### Diskussion

Zur Vergleich zu Angular 1.x mit der controllerAs-Schreibweise hat sich hier kaum etwas geändert. Alles was in Angular 1.x möglich war ist auch jetzt noch möglich.
Das Beispiel ist sehr einfach gehalten. Ein Beispiel mit beide Schreibweisen und mit eine Instanzvariable vom Typ "object" gibt es in den Code-Beispielen auf Github.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/01-Displaying_Data)

### Weitere Ressourcen

* Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
* [controllerAs-Schreibweise](https://jsperts.de/blog/ng-ctrl-as-syntax/) in Angular 1.x

## Liste von Daten anzeigen

### Problem

Ich hab eine Liste von Benutzerdaten und ich möchte diese in meine View anzeigen.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Eine Liste von Daten
* Die NgFor Direktive von Angular

### Lösung

{title="main.ts", lang=js}
```
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

Zeile 3: Interface Definition für ein User-Objekt
Zeile 16: Nutzung der NgFor-Direktive um eine Liste anzuzeigen
Zeile 17: Hier nutzen wir die lokale Variable, um Informationen anzuzeigen wie wir es im Rezept [Daten einer Komponente in der View anzeigen](#c03-show-data) gemacht haben

Erklärung zu der ng-for Syntax:

Der Stern (\*) vor dem ng-for ist essentiell und ist Teil der Syntax. Er zeigt an, dass der li-Tag und alle Elemente die es beinhaltet als Template für das ng-for benutzt werden. Der Teil nach dem "of" definiert die Instanzvariable in der sich unsere Liste befindet. Die Raute (#) definiert eine lokale Variable. Diese können wir nur innerhalb des Elementes mit dem ng-for nutzen und hält eine Referenz zum aktuellen Objekt in der Array.

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen von einer Liste von Daten. Die hier ist die kürzeste und auch vermutlich die einfachste. Die restliche Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

## Auf Nutzer-Input reagieren

### Problem

Ich möchte eine Methode in meine Komponente aufrufen, wenn der Nutzer eine Browser-Event wie z. B. "klick" auslöst.

### Zutaten

* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Ein Browser-Event, wir nutzten hier "klick" als Beispiel
* Methode die Aufgerufen werden soll wenn der Nutzer auf das Element klickt

### Lösung 1

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: '<div (click)="clicked()">Click me!</div>'
})
class MyApp {
  clicked () {
    console.log('Clicked');
  }
}

...
```

Erklärung:

* __Zeile 7__: Der Name zwischen den Klammern, hier "click", signalisiert das Event auf den wir hören möchten. Nach dem Gleichheitszeichen folgt die Funktion die wir bei klick aufrufen möchten
* __Zeile 10-12__: Die Funktion die aufgerufen werden soll wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Funktion identisch sein muss zum Namen den wir im Template nutzen

### Lösung 2

{title="Ausschnitt aus einer Komponente, lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: '<div on-click="clicked()">Click me!</div>'
})
class MyApp {
  clicked () {
    console.log('Clicked');
  }
}

...
```

Erklärung:

Das ist eine alternative Schreibweise zu der Schreibweise in Lösung 1. Statt Klammern für den Event-Namen, nutzen wir hier "on-" als Präfix. Die Funktionalität bleibt dabei gleich.

### Diskussion

Die neue Schreibweise mit Klammern für Browser-Events ersetzt alle Event-Direktiven die es in Angular 1.x gibt wie z. B. ng-click, ng-keypress und ng-keydown. Wir haben im Beispiel "click" benutzt aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress" und "keydown". Allgemein ist der Namen zwischen den Klammer, der Namen des Events auf das wir reagieren möchten.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

