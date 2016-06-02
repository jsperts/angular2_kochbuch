## Ein Service definieren {#c02-define-service}

### Problem

Ich möchte einen Service definieren und nutzen, damit ich so Teile meiner Logik und Daten aus der Komponente entfernen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für unseren Service (data.service.ts)
* Injectable-Decorator (@Injectable)

### Lösung

Was wir in der Angular-Welt ein Service nennen, ist im Grunde genommen nur eine TypeScript-Klasse.
Services werden benutzt, um Daten und Logik außerhalb von Komponenten zu bewahren.
Somit können wir die Methoden und die Daten eines Service in mehreren Komponenten wiederverwenden.

{title="data.service.ts", lang=js}
```
import { Injectable } from '@angular/core';

const data = ['a', 'b', 'c'];

@Injectable()
export class DataService {
  data: Array<string>;
  constructor() {
    this.data = data;
  }

  getData() {
    return this.data;
  }
}
```

__Erklärung__:

* Zeile 5: Hier nutzen wir den Injectable-Decorator, um den Service als "Injectable" zu definieren
* Zeilen 6-15: Die Klasse, die unseren Service repräsentiert. Diese wird auch exportiert, so dass wir den Service in Komponenten und anderen Services nutzen können


Wir haben jetzt einen Service definiert und den werden wir jetzt in unsere Komponente nutzen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { DataService } from './data.service';

@Component({
  selector: 'demo-app',
  providers: [DataService],
  template: '<div>Hello World!</div>'
})
export class DemoAppComponent {
  constructor(dataService: DataService) {
    console.log(dataService.getData());
  }
}
```

__Erklärung__:

* Zeile 2: DataService importieren
* Zeile 6: Die providers-Eigenschaft sagt Angular welche Services der Komponente und ihre Unterkomponenten zur Verfügung stehen. Nur Services die hier definiert sind können als Konstruktorparameter benutzt werden (Siehe auch Zeile 10)
* Zeile 10: Hier definieren wir den "DataService" als Abhängigkeit unserer Komponente. Zur Laufzeit wird die Konstruktorfunktion eine Instanz des "DataService" bekommen
* Zeile 11: Hier nutzen wir die getData-Methode der dataService-Instanz

### Diskussion

Es ist anzunehmen, dass nach unsere kurze Erklärung in der Lösung noch einige Fragen offen sind.
Wir haben erwähnt, dass wir den Service als "Injectable" definieren.
Aber was heißt das?
Warum brauchen wir kein "new", um den DataService zu instantiieren?
Was genau sind "providers"?
Wir werden jetzt diese Fragen beantworten.

#### Dependency Injection

Angular nutzt Dependency Injection (DI), um Abhängigkeiten zu verwalten.
Alle Providers von Komponenten werden mit dem sogenannten "Injector" registriert und dieser weiß dann zur Laufzeit was er tun muss, wenn z. B. eine Komponente ein Service im Konstruktor als Abhängigkeit definiert hat.
Die Information, dass die Komponente einen Service braucht wird in den Metadaten der Komponente gespeichert.
Bei der Komponentendefinition stehen uns diese Metadaten zur Verfügung, da wir den Component-Decorator nutzten.

Da Services keine Metadaten besitzen müssen wir den Service mit Hilfe vom Injectable-Decorator als "Injectable" definieren.
Somit bekommt auch unserer Service Metadaten und kann dann auch Abhängigkeiten haben, die in diese Metadaten gespeichert werden.
Wir brauchen also den Injectable-Decorator nur, wenn wir für einen Service einen weiteren Service im Konstruktor als Abhängigkeit definieren wollen.
Kurz gesagt ist ein "Injectable" Service, ein Service der Abhängigkeiten als Konstruktorparameter haben kann.
Obwohl unser Service keine Abhängigkeiten hat, haben wir den Decorator benutzt, damit alle Services einheitlich sind und, um Fehler zu vermeiden falls wir später doch eine Abhängigkeit brauchen.
Wir wissen jetzt also was es bedeutet ein Service als "Injectable" zu definieren und warum wir das machen.

Die Frage "Warum brauchen wir kein 'new', um den DataService zu instantiieren?" ist einfach zu beantworten.
Der Injector übernimmt die Instantiierung für uns.
Das hat den Vorteil, dass wir als Nutzer des Services gar nicht wissen müssen wie wir diesen instantiieren müssen.

Jetzt wollen wir noch die letzte Frage beantworten.
Kurz gesagt ist ein "Provider" ein Rezept, um ein Service zu instantiieren.
Unsere Komponente hat nur eine Abhängigkeit und braucht deshalb auch nur ein Provider.
Der Provider ist die Klasse, die den Service repräsentiert und der Injector weiß, dass eine Klasse mit "new" zu instantiieren ist und die Instanz als Konstruktorparameter zu übergeben ist.
Um genau zu wissen welche Klasse zur welcher Instanz gehört, nutzt der Injector die Typdefinition der Konstruktorparameter.
Alternativ können wir statt eine Typdefinition auch den Inject-Decorator (@Inject) nutzen:

{title="Inject-Decorator statt Typ", lang=js}
```
...

import { Inject } from '@angular/core';
import { DataService } from './data.service';

...

class DemoAppComponent(@Inject(DataService) dataService) { ... }

...
```

Wir haben unsere Diskussion möglichst kurz gehalten.
Eine ausführlichere Erklärung wie Dependency Injection in Angular funktioniert würde den Rahmen eines Rezepts sprenden.
Eine vollständige Erklärung wie Dependency Injection funktioniert und was wir alles damit machen können gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html).
Da wird auch beschrieben wie wir komplexere Provider-Rezepte nutzen können und was wir außer Services als Abhängigkeiten definieren können.

### Code

Code auf Github: [02-Basic\_Recipes/04-Define\_Service](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

