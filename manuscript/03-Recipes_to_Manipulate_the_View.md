# Rezepte, um mit der Anzeige zu interagieren

In diesem Kapitel geht es um die verschiedenen Möglichkeiten, die uns Angular anbietet, um Daten einer Komponente in der View anzuzeigen.
Des Weiteren zeigen wir Möglichkeiten, CSS-Klassen und Styles abhängig von den Daten, die in unserer Komponente liegen, zu ändern.
Auch das Ein- und Ausblenden von Teilen des DOMs abhängig von einer Bedingung wird hier gezeigt.
Ferner werden wir sehen, wie wir auf Nutzer-Input wie z. B. auf Klicks reagieren können.

## Daten einer Komponente in der View anzeigen {#c03-show-data}

### Problem

Ich möchte Daten, die sich in meinem TypeScript-Code befinden, in der View anzeigen, damit der Nutzer diese sehen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Dummy Daten in der Klasse der Komponente

### Lösung 1

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
export class AppComponent {
  name: string;

  constructor() {
    this.name = 'Max';
  }
}
...
```

__Erklärung__:

Um Daten anzuzeigen, müssen wir zwei Sachen machen:
Erstens müssen wir dem Angular-Template sagen, welche Variablen es anzeigen soll. Zweitens müssen wir diese Variablen in unserer Klasse als Eigenschaften definieren.
Um den Code übersichtlicher zu gestalten, nutzen wir hier für die template-Eigenschaft Backticks (`` ` ``) statt Anführungszeichen (`'`).
Das ermöglicht uns, das Template in mehrere Zeilen aufzuspalten, ohne mehrere Strings mittels Pluszeichen konkatenieren zu müssen.

* Zeile 7: Hier teilen wir Angular mit, das "name" [interpoliert](#gl-interpolation) werden soll
* Zeile 11: [Typdefinition](#c01-basic-types) der Komponenten-Eigenschaft
* Zeile 14: Wertzuweisung der name-Eigenschaft. Wichtig ist, dass der Name der Eigenschaft im Template genauso wie in der Klasse geschrieben wird

### Lösung 2

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: `
    <div>Hello World!</div>
    <div>My last name is {{lastname}}</div>
  `
})
export class AppComponent {
  lastname = 'Mustermann';
}
```

__Erklärung__:

In dieser Lösung wird "lastname" nicht im Konstruktor initialisiert, sondern in der Klasse (Zeile 11).
Siehe auch [TypeScript-Klassen](#c01-classes).

### Diskussion

Das Beispiel ist sehr einfach gehalten.
Die zweite Lösung benötigt weniger Code aber es ist Geschmackssache welche der beiden Varianten wir benutzen.
Von der Funktionalität her sind beide gleich.
Ein Beispiel mit beiden Schreibweisen gibt es im Code-Beispiel auf Github.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/01-Displaying_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/01-Displaying_Data/index.html)

### Weitere Ressourcen

* Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
* Weitere Informationen zur Interpolation und der Template-Syntax befinden sich in [Appendix-A: Template-Syntax](#appendix-a)

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

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/02-List_of_Data/index.html)

### Weitere Ressourcen

* Offizielle [NgFor](https://angular.io/docs/ts/latest/api/common/index/NgFor-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu lokalen Variablen und der Template-Syntax gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Auf Nutzer-Input reagieren {#c03-user-input}

### Problem

Ich möchte in meiner Komponente eine Methode aufrufen, wenn der Nutzer einen Browser-Event wie z. B. "click" auslöst.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Ein Browser-Event, wir nutzen hier "click" als Beispiel
* Methode, die aufgerufen werden soll, wenn der Nutzer auf das Element klickt

### Lösung 1

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: '<div (click)="clicked()">Click me</div>'
})
export class AppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

* Zeile 5: Hier findet eine Event-Bindung statt. In diesem Fall wird das click-Event gebunden
* Zeilen 8-10: Die Methode, die aufgerufen werden soll, wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Methode identisch zu dem Namen, den wir im Template nutzen, sein muss

### Lösung 2

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: '<div on-click="clicked()">Click me</div>'
})
export class AppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

Das ist eine alternative Schreibweise zu der Schreibweise in Lösung 1. Statt Klammern für den Event-Namen nutzen wir hier "on-" als Präfix. Die Funktionalität bleibt dabei jedoch gleich.

### Diskussion

Die Event-Bindung ersetzt alle Event-Direktiven, die es in Angular 1.x gibt wie z. B. "ng-click", "ng-keypress" und "ng-keydown".
Wir haben im Beispiel "click" benutzt, aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress".
Allgemein ist der Namen zwischen den Klammern der Namen des Events, auf das wir reagieren möchten. Nach dem Gleichheitszeichen kommt die Aktion, die als Reaktion zum Event ausgeführt werden soll.
Die Event-Bindung ist eine Form der [Datenbindung](#gl-data-binding).

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/03-User_Interaction/index.html)

### Weitere Ressourcen

* Weitere informationen zur Event-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)

## CSS-Klassen auf Basis von booleschen Werten setzen/entfernen {#c03-dynamic-classes}

### Problem

Ich möchte anhand eines booleschen Wertes definieren, wann eine CSS-Klasse gesetzt wird und wann nicht.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* CSS-Klassen, die gesetzt bzw. entfernt werden sollen
  * Siehe auch [Das Template der Komponente vom CSS trennen](#c07-styles)
* Eigenschaften der Komponente, die wir im Template referenzieren
* NgClass-Direktive von Angular

### Lösung 1

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: [
    `.box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
    }`,
    '.red { background-color: red; }',
    '.green { background-color: green; }'
  ],
  template: `
    <div class="box" [ngClass]="{red: box.isRed}"></div>
    <div class="box green" [ngClass]="{green: box.isGreen}"></div>
  `
})
export class AppComponent {
  box = {
    isRed: true,
    isGreen: false
  };
}
```

