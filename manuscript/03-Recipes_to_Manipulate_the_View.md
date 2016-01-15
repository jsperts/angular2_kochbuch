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
Um den Code übersichtlicher zu gestalten, nutzen wir hier Backticks (\`) für die template-Eigenschaft statt Anführungszeichen ('). Das ermöglicht uns das HTML in mehreren Zeilen aufzuspalten ohne mehrere Strings mit Hilfe von Pluszeichen konkatenieren zu müssen.

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

## Liste von Daten anzeigen {#c03-data-list}

### Problem

Ich hab eine Liste von Benutzerdaten und ich möchte diese in meine View anzeigen.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Eine Liste von Daten
* Die NgFor Direktive von Angular

### Lösung

{title="main.ts", lang=js}
```
import {Component, View} from 'angular2/core';
import {bootstrap} from 'angular2/platform/browser';

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

bootstrap(MyApp);
```

Erklärung:

Zeile 4-7: Interface Definition für ein User-Objekt
Zeile 17: Nutzung der NgFor-Direktive um eine Liste anzuzeigen
Zeile 18: Hier nutzen wir die lokale Variable, um Informationen anzuzeigen wie wir es im Rezept [Daten einer Komponente in der View anzeigen](#c03-show-data) gemacht haben

Erklärung zu der ngFor Syntax:

Der Stern (\*) vor dem ngFor ist essentiell und Teil der Syntax. Er zeigt an, dass der li-Tag und alle Elemente die es beinhaltet als Template für das ngFor benutzt werden. Der Teil nach dem "of", ist der Name der Instanzvariable die unsere Liste referenziert. Die Raute (#) definiert eine lokale Variable. Diese können wir nur innerhalb des Elementes mit dem ngFor nutzen und hält eine Referenz zum aktuellen Objekt in der Array.

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen von einer Liste von Daten. Die hier ist die kürzeste und auch vermutlich die einfachste. Die restliche Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

### Weitere Ressourcen

* Offizielle [NgFor](https://angular.io/docs/ts/latest/api/common/NgFor-directive.html) Dokumentation auf der Angular 2 Webseite

## Auf Nutzer-Input reagieren {#c03-user-input}

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

* __Zeile 7__: Der Name zwischen den Klammern, hier "click", signalisiert das Event auf das wir hören möchten. Nach dem Gleichheitszeichen folgt die Methode die wir bei klick aufrufen möchten
* __Zeile 10-12__: Die Methode die aufgerufen werden soll wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Methode identisch sein muss zum Namen den wir im Template nutzen

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

Die neue Schreibweise mit Klammern für Browser-Events ersetzt alle Event-Direktiven die es in Angular 1.x gibt wie z. B. ng-click, ng-keypress und ng-keydown. Wir haben im Beispiel "click" benutzt aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress" und "keydown". Allgemein ist der Namen zwischen den Klammer, der Namen des Events auf das wir reagieren möchten. Nach dem Gleichheitszeichen kommt die Aktion die als Reaktion zum Event ausgeführt werden soll. Wir haben ein Methodenaufruf als Aktion definiert, man kann aber auch andere Aktionen definieren wie z. B. die Zuweisung eines Wertes an einer Variablen. Die Klammern definieren eine sogenannte ["Daten-Bindung"](#gl-data-binding). In diesem Fall ist es eine einweg-Bindung da die Daten nur aus der View in unser Klasse fließen.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

### Weitere Ressourcen

* Die Angular 2 Dokumentation gibt mehr Informationen über [Event-Bindings](https://angular.io/docs/ts/latest/guide/template-syntax.html#event-binding)

## CSS-Klassen auf Basis von booleschen Werten setzen/entfernen

### Problem

Ich möchte anhand eines booleschen Wertes definieren wann eine CSS-Klasse gesetzt wird und wann nicht.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* CSS-Klassen die gesetzt bzw. entfernt werden sollen
* NgClass-Direktive von Angular

### Lösung 1

{title="main.ts", lang=js}
```
import {Component, View} from 'angular2/core';
import {bootstrap} from 'angular2/platform/browser';

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <style>
      .box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
      }
      .red {
        background-color: red;
      }
      .green {
        background-color: green;
      }
    </style>
    <div class="box" [ngClass]="{red: box.isRed}"></div>
    <div class="box green" [ngClass]="{green: box.isGreen}"></div>
  `
})
class MyApp {
  box = {
    isRed: true,
    isGreen: false
  };
  constructor() {}
}

bootstrap(MyApp);
```

