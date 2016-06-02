# Rezepte für Komponenten

In diesem Kapitel befinden sich verschiedene Rezepte, die hauptsächlich Komponenten betreffen.
Manche von den Rezepten können auch bei Direktiven angewendet werden.
Sachen wie z. B. die Kommunikation zwischen Komponenten, werden in diesem Kapitel behandelt.

## Komponente und HTML-Template trennen {#c07-split-html-template}

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meine Komponente halten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das HTML. Hier demo.component.html

### Lösung 1

Statt der template-Eigenschaft können wir die templateUrl-Eigenschaft nutzen und dort angeben, wo unsere HTML-Datei sich befindet.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  templateUrl: './app/demo.component.html'
})

...
```

__Erklärung__:

* Zeile 5: Pfad zu der demo.component.html-Datei. Hier ist der Pfad relativ zu der index.html-Datei der Anwendung. Wir können aber auch einen absoluten Pfad angeben

### Lösung 2

In der ersten Lösung hatten wir den Pfad relativ zu der index.html-Datei angegeben.
Es gibt auch die Möglichkeit den Pfad relativ zu der demo.component.ts-Datei zu definieren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  moduleId: module.id,
  selector: 'demo-app',
  templateUrl: 'demo.component.html'
})

...
```

__Erklärung__:

* Zeile 4: "module.id" wird von commonjs und dem Modul-Loader zur Verfügung gestellt. Diese Lösung funktioniert nur mit commonjs Module und wird standardmäßig von angular-cli benutzt, wenn wir damit eine Komponente generieren
* Zeile 6: Der Pfad zu der demo.component.html-Datei ist jetzt relative zu der demo.component.ts-Datei

### Diskussion

Wichtig zu beachten ist, dass wir entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können.
Beide gleichzeitig geht nicht.
Zur Laufzeit wird mittels XMLHttpRequest die Datei von Server geholt und der Inhalt der Datei wird kompiliert und in den DOM gesetzt.

#### templateUrl- vs. template-Eigenschaft

Beide Ansätze haben Vor- und Nachteile.
Wir werden uns diese kurz anschauen.

__templateUrl-Eigenschaft__

| Vorteile                  | Nachteile                              |
|---------------------------|----------------------------------------|
| Übersichtlicher           | Extra Server-Aufruf                    |
|---------------------------|----------------------------------------|
| Logik und Markup sind     | Zwei offene Dateien                    |
| getrennt                  | um eine Komponente zu implementieren   |
|---------------------------|----------------------------------------|
| Code-Highlighting         | Das Angeben von Pfaden hat eigene      |
|                           | Nachteile (siehe Lösung 1 vs. Lösung 2 |
|---------------------------|----------------------------------------|
| Auto-Vervollständigung    |                                        |

__template-Eigenschaft__

| Vorteile                     | Nachteile                        |
|------------------------------|----------------------------------|
| Die gesamte Komponente wird  | Unübersichtlich, wenn wir viel   |
| in eine Datei definiert      | HTML haben                       |
|------------------------------|----------------------------------|
| Kein extra Server-Aufruf     | Code-Highlighting und            |
|                              | Auto-Vervollständigung sind      |
|                              | Editor abhängig                  |
|------------------------------|----------------------------------|
| Keine Probleme mit Pfade     |                                  |

Ich persönlich versuche immer kleine Komponenten mit wenig HTML (10-15 Zeilen) zu schreiben und nutze dabei die template-Eigenschaft.

#### Lösung 1 vs. Lösung 2

Beide Lösungen sind nicht wirklich geeignet, um Komponenten zu schreiben die in mehrere Anwendungen benutzt werden.
Für die erste Lösung müssen wir immer wieder den Pfad anpassen, da vermutlich die Komponente nicht immer im gleichen Verzeichnis sein wird.
Das ist auch problematisch, wenn wir unsere Anwendung umstrukturieren möchten.

Es ist vielleicht auf den ersten Blick nicht zu erkennen weshalb die zweite Lösung nicht geeignet ist um wiederverwendbare Komponenten zu schreiben.
Diese Lösung ist wegen "module.id" an commonjs und eine Modul-Loader, der diese Eigenschaft nutzt gebunden.
Es gibt zwar Möglichkeiten diese Lösung auch mit andere Modul-System/-Loader zu nutzen aber auch da werden wir an einem bestimmten Modul-System/-Loader gebunden sein.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-02)

