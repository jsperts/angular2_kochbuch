# Rezepte für Komponenten

In diesem Kapitel befinden sich verschiedene Rezepte, die hauptsächlich Komponenten betreffen.
Manche der Rezepte können auch bei Direktiven angewendet werden.
Sachen, wie z. B. die Kommunikation zwischen Komponenten, werden in diesem Kapitel behandelt.

## Komponente und HTML-Template trennen {#c07-split-html-template}

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meiner Komponente halten.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das HTML. Hier app.component.html

### Lösung

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
})

...
```

__Erklärung__:

* Zeile 5: Statt der template-Eigenschaft, die wir in anderen Rezepten benutzt haben, nutzen wir jetzt die templateUrl-Eigenschaft. Der angegebene Pfad ist relativ zu der app.component.ts-Datei

### Diskussion

Wichtig zu beachten ist, dass wir nur entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können.
Beide gleichzeitig gehen nicht.
Da wir in diesem Buch angular-cli mit Webpack nutzen wird die Zeile 5 oben beim Kompilieren durch `template: require('./app.component.html')` ersetzt und Angular wird sich zur Laufzeit so verhalten als ob wir selbst das Template in der Komponente geschrieben haben.
Falls andere Build-Tools benutzt werden, die die templateUrl-Eigenschaft nicht ersetzen, wird zur Laufzeit die Datei von Angular mittels XMLHttpRequest vom Server geholt und der Inhalt der Datei kompiliert und in das DOM gesetzt.
Im allgemeinen ist es Toolabhängig, ob wir einen relativen Pfaden angeben können und wie dieser genau aussieht.
Wer mehr über relative Pfade für Templates erfahren möchte, kann den Artikel [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html) lesen.

#### templateUrl- vs. template-Eigenschaft

Beide Ansätze haben Vor- und Nachteile.
Wir werden uns diese kurz anschauen.

__templateUrl-Eigenschaft__

| Vorteile                  | Nachteile                              |
|---------------------------|----------------------------------------|
| Übersichtlicher           | Extra Server-Aufruf                    |
|                           | (Gilt in unserem Fall nicht)           |
|---------------------------|----------------------------------------|
| Logik und Markup sind     | Zwei offene Dateien                    |
| getrennt                  | um eine Komponente zu implementieren   |
|---------------------------|----------------------------------------|
| Code-Highlighting         | Wie genau der Pfad aussieht ist        |
|                           | Toolabhängig                           |
|---------------------------|----------------------------------------|
| Auto-Vervollständigung    |                                        |

__template-Eigenschaft__

| Vorteile                     | Nachteile                        |
|------------------------------|----------------------------------|
| Die gesamte Komponente wird  | Unübersichtlich, wenn wir viel   |
| in einer Datei definiert     | HTML haben                       |
|------------------------------|----------------------------------|
| Kein extra Server-Aufruf     | Codehighlighting und             |
|                              | Autovervollständigung sind       |
|                              | editorabhängig                   |
|------------------------------|----------------------------------|
| Keine Probleme mit Pfaden    |                                  |

Ich persönlich versuche immer kleine Komponenten mit wenig HTML (10-15 Zeilen) zu schreiben und nutze dabei die template-Eigenschaft.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/01-Separation_of_Component_and_Template/index.html)

## Das Template der Komponente vom CSS trennen {#c07-styles}

### Problem

Ich möchte meine CSS-Styles getrennt von meinem Template und nicht in einem style-Tag im Template halten.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* CSS-Klassen, die im Template verwendet werden

### Lösung

Statt die CSS-Klassen im Template zu halten, können wir die styles-Eigenschaft der Komponente nutzen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: [
    '.box {width: 100px; height: 100px; background-color: red; margin: 10px}',
    '.box-blue {background-color: blue;}'
  ],
  template: `
    <div class="box"></div>
    <div class="box"></div>
    <div class="box box-blue"></div>
    <div class="box"></div>
  `
})
export class AppComponent {}
```

