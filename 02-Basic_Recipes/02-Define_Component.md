## Komponente definieren

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* Angular 2 Anwendung (index.html-Datei und eine Hauptkomponente)
* Datei für die neue Komponente
* Anpassungen an der Hauptkomponente

### Lösung

component.ts
```js
import {Component, View} from 'angular2/angular2';

@Component({
    selector: 'my-component'
})
@View({
    template: '<div>My Name is ...</div>'
})
class MyComponent {}

export default MyComponent;
```

Erklärungen zu component.ts:

Diese Datei ist auch ein ES6-Modul ähnlich zu der main.ts-Datei die wir im [Angular 2 Anwendung Rezept](#angular-app) gesehen haben.
Es gibt zwei Hauptunterschiede. Erstens rufen wir die bootstrap-Funktion nicht auf.
Zweitens müssen wir die Komponente exportieren damit wir sie in der Hauptkomponente nutzen können. Das sehen wir auf Zeile 11. Wir nutzen eine [ES6 export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)

Anpassungen an der Hauptkomponente
main.ts
```js
import {bootstrap, Component, View} from 'angular2/angular2';
import MyComponent from './component.ts';

@Component({
  selector: 'my-app'
})
@View({
  template: '<div>Hello World!</div><my-component></my-component>',
  directives: [MyComponent]
})
class MyApp {}

bootstrap(MyApp);
```

Erklärungen zu den Anpassungen:

Zeile 2: Hier importieren wir unsere Komponente
Zeile 8: Wir haben den Tag <my-component></my-component> an das Template hinzugefügt. Zu beachten ist, dass dieser Tag gleich zu dem Selektor in Zeile 4 von component.ts sein muss
Zeile 9: Mit dem Attribute "directives", definieren wir welche Direktiven im Template benutzt werden können.

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten die wir im HTML-Template nutzen auch in dem directives-Array definieren. Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "MyComponent" ist jetzt ein Kindelement von unsere Hauptkomponente. In dem wir Komponenten importieren und dann in der View nutzen, können wir beliebig große Komponentenbäume erzeugen. Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten, mit der Hauptkomponente an der Spitze und beliebig viele Kindelemente.

### Code

Code auf Github: [https://github.com/jsperts/angular2\_kochbuch\_code/tree/master/01-Basic\_Recipes/02-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-Basic_Recipes/02-Define_Component)