### Weitere Ressourcen

* Eine ausführlichere Diskussion zu Komponent-relative Pfade gibt es in [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html)

## Das Template der Komponente vom CSS trennen {#c07-styles}

### Problem

Ich möchte meine CSS-Styles getrennt von meinem Template halten und nicht in einem style-Tag im Template.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* CSS-Klassen, die im Template verwendet werden

### Lösung

Statt die CSS-Klassen im Template zu haben, können wir dafür die styles-Eigenschaft der Komponente nutzen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
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
export class DemoAppComponent {}
```

__Erklärung__:

* Zeilen 5-8: CSS-Styles für unsere Komponente

### Diskussion

Die styles-Eigenschaft einer Komponente erwartet ein Array von Strings.
Ein String kann CSS-Styles für eine oder mehrere Klassen, Tags, etc. beinhalten.
Jeder String wird dann zur Laufzeit als style-Tag in den DOM gesetzt.
In unserem Beispiel werden zwei style-Tags in den Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierte CSS-Styles standardmäßig nur in der Komponente verwendet werden in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View Encapsulation" genannt.

### Code

Code auf Github: [07-Component\_Recipes/02-Separation\_of\_Template\_and\_Styles](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/02-Separation_of_Template_and_Styles)

### Weitere Ressourcen

* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styleUrls-Eigenschaft benutzt wird, wird im Rezept "[Komponente und CSS trennen](#c07-styleurls)" gezeigt

## Komponente und CSS trennen {#c07-styleurls}

### Problem

Ich hab viele CSS-Klassen und ich möchte diese nicht in der Komponente haben, sondern in eine separate CSS-Datei.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das CSS. Hier demo.component.css

### Lösung 1

Statt die CSS-Klassen in der Komponente zu haben, können wir diese in eine separate CSS-Datei aufbewahren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  styleUrls: ['./app/demo.component.css'],
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

* Zeile 5: Wir nutzen die styleUrls-Eigenschaft, um Angular zu sagen, wo sich die Datei mit dem CSS befindet. Der Pfad zu der CSS-Dateien ist relativ zu der index.html-Datei der Anwendung. Absolute Pfade sind zumindest derzeit nicht zulässig (siehe [#6905](https://github.com/angular/angular/issues/6905)).

### Lösung 2

In der ersten Lösung hatten wir den Pfad relativ zu der index.html-Datei angegeben.
Es gibt auch die Möglichkeit den Pfad relativ zu der demo.component.ts-Datei zu definieren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  moduleId: module.id,
  selector: 'demo-app',
  styleUrls: ['demo.component.ts'],
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

* Zeile 4: "module.id" wird von commonjs und dem Modul-Loader zur Verfügung gestellt. Diese Lösung funktioniert nur mit commonjs Module und wird standardmäßig von angular-cli benutzt, wenn wir damit eine Komponente generieren
* Zeile 6: Der Pfad zu der demo.component.css-Datei ist jetzt relative zu der demo.component.ts-Datei

### Diskussion

Die styleUrls-Eigenschaft einer Komponente erwartet ein Array von Strings.
Zur Laufzeit wird mittels XMLHttpRequest die Datei vom Server geholt und der Inhalt der Datei wird als style-Tag in den DOM gesetzt.
In unserem Beispiel wird ein style-Tag in den Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierte CSS-Styles standardmäßig nur in der Komponente verwendet werden in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft der Komponente oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View Encapsulation" genannt.

Die Diskussion styles- vs. stuleUrls-Eigenschaft ist analog zu der template- vs. templateUrl-Eigenschaft Diskussion in [Komponente und HTML-Template trennen](#c07-split-html-template).
Ebenfalls analog ist die Diskussion Lösung 1 vs. Lösung 2 und die darin beschriebene Probleme.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/03-Separation\_of\_Component\_and\_Styles/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/03-Separation\_of\_Component\_and\_Styles/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles/Solution-02)

### Weitere Ressourcen

* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styles-Eigenschaft benutzt wird, wird im Rezept "[Das Template der Komponente vom CSS trennen](#c07-styles)" gezeigt

## Daten an einer Unterkomponente übergeben mittels input-Eigenschaft

### Problem

Ich möchte Daten, die sich in der Überkomponente befinden an einer Unterkomponente übergeben.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine [Komponente](#c02-component-definition)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Input-Decorator (@Input)

### Lösung

Wir werden uns als erstes die Überkomponente (Parent) und dann die Unterkomponente (Child) anschauen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { SecondComponent } from './second.component';

@Component({
  selector: 'demo-app',
  template: `
    <p>Parent Data: {{parentData}}</p>
    <app-second [childData]="parentData"></app-second>
  `,
  directives: [SecondComponent]
})
export class DemoAppComponent {
  parentData: string = 'Hello World!';
}
```