__Erklärung__:

* Zeilen 5-8: CSS-Styles für unsere Komponente

### Diskussion

Die styles-Eigenschaft einer Komponente erwartet ein Array von Strings.
Ein String kann CSS-Styles für eine oder mehrere Klassen, Tags, etc. beinhalten.
Jeder String wird dann zur Laufzeit als style-Tag in den DOM gesetzt.
In unserem Beispiel werden zwei style-Tags im Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierten CSS-Styles standardmäßig nur in der Komponente verwendet werden, in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns vor Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View-Encapsulation" genannt.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/02-Separation_of_Template_and_Styles)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/02-Separation_of_Template_and_Styles/index.html)

### Weitere Ressourcen

* Informationen zur View-Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styleUrls-Eigenschaft benutzt wird, wird im Rezept "[Komponente und CSS trennen](#c07-styleurls)" gezeigt

## Komponente und CSS trennen {#c07-styleurls}

### Problem

Ich hab viele CSS-Klassen und ich möchte diese nicht in der Komponente halten, sondern in einer separaten CSS-Datei.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das CSS. Hier: app.component.css

### Lösung

In der ersten Lösung hatten wir den Pfad relativ zur index.html-Datei angegeben.
Es gibt auch die Möglichkeit, den Pfad relativ zur app.component.ts-Datei zu definieren.

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  styleUrls: ['./app.component.ts'],
  template: `
    <div class="box"></div>
    <div class="box"></div>
    <div class="box box-blue"></div>
    <div class="box"></div>
  `
})

