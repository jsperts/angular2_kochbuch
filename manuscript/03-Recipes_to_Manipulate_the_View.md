# Rezepte, um mit der Anzeige zu interagieren

In diesem Kapitel geht es um die verschiedene Möglichkeiten die uns Angular anbietet, um Daten einer Komponente in der View anzuzeigen.
Des Weiteren zeigen wir Möglichkeiten um CSS-Klassen und Styles zu ändern abhängig von den Daten die wir in unsere Komponente haben.
Auch das Ein- und Ausblenden von Teilen des DOMs abhängig von einer Kondition, wird hier gezeigt.
Ferner werden wir sehen wie wir auf Nutzer-Input wie z. B. auf Klicks reagieren können.

## Daten einer Komponente in der View anzeigen {#c03-show-data}

### Problem

Ich möchte Daten, die sich in meinem TypeScript-Code befinden in der View anzeigen, damit der Nutzer diese sehen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Dummy Daten in der Klasse der Komponente

### Lösung 1

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
export class DemoAppComponent {
  name: string;

  constructor() {
    this.name = 'Max';
  }
}
...
```

__Erklärung__:

Um Daten anzuzeigen, müssen wir zwei Sachen machen.
Erstens müssen wir dem Angular-Template sagen welche Variablen es anzeigen soll und zweitens müssen wir diese Variablen in unsere Klasse als Eigenschaften definieren.
Um den Code übersichtlicher zu gestalten, nutzen wir hier Backticks (`` ` ``) für die template-Eigenschaft statt Anführungszeichen (`'`).
Das ermöglicht uns das Template in mehreren Zeilen aufzuspalten ohne mehrere Strings mit Hilfe von Pluszeichen konkatenieren zu müssen.

* Zeile 7: Hier sagen wir Angular das "name" [interpoliert](#gl-interpolation) werden soll
* Zeile 11: [Typdefinition](#c01-basic-types) für die Komponenten-Eigenschaft
* Zeile 14: Wert Zuweisung für die name-Eigenschaft. Wichtig ist, dass der Name der Eigenschaft genau so im Template geschrieben wird wie in der Klasse

### Lösung 2

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: `
    <div>Hello World!</div>
    <div>My last name is {{lastname}}</div>
  `
})
export class DemoAppComponent {
  lastname = 'Mustermann';
}
```

__Erklärung__:

In dieser Lösung wird "lastname" nicht im Konstruktor initialisiert, sondern in der Klasse (Zeile 11).
Siehe auch [TypeScript-Klassen](#c01-classes).

### Diskussion

Das Beispiel ist sehr einfach gehalten.
Die zweite Lösung braucht weniger Code aber es ist Geschmackssache welche von den beiden Varianten wir benutzen.
Von der Funktionalität her sind beide gleich.
Ein Beispiel mit beide Schreibweisen gibt es im Code-Beispiel auf Github.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/01-Displaying_Data)

### Weitere Ressourcen

* Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
* Weitere Informationen zu Interpolation und der Template-Syntax, befinden sich im [Appendix-A: Template-Syntax](#appendix-a)

## Liste von Daten anzeigen {#c03-data-list}

### Problem

Ich hab eine Liste von Benutzerdaten und ich möchte diese in meine View anzeigen.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Eine Liste von Daten
* Die NgFor-Direktive von Angular

### Lösung

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface IUser {
  firstname: string,
  lastname: string
}

const users: Array<IUser> = [{firstname: 'Max', lastname: 'Mustermann'}, {firstname: 'John', lastname: 'Doe'}];

@Component({
  selector: 'demo-app',
  template: `
    <ul>
      <li *ngFor="let user of users">
        Name: {{user.firstname}} {{user.lastname}}
      </li>
    </ul>
  `
})
export class DemoAppComponent {
  users: Array<IUser>;

  constructor() {
    this.users = users;
  }
}
```

__Erklärung__:

* Zeilen 3-6: Interface Definition für ein User-Objekt
* Zeile 14: Nutzung der NgFor-Direktive, um eine Liste anzuzeigen
* Zeile 15: Hier nutzen wir die lokale Variable "user", um Informationen anzuzeigen wie wir es im Rezept "[Daten einer Komponente in der View anzeigen](#c03-show-data)" getan haben

### Diskussion

Es gibt noch weitere mögliche Schreibweisen für das Anzeigen von einer Liste von Daten.
Die hier ist die kürzeste und auch vermutlich die einfachste.
Die restlichen Varianten sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngFor-Syntax:

Der Stern (__\*__) vor dem __ngFor__ ist essentiell und Teil der Syntax.
Er zeigt an, dass der li-Tag und alle Elemente, die der Tag beinhaltet, als Template für die Instanz der NgFor-Direktive benutzt werden sollen.
Der Teil nach dem __of__, ist der Name der Komponenten-Eigenschaft die unsere Liste referenziert.
Das Keyword __let__  definiert eine lokale Variable für die Instanz der NgFor-Direktive.
Diese können wir nur innerhalb des Elementes mit dem ngFor nutzen und hält eine Referenz zum aktuellen Objekt in der Array.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/02-List\_of\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/02-List_of_Data)

### Weitere Ressourcen

* Offizielle [NgFor](https://angular.io/docs/ts/latest/api/common/NgFor-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu lokalen Variablen und der Template-Syntax gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Auf Nutzer-Input reagieren {#c03-user-input}

### Problem

Ich möchte eine Methode in meine Komponente aufrufen, wenn der Nutzer eine Browser-Event wie z. B. "click" auslöst.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Ein Browser-Event, wir nutzten hier "click" als Beispiel
* Methode die aufgerufen werden soll, wenn der Nutzer auf das Element klickt

### Lösung 1

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: '<div (click)="clicked()">Click me</div>'
})
export class DemoAppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

* Zeile 5: Hier findet eine Event-Bindung statt. In diesem Fall wird das click-Event gebunden
* Zeilen 8-10: Die Methode die aufgerufen werden soll, wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Methode identisch sein muss zum Namen den wir im Template nutzen

### Lösung 2

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: '<div on-click="clicked()">Click me</div>'
})
export class DemoAppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

Das ist eine alternative Schreibweise zu der Schreibweise in Lösung 1. Statt Klammern für den Event-Namen, nutzen wir hier "on-" als Präfix. Die Funktionalität bleibt dabei gleich.

### Diskussion