__Erklärung__:

* Zeile 8: Hier nutzen wir eine Eigenschafts-Bindung, um den Wert der parentData-Eigenschaft an die childData-Eigenschaft der Unterkomponente zu übergeben

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

* Zeile 8: Mit Hilfe des Input-Decorators (@Input) definieren wir die childData-Eigenschaft als input-Eigenschaft. Zu beachten ist, dass die input-Eigenschaft den gleichen Namen haben muss wie der Namen zwischen den eckigen Klammern in der demo.component.ts Zeile 8

### Diskussion

Änderungen in der parentData-Eigenschaft werden zur Laufzeit in die childData-Eigenschaft propagiert.
Wir müssen also nichts tun, wenn sich z. B. durch Nutzer-Interaktion der Wert der parentData-Eigenschaft ändert.
Wenn wir einen neuen Wert für die childData-Eigenschaft setzen, wird dieser Wert in der Parent-Komponente nicht sichtbar sein.
Wir haben also hier eine einweg-Datenbindung zwischen der Parent- und Child-Komponente.
Allerdings müssen wir aufpassen, wenn wir mit Objekten arbeiten.
Falls die parentData-Eigenschaft ein Objekt ist und wir eine Eigenschaft dieses Objekts in der Child-Komponente ändern würden, wird die Änderung auch in der Parent-Komponente sichtbar sein.
Der Grund dafür ist, dass Angular keine Kopie für das Objekt erstellt, sondern die Referenz weiter gibt.
Wir haben für dieses Rezept zwei Beispiel-Anwendungen auf Github.
Der Code im Solution-Verzeichnis ist dieser den wir hier gezeigt haben.
Das Demo-Verzeichnis beinhaltet eine Anwendung, die demonstrieren soll, welche Daten-Änderungen, wo sichtbar sind.

I> #### Unterschiedliche Namen für die input-Eigenschaft in Parent und Child
I>
I> Angular erlaubt es uns zwei Namen für eine input-Eigenschaft zu definieren, indem wir beim Aufruf des Input-Decorators einen Parameter übergeben. Z. B. `@Input('externalName') internalName: string`. In diesem Beispiel wird "externalName" in der Parent-Komponente benutzt und "internalName" in der Child-Komponente. Wenn der Input-Decorator keinen Parameter bekommt, wird in der Parent- und der Child-Komponente der gleiche Name benutzt.

### Code

Code auf Github für die Lösung: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Solution](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Solution)

Code auf Github für die Demonstration: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Demo](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Demo)

