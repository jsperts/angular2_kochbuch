## Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (app.component.ts) die wir im Rezepte Angular 2 Anwendung definiert haben

### Lösung

{title="second.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

@Component({
    selector: 'my-component'
})
@View({
    template: '<div>My Name is ...</div>'
})
class MyComponent {}

export default MyComponent;
```

Erklärung:

Diese Datei ist auch ein ES-Modul und beinhaltet eine Komponentendefinition genau wie die app.component.ts-Datei die wir im [Angular 2 Anwendung Rezept](#c02-angular-app) gesehen haben.

Anpassungen an der Hauptkomponente

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

import MyComponent from './component.ts';

@Component({
  selector: 'my-app'
})
@View({
  template: '<div>Hello World!</div> <my-component></my-component>',
  directives: [MyComponent]
})
class MyApp {}

export default MyApp;
```

Erklärung:

Zeile 3: Hier importieren wir unsere Komponente
Zeile 9: Wir haben den Tag <my-component></my-component> in das Template hinzugefügt. Zu beachten ist, dass der Tag-Namen gleich dem Selektor in Zeile 4 von second.component.ts sein muss
Zeile 10: Mit dem Attribute "directives", definieren wir welche Direktiven bzw. Komponenten im Template benutzt werden können

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten die wir im HTML-Template nutzen auch in dem directives-Array definieren. Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "MyComponent" ist jetzt ein Kindelement von unsere Hauptkomponente. Indem wir Komponenten importieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen. Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten, mit der Hauptkomponente an der Spitze und beliebig viele Kindelemente.

### Code

Code auf Github: [02-Basic\_Recipes/02-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Define_Component)