...
```

__Erklärung__:

* Zeile 5: Statt der styles-Eigenschaft, die wir in anderen Rezepten benutzt haben, nutzen wir jetzt die styleUrls-Eigenschaft. Der angegebene Pfad ist relativ zu der app.component.ts-Datei

### Diskussion

Die styleUrls-Eigenschaft einer Komponente erwartet ein Array von Strings.
Da wir in diesem Buch angular-cli mit Webpack nutzen wird die Zeile 5 oben beim Kompilieren durch `styles: [require('./app.component.css')]` ersetzt und Angular wird sich zur Laufzeit so verhalten als ob wir selbst die Styles in der Komponente geschrieben haben.
Falls andere Build-Tools benutzt werden, die die styleUrls-Eigenschaft nicht ersetzen, wird zur Laufzeit die Datei von Angular mittels XMLHttpRequest vom Server geholt und der Inhalt der Datei wird als style-Tag in das DOM gesetzt.
Im allgemeinen ist es Toolabhängig, ob wir einen relativen Pfaden angeben können und wie dieser genau aussieht.
Wer mehr über relative Pfade für Styles erfahren möchte, kann den Artikel [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html) lesen.

Wenn wir in Komponenten CSS-Styles definieren, können die definierten CSS-Styles standardmäßig nur in der Komponente verwendet werden, in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft der Komponente oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns vor Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View-Encapsulation" genannt.

Die Diskussion styles- vs. stuleUrls-Eigenschaft ist analog zur template- vs. templateUrl-Eigenschaft Diskussion in [Komponente und HTML-Template trennen](#c07-split-html-template).

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/03-Separation_of_Component_and_Styles/index.html)

### Weitere Ressourcen

* Informationen zur View-Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styles-Eigenschaft benutzt wird, wird im Rezept "[Das Template der Komponente vom CSS trennen](#c07-styles)" gezeigt

## Daten an eine Unterkomponente mittels input-Eigenschaft übergeben

### Problem

Ich möchte Daten, die sich in der Überkomponente befinden, an eine Unterkomponente übergeben.

### Zutaten

* Eine [Komponente](#c02-component-definition)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Input-Decorator (@Input)

### Lösung

Wir werden uns als Erstes die Überkomponente (Parent) und als Zweites die Unterkomponente (Child) anschauen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <p>Parent Data: {{parentData}}</p>
    <app-second [childData]="parentData"></app-second>
  `
})
export class AppComponent {
  parentData: string = 'Hello World!';
}
```

__Erklärung__:

* Zeile 7: Hier nutzen wir eine Eigenschaft-Bindung, um den Wert der parentData-Eigenschaft an die childData-Eigenschaft der Unterkomponente zu übergeben

{title="second.component.ts", lang=js}
```
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-second',
  template: '<p>Child Data: {{childData}}</p>'
})
export class SecondComponent {
  @Input() childData: string;
}
```

__Erklärung__:

* Zeile 8: Mit Hilfe des Input-Decorators (@Input) definieren wir die childData-Eigenschaft als input-Eigenschaft. Zu beachten ist, dass die input-Eigenschaft den gleichen Namen wie der Name zwischen den eckigen Klammern in der app.component.ts Zeile 8 haben muss

### Diskussion

Änderungen in der parentData-Eigenschaft werden zur Laufzeit in die childData-Eigenschaft propagiert.
Wir müssen also nichts tun, wenn sich z. B. durch Nutzer-Interaktion der Wert der parentData-Eigenschaft ändert.
Wenn wir einen neuen Wert für die childData-Eigenschaft setzen, wird dieser Wert in der Parent-Component nicht sichtbar sein.
Wir haben also hier eine Einweg-Datenbindung zwischen Parent- und Child-Component.
Allerdings müssen wir aufpassen, wenn wir mit Objekten arbeiten.
Falls die parentData-Eigenschaft ein Objekt ist und wir eine Eigenschaft dieses Objekts in der Child-Component ändern, ist die Änderung auch in der Parent-Component sichtbar.
Der Grund dafür ist, dass Angular keine Kopie des Objekts erstellt, sondern die Referenz weitergibt.
Wir haben für dieses Rezept zwei Beispielanwendungen auf Github.
Der Code im Solution-Verzeichnis ist dieser, den wir hier gezeigt haben.
Das Demo-Verzeichnis beinhaltet eine Anwendung, die demonstrieren soll, welche Datenänderungen wo sichtbar sind.

I> #### Unterschiedliche Namen für die input-Eigenschaft in Parent und Child
I>
I> Angular erlaubt es uns, zwei Namen für eine input-Eigenschaft zu definieren, indem wir beim Aufruf des Input-Decorators einen Parameter übergeben, z. B. `@Input('externalName') internalName: string`. In diesem Beispiel wird "externalName" in der Parent-Component und "internalName" in der Child-Component verwendet. Wenn der Input-Decorator keinen Parameter erhält, wird in der Parent- und der Child-Component der selbe Name benutzt.

### Code

Code auf Github für [die Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Solution)

Code auf Github für [die Demonstration](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Demo)

Live Demo (Code aus dem Demo-Verzeichnis) auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Demo/index.html).

## Daten an die Überkomponente mittels output-Eigenschaft übergeben

### Problem

Ich möchte Daten, die sich in einer Unterkomponente befinden, an die Überkomponente übergeben.

### Zutaten

* Eine [Komponente](#c02-component-definition)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* [Auf Nutzer-Input reagieren](#c03-user-input)
* Output-Decorator (@Output)

### Lösung

Wir werden uns als Erstes die Überkomponente (Parent) und als Zweites die Unterkomponente (Child) anschauen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <h1>Parent</h1>
    <p>Parent Data: {{parentData}}</p>
    <app-second (dataChange)="onDataChange($event)"></app-second>
  `
})
export class AppComponent {
  parentData: string = 'Initial Data';

  onDataChange(data) {
    this.parentData = data;
  }
}
```

__Erklärung__:

* Zeile 8: Die Syntax mit den Klammern für eine Event-Bindung kennen wir schon. Nur nutzen wir hier keinen Browser-Event, sondern einen Event, den wir in der Child-Component definiert haben (siehe second.component.ts Zeile 12). Wenn das Event ausgelöst wird, rufen wir die onDataChange-Methode auf und übergeben das Event-Objekt
* Zeilen 14-16: Methode, die aufgerufen wird, wenn das dataChange-Event ausgelöst wird

{title="second.component.ts", lang=js}
```
import {
    Component,
    Output,
    EventEmitter
} from '@angular/core';

