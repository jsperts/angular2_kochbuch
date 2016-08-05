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

Wir werden uns als Erstes die Überkomponente (Parent) und dann die Unterkomponente (Child) anschauen.

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

