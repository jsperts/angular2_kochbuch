## Daten an einer Unterkomponente übergeben mittels input-Eigenschaft

### Problem

Ich möchte Daten, die sich in der Überkomponente befinden an einer Unterkomponente übergeben.

### Zutaten

* Zwei [Komponenten](#c02-component-definition)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* Input-Decorator (@Input)

### Lösung

Wir werden uns als erstes die Überkomponente (Parent) und dann die Unterkomponente (Child) anschauen.

{title="app.component.ts", lang=js}
```
import {Component} from 'angular2/core';
import ChildComponent from './child.component';

@Component({
  selector: 'my-app',
  template: `
    <p>Parent Data: {{parentData}}</p>
    <child-component [childData]="parentData"></child-component>
  `,
  directives: [ChildComponent]
})
class MyApp {
  parentData: string = 'Hello World!';
}

export default MyApp;
```

__Erklärung__:

* Zeile 8: Hier nutzen wir eine Eigenschafts-Bindung, um den Wert der parentData-Eigenschaft an die childData-Eigenschaft der Unterkomponente zu übergeben

{title="child.component.ts", lang=js}
```
import {Component, Input} from 'angular2/core';

@Component({
  selector: 'child-component',
  template: '<p>Child Data: {{childData}}</p>'
})
class ChildComponent {
  @Input() childData: string;
}

export default ChildComponent;
```

__Erklärung__:

* Zeile 8: Mit Hilfe des Input-Decorators (@Input) definieren wir die childData-Eigenschaft als input-Eigenschaft. Zu beachten ist, dass die input-Eigenschaft den gleichen Namen haben muss wie der Namen zwischen den eckigen Klammern in der app.component.ts Zeile 8

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

Code auf Github für die Lösung: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Solution](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/05-Pass_Data_to_Child_with_Inputs/Solution)

Code auf Github für die Demonstration: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Demo](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/05-Pass_Data_to_Child_with_Inputs/Demo)

Live Demo (Code aus dem Demo-Verzeichnis) auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/05-Pass_Data_to_Child_with_Inputs/Demo/index.html).