__Erklärung__:

* Zeilen 6-12: Definition der CSS-Klassen, die wir benötigen
* Zeilen 15-16: Zwei div-Tags mit CSS-Klassen. Initiale CSS-Klassen werden über das class-Attribut gesetzt. Dynamische CSS-Klassen werden mit Hilfe der ngClass-Eigenschaft gesetzt. Die Eigenschaft bekommt als Wert ein Objekt, dessen Keys die CSS-Klassen sind, die dynamisch hinzugefügt und entfernt werden
  * Zeile 15: Durch die [input-Eigenschaft](#gl-input-property) "ngClass" wird die CSS-Klasse "red" gesetzt, weil die isRed-Eigenschaft des box-Objektes __true__ ist
  * Zeile 16: Durch die [input-Eigenschaft](#gl-input-property) "ngClass" wird die CSS-Klasse "green" entfernt, weil die isGreen-Eigenschaft des box-Objektes __false__ ist
* Zeilen 20-23: Objekt mit booleschen Werten, die benutzt werden, um CSS-Klassen im Template hinzuzufügen bzw. zu entfernen

### Lösung 2

Wir haben bereits in Lösung 1 gesehen, dass die ngClass-Eigenschaft ein Objekt mit CSS-Klassen als Keys und __true__/__false__ als Werten bekommt.
Statt das Objekt im Template zu definieren, können wir es auch in unserer Klasse definieren.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: [
    `.box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
    }`,
    '.red { background-color: red; }'
  ],
  template: '<div [ngClass]="classes"></div>'
})
export class AppComponent {
  classes = {
    red: true,
    box: true
  };
}
```

__Erklärung__:

* Zeilen 6-11: Definition der CSS-Klassen, die wir benötigen
* Zeile 13: div-Tag mit ngClass-Eigenschaft, die auf die classes-Eigenschaft der Klasse zugreift
* Zeilen 16-19: Objekt mit CSS-Klassen als Keys und boolesche Werte die angeben, ob die CSS-Klassen gesetzt werden oder nicht

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der CSS-Klassen verzichtet.
Im Github Code-Beispiel wird gezeigt, wie wir mittels "click" die CSS-Klassen für unsere div-Tags entfernen und hinzufügen können.
Um das Code-Beispiel zu verstehen, wird zusätzlich das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" benötigt.

Wir nutzen hier eine [Datenbindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art der Datenbindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige Klasse nutzen, können wir auch eine Klassen-Bindung dafür nutzen.

I> #### CSS-Styles in einer Komponente
I>
I> Wenn wir CSS-Styles in einer Komponente definieren, können wir diese CSS-Styles standardmäßig nur in der Komponente verwenden, in der diese definiert worden sind. Dieses Verhalten kann uns vor Fehlern schützen und meidet Konflikte in CSS-Styles, wenn man z. B. Komponenten wiederverwendet. Die Kapselung von CSS-Styles und Komponenten wird in Angular "View-Encapsulation" genannt.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01/index.html)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation der [NgClass-Direktiven](https://angular.io/docs/ts/latest/api/common/index/NgClass-directive.html)
* Weitere Informationen zur Eigenschaften- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)
* Informationen zur View-Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Eine weitere Möglichkeit, CSS-Styles für eine Komponente zu definieren, gibt es im Rezept "[Komponente und CSS trennen](#c07-styleurls)"

## Teile der View konditional mit NgIf anzeigen {#c03-ngif}

### Problem

Ich möchte Teile der View nur dann anzeigen, wenn eine bestimmte Bedingung erfüllt ist.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgIf-Direktive von Angular
* Eine Eigenschaft vom Typ "boolean"

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div>Hello World!</div>
    <div *ngIf="showName">
      <p>My name is Max</p>
    </div>
  `
})
export class AppComponent {
  showName: boolean;