Die Event-Bindung ersetzt alle Event-Direktiven, die es in Angular 1.x gibt wie z. B. "ng-click", "ng-keypress" und "ng-keydown".
Wir haben im Beispiel "click" benutzt aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress".
Allgemein ist der Namen zwischen den Klammern, der Namen des Events auf das wir reagieren möchten. Nach dem Gleichheitszeichen kommt die Aktion die als Reaktion zum Event ausgeführt werden soll.
Die Event-Bindung ist eine Form der [Daten-Bindung](#gl-data-binding).

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

### Weitere Ressourcen

* Weitere informationen zur Event-Bindung gibt es im [Appendix A: Template-Syntax](#appendix-a)

## CSS-Klassen auf Basis von booleschen Werten setzen/entfernen {#c03-dynamic-classes}

### Problem

Ich möchte anhand eines booleschen Wertes definieren, wann eine CSS-Klasse gesetzt wird und, wann nicht.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* CSS-Klassen die gesetzt bzw. entfernt werden sollen
  * Siehe auch [Das Template der Komponente vom CSS trennen](#c07-styles)
* Eigenschaften in der Komponente, die wir im Template referenzieren
* NgClass-Direktive von Angular

### Lösung 1

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
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
export class DemoAppComponent {
  box = {
    isRed: true,
    isGreen: false
  };
}
```

__Erklärung__:

* Zeilen 6-12: Definition der CSS-Klassen die wir benötigen
* Zeilen 15-16: Zwei div-Tags mit CSS-Klassen. Initiale CSS-Klassen werden über das class-Attribut gesetzt. Dynamische CSS-Klassen werden mit Hilfe der ngClass-Eigenschaft gesetzt. Die Eigenschaft bekommt als Wert ein Objekt dessen Keys die CSS-Klassen sind die entfernt/hinzugefügt werden
  * Zeile 15: Durch die [input-Eigenschaft](#gl-input-property) "ngClass" wird die CSS-Klasse "red" gesetzt. Die isRed-Eigenschaft des box-Objektes ist __true__
  * Zeile 16: Durch die [input-Eigenschaft](#gl-input-property) "ngClass" wird die CSS-Klasse "green" entfernt. Die isGreen-Eigenschaft des box-Objektes ist __false__
* Zeilen 20-23: Objekt mit boolesche Werte die benutzt werden, um CSS-Klassen im Template hinzuzufügen bzw. zu entfernen

### Lösung 2

Wir haben bereits in Lösung 1 gesehen, dass die ngClass-Eigenschaft ein Objekt mit CSS-Klassen als Keys und __true__/__false__ als Werte für die Keys bekommt.
Statt das Objekt im Template zu definieren, können wir es auch in unsere Klasse definieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
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
export class DemoAppComponent {
  classes = {
    red: true,
    box: true
  };
}
```

__Erklärung__:

* Zeilen 6-11: Definition der CSS-Klassen die wir benötigen
* Zeile 13: div-Tag mit ngClass-Eigenschaft, die auf die classes-Eigenschaft der Klasse zugreift
* Zeilen 16-19: Objekt mit CSS-Klassen als Keys und boolesche Werte die angeben, ob die CSS-Klasse gesetzt wird oder nicht

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der CSS-Klassen verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" die CSS-Klassen für unsere div-Tags entfernen und hinzufügen können.
Um das Code-Beispiel zu verstehen wird das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" auch benötigt.

Wir nutzen hier eine [Daten-Bindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art der Daten-Bindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige Klasse nutzen, können wir auch eine Klassen-Bindung dafür nutzen.

I> #### CSS-Styles in einer Komponente
I>
I> Wenn wir CSS-Styles in einer Komponente definieren, können wir diese CSS-Styles standardmäßig nur in der Komponente verwenden in der diese definiert worden sind. Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in CSS-Styles, wenn man z. B. Komponente wiederverwendet. Die Kapselung von CSS-Styles und Komponenten wird in Angular "View Encapsulation" genannt.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01/index.html)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation für die [NgClass-Direktive](https://angular.io/docs/ts/latest/api/common/NgClass-directive.html)
* Weitere Informationen zu Eigenschafts- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)
* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Eine weitere Möglichkeit, um CSS-Styles für eine Komponente zu definieren gibt es im Rezept "[Komponente und CSS trennen](#c07-styleurls)"

## Teile der View konditional mit NgIf anzeigen {#c03-ngif}

### Problem

Ich möchte Teile der View nur dann anzeigen, wenn eine bestimmte Kondition erfüllt ist.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgIf-Direktive von Angular
* Eine Eigenschaft vom Typ "boolean"

### Lösung

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <div>Hello World!</div>
    <div *ngIf="showName">
      <p>My name is Max</p>
    </div>
  `
})
export class DemoAppComponent {
  showName: boolean;

  constructor() {
    this.showName = true;
  }
}
```

__Erklärung__:

* Zeile 7: Nutzung der NgIf-Direktive, um den div-Tag nur dann im DOM zu haben, wenn "showName" den Wert __true__ hat
* Zeile 13: Definition der showName-Eigenschaft mit Typ "boolean"
* Zeile 16: Standardmäßig soll die showName-Eigenschaft den Wert __true__ haben (div-Tag ist im DOM)

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes für die showName-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" den Wert verändern können.
Da können wir auch sehen, wie sich die View verändert je nachdem, ob "showName" den Wert __true__ oder __false__ hat.

Es gibt noch weiter mögliche Schreibweisen für das konditionale Anzeigen Teile der View mittels der NgIf-Direktive.
Die hier ist die kürzeste und vermutlich die einfachste.
Weitere Schreibweisen sind im Github Code-Beispiel zu finden.
Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngIf-Syntax

Der Stern (__\*__) vor dem __ngIf__ ist essentiell und Teil der Syntax.
Er zeigt an, dass der div-Tag und alle Elemente, die der Tag beinhaltet, als Template für die Instanz der NgIf-Direktive benutzt werden sollen.
Nach __\*ngIf=__ kommt ein Angular-Template-Ausdruck, der die Kondition angibt.
Wenn die Evaluation des Ausdruckes __true__ zurückgibt, ist die Kondition wahr und das Template wird angezeigt.
Andernfalls wird das Template aus dem DOM entfernt.
Wir haben hier einen sehr einfachen Ausdruck benutzt.
Wir hätten auch einen komplexeren Ausdruck nutzen können z. B. einen der ein Vergleich mit __===__ beinhaltet.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/05-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgIf](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf/index.html)

### Weitere Ressourcen

* Offizielle [NgIf](https://angular.io/docs/ts/latest/api/common/NgIf-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Teile der View konditional mit NgSwitch anzeigen

### Problem

Ich möchte unterschiedliche Teile der View anzeigen je nach Wert eines Angular-Ausdrucks.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgSwitch-Direktive von Angular
* Die NgSwitchWhen-Direktive von Angular
* Die NgSwitchDefault-Direktive von Angular

### Lösung

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <div [ngSwitch]="color">
      <p>What color are you?</p>
      <p *ngSwitchWhen="'blue'">I am blue</p>
      <p *ngSwitchWhen="'red'">I am red</p>
      <p *ngSwitchDefault>Color not known</p>
    </div>
  `
})
export class DemoAppComponent {
  color:string;

  constructor() {
    this.color = 'blue';
  }
}
```

__Erklärung__:

* Zeile 6: Nutzung der NgSwitch-Direktive mit der color-Eigenschaft der Komponente
* Zeilen 7-10: Inhalt der NgSwitch-Direktive
  * Zeile 7: Wird immer angezeigt egal was der Wert von "color" ist
  * Zeile 8: Wird nur dann angezeigt, wenn "color" den Wert __`'`blue`'`__ hat
  * Zeile 9: Wird nur dann angezeigt, wenn "color" den Wert __`'`red`'`__ hat
  * Zeile 10: Wird nur dann angezeigt, wenn "color" irgend ein Wert außer __`'`blue`'`__ und __`'`red`'`__ hat
* Zeile 18: Standardmäßig ist der Wert von "color" __`'`blue`'`__

### Diskussion

Die NgSwitch-Direktive ist vergleichbar mit eine JavaScript switch-Anweisung.
Bei der Nutzung im Template bekommt sie über __ngSwitch__ ([input-Eigenschaft](#gl-input-property) der NgSwitch-Direktive) einen Angular-Template-Ausdruck der dann ausgewertet wird.
In unserem Beispiel besteht der Ausdruck aus der color-Eigenschaft.
Diese Auswertung wird dann mit jedem Ausdruck der NgSwitchWhen-Direktiven verglichen.
Angular nutzt für den Vergleich __===__.
In unserem Beispiel haben wir __`'`blue`'`__ und __`'`red`'`__ als Ausdrücke für NgSwitchWhen benutzt.
Wenn der Vergleich den Wert __true__ zurück gibt, wird der Tag mit der Direktive und dessen Inhalt angezeigt.
Wenn kein Vergleich __true__ zurück gibt, wird der Tag mit der NgSwitchDefault-Direktive und dessen Inhalt angezeigt.
Tags die weder eine NgSwitchWhen- noch eine NgSwitchDefault-Direktive nutzen werden immer angezeigt.

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes für die color-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" den Wert verändern können.
Da können wir auch sehen wie sich die View verändert je nachdem, was für ein Wert die color-Eigenschaft hat.

Es gibt noch eine weitere mögliche Schreibweise für die NgSwitchWhen- und NgSwitchDefault-Direktiven. Die hier ist die kürzeste und vermutlich die einfachste. Die zweite Schreibweise ist im Github Code-Beispiel zu finden. Von der Funktionalität her sind beide Schreibweisen gleich.

#### Erklärung zu der ngSwitchWhen- und ngSwitchDefault-Syntax

Der Stern (__\*__) vor dem __ngSwitchWhen__ und __ngSwitchDefault__ ist essentiell und Teil der Syntax.
Er zeigt an, dass die p-Tags und alle Elemente, die die Tags beinhalten, als Template für die jeweilige Instanz der NgSwitchWhen bzw. der NgSwitchDefault-Direktiven benutzt werden sollen.
Nach __\*ngSwitchWhen=__ kommt ein Angular-Template-Ausdruck.
Dieser Ausdruck verglichen mit der Auswertung des NgSwitch-Ausdruckes gibt an, wann das Template angezeigt werden soll.
Wenn der Vergleich __true__ ergibt, wird das Template angezeigt.
Wenn der __false__ ergibt, wird das Template aus dem DOM entfernt.
Das NgSwitchDefault-Template wird nur dann angezeigt, wenn alle Vergleiche __false__ ergeben.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/06-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgSwitch](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgSwitch)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/06-Conditionally_Show_Parts_of_the_View_with_NgSwitch/index.html)

### Weitere Ressourcen

* Offizielle [NgSwitch](https://angular.io/docs/ts/latest/api/common/NgSwitch-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchWhen](https://angular.io/docs/ts/latest/api/common/NgSwitchWhen-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchDefault](https://angular.io/docs/ts/latest/api/common/NgSwitchDefault-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Styles eines Elementes dynamisch verändern

### Problem

Ich möchte die Größe (height/width) eines Elementes als Werte in meine Komponente definieren. Eine Änderung der Werte in der Komponente soll auch die Größe des Elements verändern.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eigenschaften in der Komponente, die wir im Template referenzieren
* NgStyle-Direktive von Angular

### Lösung 1

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <div [ngStyle]="{'width': elemWidth, 'height': elemHeight}" style="background-color: red"></div>
  `
})
export class DemoAppComponent {
  elemWidth: string;
  elemHeight: string;
  constructor() {
    this.elemWidth = '100px';
    this.elemHeight = '100px';
  }
}
```

__Erklärung__:

* Zeile 6: div-Tag mit Styles. Statische Styles werden über das style-Attribut gesetzt. Dynamische Styles werden mit Hilfe der ngStyle-Eigenschaft, eine [input-Eigenschaft](#gl-input-property) der NgStyle-Direktive, gesetzt. Die Eigenschaft bekommt als Wert ein Objekt dessen Keys die style-Eigenschaften sind die gesetzt werden (hier width und height). Die Werte für die Styles sind in der Klasse der Komponente definiert (siehe Zeilen 13 und 14)
* Zeile 13: Der Wert für die Breite des Elements
* Zeile 14: Der Wert für die Höhe des Elements

### Lösung 2

Wir haben bereits in Lösung 1 gesehen, dass die ngStyle-Eigenschaft ein Objekt mit style-Eigenschaften als Keys und Werte für die Styles als Werte für die Keys bekommt.
Statt Werte individuell in der Klasse zu definieren, können wir auch direkt das Objekt für die ngStyle-Eigenschaft definieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface IDimensions {
  width: string;
  height: string
}

@Component({
  selector: 'demo-app',
  template: `
    <div [ngStyle]="dimensions" style="background-color: red"></div>
  `
})
export class DemoAppComponent {
  dimensions: IDimensions;
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
* Zeilen 17-20: Objekt mit style-Eigenschaften als Keys und Werte, die die Werte für die Styles definieren die gesetzt werden sollen

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der Werte für die style-Eigenschaften verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" die Werte für die styles-Eigenschaften verändern können.
Um das Code-Beispiel zu verstehen wird das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" auch benötigt.

Wir nutzen hier eine [Daten-Bindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art der Daten-Bindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige styles-Eigenschaft setzen, können wir auch eine Style-Bindung dafür nutzen.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01/index.html)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation für die [NgStyle-Direktive](https://angular.io/docs/ts/latest/api/common/NgStyle-directive.html)
* Weitere Informationen zu Eigenschafts- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)

