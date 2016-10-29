## Eine Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (app.component.ts), die wir im Rezept "Angular 2 Anwendung" definiert haben
* Anpassungen am Hauptmodul (app.module.ts)

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
Genau wie unsere Hauptkomponente definiert diese die selector- und template-Eigenschaften.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

import { SecondComponent } from './second.component';

@Component({
  selector: 'app-root',
  template: '<div>Hello World!</div><app-second></app-second>'
})
export class AppComponent {}
```

__Erklärung__:

* Zeile 3: Hier importieren wir unsere zweite Komponente
* Zeile 7: Wir haben den Tag __<app-second></app-second>__ zum Angular-Template hinzugefügt. Zu beachten ist, dass der Tag-Name gleich dem Selektor in Zeile 4 in der second.component.ts-Datei sein muss

{title="app.module.ts", lang=js}
```
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent }  from './app.component';
import { SecondComponent } from './second.component';

@NgModule({
  imports: [ BrowserModule ],
  declarations: [ AppComponent, SecondComponent ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 9: Hier deklarieren wir unsere neue Komponente, so dass wir diese in "AppComponent" nutzen können

### Diskussion

Jede Komponente, Direktive und Pipe muss in genau einem Modul deklariert werden und gehört dann zu diesem Modul.
Wenn wir diese nicht deklarieren, können wir sie in der Anwendung nicht nutzen.
Falls wir eine Komponente, Direktive oder Pipe in mehr als ein Modul deklarieren, wird Angular eine Exception schmeißen.

Die Komponente "SecondComponent" ist jetzt eine Unterkomponente (auf Englisch child component) unserer Hauptkomponente.
Indem wir Komponenten im Modul deklarieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen.
Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten, mit der Hauptkomponente an der Spitze und beliebig vielen Unterkomponenten.

#### Selektoren

Es wird empfohlen, ein Präfix für den Selektor der Komponente zu nutzen.
Deshalb ist der Selektor der "SecondComponent" nicht nur "second", sondern "app-second".
Der Präfix hat zwei Funktionen:

* Einerseits zeigt dieser, dass eine Komponente von uns implementiert worden ist und nicht aus einer externen Quelle importiert wird
* Anderseits können wir das Präfix nutzt, um anzugeben zu welchem Teil/Modul unserer Anwendung eine Komponente gehört

Bei größeren Anwendungen ist es nicht ungewöhnlich, die Anwendung auf mehrere Unterverzeichnisse zu verteilen, wobei jedes Verzeichnis ein Feature bezeichnet.
Z. B. kann eine große Anwendung einen Nutzerbereich und einen Adminbereich haben.
In so einem Fall können alle Komponenten des Nutzerbereichs das Präfix "user" erhalten und alle Komponenten des Adminbereichs das Präfix "admin".
Natürlich würden wir in so einem Fall auch für jedes Feature ein eigenes Angular-Modul definieren.

### Code

Code auf Github: [02-Basic\_Recipes/03-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Define_Component)

### Weitere Ressourcen

* Der [Angular Styleguide](https://angular.io/styleguide) gibt Hintergrundinformationen zu Namenskonventionen, zur Verzeichnisstruktur von Angular 2 Anwendungen und zu anderen Best Practices
* Neue Komponenten können wir auch mit Hilfe des generate-Kommandos von angular-cli generieren. Mehr Informationen gibt es in [Appendix-B: angular-cli](#appendix-b)