  constructor() {
    this.showName = true;
  }
}
```

__Erklärung__:

* Zeile 7: Nutzung der NgIf-Direktiven, um den div-Tag nur dann im DOM zu haben, wenn "showName" den Wert __true__ hat
* Zeile 13: Definition der showName-Eigenschaft mit Typ "boolean"
* Zeile 16: Standardmäßig soll die showName-Eigenschaft den Wert __true__ besitzen (div-Tag ist im DOM)

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes der showName-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" den Wert verändern können.
Dort können wir auch sehen, wie sich die View verändert, je nachdem, ob "showName" den Wert __true__ oder __false__ hat.

Es gibt noch weitere mögliche Schreibweisen für das konditionale Anzeigen von Teilen der View mittels der NgIf-Direktive.
Die hier verwendete ist die kürzeste und vermutlich die einfachste.
Weitere Schreibweisen sind im Github Code-Beispiel zu finden.
Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngIf-Syntax

Der Stern (__\*__) vor dem __ngIf__ ist essentiell und Teil der Syntax.
Er zeigt an, dass der div-Tag und alle Elemente, die der Tag beinhaltet, als Template für die Instanz der NgIf-Direktiven benutzt werden sollen.
Nach __\*ngIf=__ kommt ein Angular-Template-Ausdruck, der die Bedingung angibt.
Wenn die Evaluation des Ausdruckes __true__ zurückgibt, ist die Bedingung wahr und das Template wird angezeigt.
Andernfalls wird das Template aus dem DOM entfernt.
Wir haben hier einen sehr einfachen Ausdruck benutzt.
Wir hätten auch einen komplexeren Ausdruck nutzen können, z. B. einen, der einen Vergleich mit __===__ beinhaltet.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/05-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgIf](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf/index.html)

### Weitere Ressourcen

* Offizielle [NgIf](https://angular.io/docs/ts/latest/api/common/index/NgIf-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Template-Ausdrücken gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Teile der View konditional mit NgSwitch anzeigen

### Problem

Ich möchte unterschiedliche Teile der View anzeigen, je nach Wert eines Angular-Ausdrucks.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgSwitch-Direktive von Angular
* Die NgSwitchCase-Direktive von Angular
* Die NgSwitchDefault-Direktive von Angular

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div [ngSwitch]="color">
      <p>What color are you?</p>
      <p *ngSwitchCase="'blue'">I am blue</p>
      <p *ngSwitchCase="'red'">I am red</p>
      <p *ngSwitchDefault>Color not known</p>
    </div>
  `
})
export class AppComponent {
  color: string;

