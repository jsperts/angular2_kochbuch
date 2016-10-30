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
Wir haben also hier eine Einweg-Daten-Bindung zwischen Parent- und Child-Component.
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

Code auf Github für die Lösung: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Solution](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Solution)

Code auf Github für die Demonstration: [07-Component\_Recipes/04-Pass\_Data\_to\_Child\_with\_Inputs/Demo](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Pass_Data_to_Child_with_Inputs/Demo)

Live Demo (Code aus dem Demo-Verzeichnis) auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/05-Pass_Data_to_Child_with_Inputs/Demo/index.html).