Erklärung:

* Zeile 9-21: Definition der CSS-Klassen die wir benötigen
* Zeile 22-23: Zwei divs mit CSS-Klassen. Initiale CSS-Klassen werden über das class-Attribut gesetzt. Dynamische CSS-Klassen werden mit der ngClass-Eigenschaft gesetzt. Die Keys im ngClass-Objekt sind die CSS-Klassen die entfernt/hinzugefügt werden
  * Zeile 22: Durch ngClass wird die CSS-Klasse "red" gesetzt. Die isRed-Eigenschaft des box-Objektes ist __true__
  * Zeile 23: Durch ngClass wird die CSS-Klasse "green" entfernt. Die isGreen-Eigenschaft des box-Objektes ist __false__
* Zeile 27-30: Objekt mit boolesche Werte die benutzt werden, um CSS-Klassen im Template hinzuzufügen bzw. zu entfernen

### Lösung 2

Wir haben schon in Lösung 1 gesehen, dass die ngClass-Eigenschaft ein Objekt bekommt mit CSS-Klassen als Keys und true/false als Werte für die Keys. Statt das Objekt im Template zu definieren, können wir es auch in unsere Klasse definieren.

{title="Ausschnitt aus der main.ts", lang=js}
```
...

@View({
  template: `
    <style>
      .box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
      }
      .red {
        background-color: red;
      }
    </style>
    <div [ngClass]="classes"></div>
  `
})
class MyApp {
  classes = {
    red: true
    box: true
  };
  constructor() {}
}

bootstrap(MyApp);
```

Erklärung:

* Zeile 5-14: Definition der CSS-Klassen die wir benötigen
* Zeile 15: Div mit ngClass-Eigenschaft die auf das classes-Objekt in unsere Klasse zugreift
* Zeile 19-22: Objekt mit CSS-Klassen als Keys und boolesche Werte die angeben, ob die CSS-Klasse gesetzt wird oder nicht

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der CSS-Klassen verzichtet. Im Github Code-Beispiel wird gezeigt wie man mittels "click" die CSS-Klassen für unsere divs entfernen und hinzufügen kann. Um das Code-Beispiel zu verstehen wird das Rezept [Auf Nutzer-Input reagieren](#c03-user-input) auch gebraucht.

Wir haben hier eine neue Schreibweise für Templates gesehen und zwar [Daten-Bindung](#gl-data-binding) mit eckigen Klammern ([...]). Die werden in der Regel benutzt um Eigenschaften von Komponenten, Direktiven und DOM-Elementen zu setzen. Eckige Klammern bilden eine einweg-Bindung wo die Daten von der Klasse in die View fließen. Was sich zwischen den eckigen Klammern befindet ist der Namen der Eigenschaft die wir verändern möchten. Auf der rechte Seite des Gleichheitszeichens befindet sich ein Template-Ausdruck der evaluiert wird und dann als Wert der Eigenschaft gesetzt wird.

I> #### HTML-Attribute vs. DOM-Eigenschaften
I>
I> In Angular werden Attribute benutzt um initiale Werten zu setzen. DOM-Eigenschaften werden für Werte benutzt die sich nach dem Initialisieren ändern können. In der erste Lösung haben wir das class-Attribut genutzt um CSS-Klassen bei der Initialisierung zu setzen und die ngClass-Eigenschaft der ngClass-Direktiven um CSS-Klassen zu manipulieren.

I> #### Inline-styles
I>
I> Wenn wir inline-styles in einer Komponente nutzen, können die definierte CSS-Klassen standardmäßig nur in dieser Komponente benutzt werden in der sie definiert wurden sind. Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in CSS-Klassen, wenn man Komponente wiederverwendet. Die Kapselung von CSS-Klassen und Komponenten wird in Angular _View Encapsulation_ genannt.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01)

Code auf Github für die die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02)

### Weitere Ressourcen

* Offizielle Dokumentation für die [NgClass-Direktive](https://angular.io/docs/ts/latest/api/common/NgClass-directive.html)
* Die Angular 2 Dokumentation gibt mehr Informationen über das [Binden von Eigenschaften](https://angular.io/docs/ts/latest/guide/template-syntax.html#property-binding)