  constructor() {
    this.color = 'blue';
  }
}
```

__Erklärung__:

* Zeile 6: Nutzung der NgSwitch-Direktive mit der color-Eigenschaft der Komponente
* Zeilen 7-10: Inhalt der NgSwitch-Direktiven
  * Zeile 7: Wird immer angezeigt unabhängig vom Wert von "color"
  * Zeile 8: Wird nur dann angezeigt, wenn "color" den Wert __`'`blue`'`__ hat
  * Zeile 9: Wird nur dann angezeigt, wenn "color" den Wert __`'`red`'`__ hat
  * Zeile 10: Wird nur dann angezeigt, wenn "color" irgendeinen Wert außer __`'`blue`'`__ und __`'`red`'`__ hat
* Zeile 18: Standardmäßig ist der Wert von "color" __`'`blue`'`__

### Diskussion

Die NgSwitch-Direktive ist vergleichbar mit einer JavaScript switch-Anweisung.
Bei der Nutzung im Template erhält sie über __ngSwitch__ ([input-Eigenschaft](#gl-input-property) der NgSwitch-Direktive) einen Angular-Template-Ausdruck, der dann ausgewertet wird.
In unserem Beispiel besteht der Ausdruck aus der color-Eigenschaft.
Diese Auswertung wird dann mit jedem Ausdruck der NgSwitchWhen-Direktiven verglichen.
Angular nutzt für den Vergleich __===__.
In unserem Beispiel haben wir __`'`blue`'`__ und __`'`red`'`__ als Ausdrücke für NgSwitchCase benutzt.
Wenn der Vergleich den Wert __true__ zurück gibt, wird der Tag mit der Direktiven und dessen Inhalt angezeigt.
Wenn kein Vergleich __true__ zurück gibt, wird der Tag mit der NgSwitchDefault-Direktiven und dessen Inhalt angezeigt.
Tags, die weder eine NgSwitchCase- noch eine NgSwitchDefault-Direktive nutzen, werden immer angezeigt.

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes der color-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt, wie wir mittels "click" den Wert verändern können.
Dort können wir auch sehen, wie sich die View in Abhängigkeit des Wertes der color-Eigenschaft verändert.

Es gibt noch eine weitere mögliche Schreibweise für die NgSwitchCase- und NgSwitchDefault-Direktiven. Diese hier ist die kürzeste und vermutlich die einfachste. Die zweite Schreibweise ist im Github Code-Beispiel zu finden. Von der Funktionalität her sind beide Schreibweisen gleich.

#### Erklärung zur ngSwitchWhen- und ngSwitchDefault-Syntax

Der Stern (__\*__) vor dem __ngSwitchWhen__ und __ngSwitchDefault__ ist essentiell und Teil der Syntax.
Er zeigt an, dass die p-Tags und alle Elemente, die die Tags beinhalten, als Template für die jeweilige Instanz der NgSwitchCase- bzw. der NgSwitchDefault-Direktiven benutzt werden sollen.
Nach __\*ngSwitchCase=__ kommt ein Angular-Template-Ausdruck.
Dieser Ausdruck verglichen mit der Auswertung des NgSwitch-Ausdrucks gibt an, wann das Template angezeigt werden soll.
Wenn der Vergleich __true__ ergibt, wird das Template angezeigt.
Wenn der __false__ ergibt, wird das Template aus dem DOM entfernt.
Das NgSwitchDefault-Template wird nur dann angezeigt, wenn alle Vergleiche __false__ ergeben.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/06-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgSwitch](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgSwitch)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/06-Conditionally_Show_Parts_of_the_View_with_NgSwitch/index.html)

### Weitere Ressourcen

* Offizielle [NgSwitch](https://angular.io/docs/ts/latest/api/common/index/NgSwitch-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchCase](https://angular.io/docs/ts/latest/api/common/index/NgSwitchCase-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchDefault](https://angular.io/docs/ts/latest/api/common/index/NgSwitchDefault-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Styles eines Elements dynamisch verändern

### Problem

Ich möchte die Größe (height/width) eines Elements durch Werte in meiner Komponente definieren. Eine Änderung der Werte in der Komponente soll auch die Größe des Elements verändern.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eigenschaften in der Komponente, die wir im Template referenzieren
* NgStyle-Direktive von Angular

### Lösung 1

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div [ngStyle]="{'width': elemWidth, 'height': elemHeight}"
        style="background-color: red"></div>
  `
})
export class AppComponent {
  elemWidth: string;
  elemHeight: string;
  constructor() {
    this.elemWidth = '100px';
    this.elemHeight = '100px';
  }
}
```

__Erklärung__:

* Zeilen 6-7: div-Tag mit Styles. Statische Styles werden über das style-Attribut gesetzt. Dynamische Styles werden mit Hilfe der ngStyle-Eigenschaft, einer [input-Eigenschaft](#gl-input-property) der NgStyle-Direktive, gesetzt. Die Eigenschaft erhält als Wert ein Objekt dessen Keys die style-Eigenschaften sind, die gesetzt werden (hier width und height). Die Werte für die Styles sind in der Klasse der Komponente definiert (siehe Zeilen 14 und 15)
* Zeile 14: Der Wert für die Breite des Elements
* Zeile 15: Der Wert für die Höhe des Elements

### Lösung 2

Wir haben bereits in Lösung 1 gesehen, dass die ngStyle-Eigenschaft ein Objekt mit style-Eigenschaften als Keys und Werten für die Styles als Werte für die Keys bekommt.
Statt Werte individuell in der Klasse zu definieren, können wir auch direkt das Objekt für die ngStyle-Eigenschaft definieren.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface Dimensions {
  width: string;
  height: string;
}

@Component({
  selector: 'app-root',
  template: `
    <div [ngStyle]="dimensions" style="background-color: red"></div>
  `
})
export class AppComponent {
  dimensions: Dimensions;
  constructor() {
    this.dimensions = {
      width: '100px',
      height: '100px'
    };
  }
}
```

__Erklärung__:

* Zeile 11: div-Tag mit ngStyle-Eigenschaft, die auf die dimensions-Eigenschaft der Klasse zugreift
* Zeilen 17-20: Objekt mit style-Eigenschaften als Keys und Werten, die die Werte für die Styles definieren

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der Werte der style-Eigenschaften verzichtet.
Im Github-Code-Beispiel wird gezeigt, wie wir mittels "click" die Werte der styles-Eigenschaften verändern können.
Um das Code-Beispiel zu verstehen, wird auch das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" benötigt.

Wir nutzen hier eine [Datenbindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art der Datenbindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige styles-Eigenschaft setzen, können wir auch eine Style-Bindung dafür nutzen.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01/index.html)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation der [NgStyle-Direktiven](https://angular.io/docs/ts/latest/api/common/index/NgStyle-directive.html)
* Weitere Informationen zur Eigenschaften- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)

