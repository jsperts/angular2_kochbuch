## Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (app.component.ts), die wir im Rezepte "Angular 2 Anwendung" definiert haben

### Lösung

{title="second.component.ts", lang=js}
```
import {Component} from 'angular2/core';

@Component({
    selector: 'my-component',
    template: '<div>My Name is ...</div>'
})
class MyComponent {}

export default MyComponent;
```

__Erklärung__:

Diese Datei ist auch ein ESM und beinhaltet die Komponentendefinition für eine Komponente namens "MyComponent".
Genau wie unsere Hauptkomponente, definiert diese die selector- und die template-Eigenschaften.

{title="Anpassungen ad der app.component.ts-Datei", lang=js}
```
import {Component} from 'angular2/core';

import MyComponent from './component.ts';

@Component({
  selector: 'my-app',
  template: '<div>Hello World!</div> <my-component></my-component>',
  directives: [MyComponent]
})
class MyApp {}

export default MyApp;
```

__Erklärung__:

* Zeile 3: Hier importieren wir unsere Komponente
* Zeile 7: Wir haben den Tag __<my-component></my-component>__ in das Angular-Template hinzugefügt. Zu beachten ist, dass der Tag-Namen gleich dem Selektor in Zeile 4 in der second.component.ts-Datei sein muss
* Zeile 8: Mit der directives-Eigenschaft definieren wir welche Direktiven bzw. Komponenten im Template benutzt werden können

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten die wir im Angular-Template nutzen auch in dem directives-Array definieren. Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "MyComponent" ist jetzt eine Unterkomponente (auf Englisch child component) von unsere Hauptkomponente.
Indem wir Komponenten importieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen.
Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten mit der Hauptkomponente an der Spitze und beliebig viele Unterkomponenten.

### Code

Code auf Github: [02-Basic\_Recipes/02-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Define_Component)