@Component({
  selector: 'app-second',
  template: `
    <h1>Child</h1>
    <button (click)="sendData()">Send data to Parent</button>
  `
})
export class SecondComponent {
  @Output() dataChange = new EventEmitter();

  sendData() {
    this.dataChange.emit('Child Data');
  }
}
```

__Erklärung__:

* Zeile 11: Definition einer output-Eigenschaft namens "dataChange". Die output-Eigenschaft besitzt als Wert eine Instanz der EventEmitter-Klasse
* Zeilen 17-19: Methode, die aufgerufen wird, wenn der Nutzer auf den Button klickt
  * Zeile 16: Die emit-Methode triggert das dataChange-Event. Der Parameter der Methode ist das Event-Objekt, das übergeben wird (siehe auch app.component.ts Zeilen 9 und 16)

### Diskussion

Wir können die EventEmitter-Klasse nutzen, um eigene Events zu definieren.
Diese Events können mittels der emit-Methode getriggert werden, um deren Listener zu informieren, dass das Event ausgelöst worden ist.
Das machen wir uns zunutze und definieren immer unsere Output-Eigenschaften als Events, auf die eine Parent-Component hören kann, indem diese eine Event-Bindung nutzt.

W> #### $event
W>
W> Wenn wir in einer Überkomponente einen Listener für einen Event definieren und wir Zugriff auf das Event-Objekt benötigen, müssen wir für die Listenerfunktion im Template den Parameternamen "$event" nutzen. Falls uns das Event-Objekt nicht interessiert, brauchen wir keinen Parameter zu definieren. Dies gilt nicht nur für eigene Events, sondern auch für Browser-Events.

I> #### Unterschiedliche Namen für die output-Eigenschaft in Parent und Child
I>
I> Angular erlaubt es uns, zwei Namen für eine output-Eigenschaft zu definieren, indem wir beim Aufruf des Output-Decorators einen Parameter übergeben, z. B. `@Output('externalName') internalName = new EventEmitter()`. In diesem Beispiel wird "externalName" in der Parent-Component und "internalName" in der Child-Component verwendet. Wenn der Output-Decorator keinen Parameter erhält, wird in der Parent- und der Child-Component der selbe Name benutzt.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/05-Pass_Data_to_Parent_with_Outputs)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/05-Pass_Data_to_Parent_with_Outputs/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation der [EventEmitter-Klasse](https://angular.io/docs/ts/latest/api/core/index/EventEmitter-class.html) auf der Angular 2 Webseite

## Code ausführen bei der Initialisierung einer Komponente {#c07-on-init}

### Problem

Ich möchte bei der Initialisierung meiner Komponente Code ausführen z. B. um Daten vom Server zu holen.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* OnInit-Hook von Angular-Core
* Anpassungen an der app.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  template: '<div>Hello World!</div>'
})
export class AppComponent implements OnInit {
  ngOnInit() {
    console.log('Initialization');
  }
}
```

__Erklärung__:

* Zeile 7: Hier nutzen wir das OnInit-Interface und sagen, dass unsere Komponente dieses Interface implementiert
* Zeilen 8-10: Die ngOnInit-Methode wird bei der Initialisierung der Komponente von Angular aufgerufen. Sie ist Teil des OnInit-Interfaces

### Diskussion

Angular bietet uns sogenannte "Lifecycle Hooks" an.
Diese sind Methoden, die unsere Komponente implementieren kann und werden automatisch zu bestimmten Zeitpunkten von Angular aufgerufen.
Der OnInit-Hook, den wir hier nutzen wird bei der Initialisierung der Komponente, nach der Konstruktorfunktion aufgerufen.
Der `implements OnInit` Teil ist eigentlich optional, es wird aber empfohlen diesen zu nutzen, weil dann der Compiler eine Fehlermeldung ausgeben kann, falls wir den Namen der Methode falsch schreiben.