Live Demo (Code aus dem Demo-Verzeichnis) auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/05-Pass_Data_to_Child_with_Inputs/Demo/index.html).

## Daten an die Überkomponente übergeben mittels output-Eigenschaft

### Problem

Ich möchte Daten, die sich in einer Unterkomponente befinden an die Überkomponente übergeben.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine [Komponente](#c02-component-definition)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* [Auf Nutzer-Input reagieren](#c03-user-input)
* Output-Decorator (@Output)

### Lösung

Wir werden uns als erstes die Überkomponente (Parent) und dann die Unterkomponente (Child) anschauen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { SecondComponent } from './second.component';

@Component({
  selector: 'demo-app',
  template: `
    <h1>Parent</h1>
    <p>Parent Data: {{parentData}}</p>
    <app-second (dataChange)="onDataChange($event)"></app-second>
  `,
  directives: [SecondComponent]
})
export class DemoAppComponent {
  parentData: string = 'Initial Data';

  onDataChange(data) {
    this.parentData = data;
  }
}
```

__Erklärung__:

* Zeile 9: Die Syntax mit den Klammern für eine Event-Bindung kennen wir schon. Nur nutzen wir hier kein Browser-Event, sondern ein Event, was wir in der Child-Komponente definiert haben (Siehe child.component.ts Zeile 12). Wenn das Event ausgelöst wird, rufen wir die onDataChange-Methode auf und übergeben das Event-Objekt
* Zeilen 16-18: Methode die aufgerufen wird, wenn das dataChange-Event ausgelöst wird

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

* Zeile 11: Definition eine output-Eigenschaft namens "dataChange". Die output-Eigenschaft hat als Wert eine Instanz der EventEmitter-Klasse
* Zeilen 17-19: Methode die aufgerufen wird, wenn der Nutzer auf den Button klickt
  * Zeile 16: Die emit-Methode triggert das dataChange-Event. Der Parameter der Methode ist das Event-Objekt, was übergeben wird (Siehe auch demo.component.ts Zeilen 9 und 16)

### Diskussion

Wir können die EventEmitter-Klasse nutzen, um eigene Events zu definieren.
Diese Events können mittels der emit-Methode getriggert werden, um deren Listeners zu informieren, dass das Event ausgelöst worden ist.
Das machen wir uns zu nutzen und definieren immer unsere output-Eigenschaften als Events auf die eine Parent-Komponente hören kann, indem diese eine Event-Bindung nutzt.

W> #### $event
W>
W> Wenn wir in einer Überkomponente einen Listener definieren für ein Event und wir Zugriff auf das Event-Objekt brauchen, müssen wir für die Listenerfunktion im Template den Parameternamen "$event" nutzen. Falls uns das Event-Objekt nicht interessiert, brauchen wir keinen Parameter zu definieren. Dies gilt nicht nur für eigene Events, sondern auch für Browser-Events.

I> #### Unterschiedliche Namen für die output-Eigenschaft in Parent und Child
I>
I> Angular erlaubt es uns zwei Namen für eine output-Eigenschaft zu definieren, indem wir beim Aufruf des Output-Decorators einen Parameter übergeben. Z. B. `@Output('externalName') internalName = new EventEmitter()`. In diesem Beispiel wird "externalName" in der Parent-Komponente benutzt und "internalName" in der Child-Komponente. Wenn der Output-Decorator keinen Parameter bekommt, wird in der Parent- und der Child-Komponente der gleiche Name benutzt.

### Code

Code auf Github [07-Component\_Recipes/05-Pass\_Data\_to\_Parent\_with\_Outputs](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/05-Pass_Data_to_Parent_with_Outputs)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/06-Pass_Data_to_Parent_with_Outputs/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation für die [EventEmitter-Klasse](https://angular.io/docs/ts/latest/api/core/EventEmitter-class.html) auf der Angular 2 Webseite

