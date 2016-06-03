## Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (demo.component.ts), die wir im Rezepte "Angular 2 Anwendung" definiert haben

### Lösung

{title="second.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
    selector: 'app-second',
    template: '<div>My Name is ...</div>'
})
export class SecondComponent {}
```

__Erklärung__:

Diese Datei ist auch ein ESM und beinhaltet die Komponentendefinition für eine Komponente namens "SecondComponent".
Genau wie unsere Hauptkomponente, definiert diese die selector- und die template-Eigenschaften.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

import { SecondComponent } from './second.component';

@Component({
  selector: 'demo-app',
  template: '<div>Hello World!</div><app-second></app-second>',
  directives: [SecondComponent]
})
export class DemoAppComponent {}
```

__Erklärung__:

* Zeile 3: Hier importieren wir unsere zweite Komponente
* Zeile 7: Wir haben den Tag __<app-second></app-second>__ in das Angular-Template hinzugefügt. Zu beachten ist, dass der Tag-Namen gleich dem Selektor in Zeile 4 in der second.component.ts-Datei sein muss
* Zeile 8: Mit der directives-Eigenschaft definieren wir welche Direktiven bzw. Komponenten im Template benutzt werden können

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten, die wir im Angular-Template nutzen auch in dem directives-Array definieren.
Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "SecondComponent" ist jetzt eine Unterkomponente (auf Englisch child component) von unsere Hauptkomponente.
Indem wir Komponenten importieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen.
Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten mit der Hauptkomponente an der Spitze und beliebig viele Unterkomponenten.

#### Selektoren

Es wird empfohlen ein Präfix für den Selektor von Komponenten zu nutzen.
Deshalb ist der Selektor der "SecondComponent" nicht nur "second", sondern "app-second".
Der Präfix hat zwei Funktionen:

* Einerseits zeigt dieser, dass eine Komponente von uns implementiert worden ist und nicht von externe Quellen importiert wird
* Anderseits wird der Präfix benutzt, um anzugeben zu welchem Teil unserer Anwendung eine Komponente gehört

Bei größeren Anwendungen ist es nicht ungewöhnlich die Anwendung in mehreren Unterverzeichnissen aufzuteilen wobei jedes Verzeichnis ein Feature bezeichnet.
Z. B. kann eine große Anwendung ein Nutzerbereich und ein Adminbereich haben.
In so einem Fall können alle Komponenten des Nutzerbereichs das Präfix "user" haben und alle Komponenten des Adminbereichs das Präfix "admin".

### Code

Code auf Github: [02-Basic\_Recipes/03-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Define_Component)

### Weitere Ressourcen

* Der [Angular Styleguide](https://angular.io/styleguide) gibt Hintergrundinformationen über Namenskonventionen, die Verzeichnisstruktur von Angular 2 Anwendungen und über andere Best Practices
* Neue Komponente können wir auch mit Hilfe des generate-Kommandos von angular-cli generieren. Mehr Informationen gibt es im [Appendix-B: angular-cli](#appendix-b)