#### OnInit vs. Konstruktorfunktion

Auf den ersten Blick könnte man meinen, dass die zwei äquivalent sind bzw. dass wir Initialisierungscode genau so gut in den Konstruktor schreiben können.
Das stimmt nur bedingt.

Die Nutzung von __ngOnInit__ hat gewisse Vorteile.
Als Erstes ist es einfacher Unit-Tests dafür zu schreiben, weil wir da besser den Zeitpunkt des Aufrufs kontrollieren können.
Die Konstruktorfunktion wird bei Unit-Tests meistens von Angular automatisch aufgerufen.
Die ngOnInit-Methode hingegen nicht.

Ein weiterer Vorteil von __ngOnInit__ ist, dass diese Methode erst dann aufgerufen wird nach dem die Eigenschaft-Bindungen (@Input) der Komponente ihre Werte erhalten haben.
In der Konstruktorfunktion sind die Eigenschaft-Bindungen noch __undefined__.
Wenn wir also Zugriff auf Werte von Eigenschaft-Bindungen brauchen, müssen wir __ngOnInit__ nutzen.

Im Allgemeinen wird empfohlen den OnInit-Hook für Initialisierungscode und die Konstruktorfunktion für Dependency Injection zu nutzen.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/06-Execute_Code_on_Component_Init)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/06-Execute_Code_on_Component_Init/index.html)

### Weitere Ressourcen

* Mehr Informationen über [Lifecycle Hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html) gibt es auf der Angular 2 Webseite

## Code ausführen bei der Zerstörung (destroy) einer Komponente {#c07-on-destroy}

### Problem

Ich möchte informiert werden bevor eine Komponente von Angular zerstört wird, so dass ich z. B. die unsubscribe-Methode von einem Observable aufrufen kann.

### Zutaten

* [Eine Komponente definieren](#c02-component-definition)
* OnDestroy-Hook von Angular-Core
* Anpassungen an der second.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-second',
  template: '<div>My Name is ...</div>'
})
export class SecondComponent implements OnDestroy {
  ngOnDestroy() {
    console.log('Destroy');
  }
}
```

__Erklärung__:

* Zeile 7: Hier nutzen wir das OnDestroy-Interface und sagen, dass unsere Komponente dieses Interface implementiert
* Zeilen 8-10: Die ngOnDestroy-Methode wird bei der Zerstörung der Komponente von Angular aufgerufen. Sie ist Teil des OnDestroy-Interfaces

### Diskussion

Angular bietet uns sogenannte "Lifecycle Hooks" an.
Diese sind Methoden, die unsere Komponente implementieren kann und werden automatisch zu bestimmten Zeitpunkten von Angular aufgerufen.
Der OnDestroy-Hook, den wir hier nutzen wird z. B. aufgerufen, wenn die Komponente aus dem DOM entfernt wird.
Der `implements OnDestroy` Teil ist eigentlich optional, es wird aber empfohlen diesen zu nutzen, weil dann der Compiler eine Fehlermeldung ausgeben kann, falls wir den Namen der Methode falsch schreiben.

Die ngOnDestroy-Methode ist der ideale Ort, um Cleanup-Code zu schreiben.
Z. B. können wir hier eigene Callback-Funktionen entfernen, um Memory-Leaks zu vermeiden.
Hier haben wir nur den Code für die SecondComponent gezeigt.
Im Beispiel-Code auf Github wird auch die app.component.ts-Datei angepasst, so dass diese die SecondComponent aus dem DOM entfernen kann, damit die ngOnDestroy-Methode auch aufgerufen wird.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/07-Execute_Code_on_Component_Destroy)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/07-Execute_Code_on_Component_Destroy/index.html)

### Weitere Ressourcen

* Mehr Informationen über [Lifecycle Hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html) gibt es auf der Angular 2 Webseite

