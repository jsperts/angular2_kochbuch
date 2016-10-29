## Einen Service definieren {#c02-define-service}

### Problem

Ich möchte einen Service definieren und nutzen, damit ich Teile meiner Logik und die Daten aus der Komponente entfernen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für unseren Service (data.service.ts)
* Injectable-Decorator (@Injectable)
* Anpassungen an der app.component.ts- und der app.module.ts-Datei

### Lösung

Was wir in der Angular-Welt einen Service nennen, ist im Grunde genommen nur eine TypeScript-Klasse.
Services werden benutzt, um Daten und Logik außerhalb von Komponenten zu halten.
Somit können wir die Methoden und die Daten eines Services in mehreren Komponenten wiederverwenden.

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
* Zeilen 6-15: Diese Klasse repräsentiert unseren Service. Sie wird auch exportiert, so dass wir den Service in Komponenten und anderen Services nutzen können

Wir haben jetzt einen Service definiert und müssen jetzt diesen im Angular-Modul als Provider registrieren.

{title="app.module.ts", lang=js}
```
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { DataService } from './data.service';

@NgModule({
  imports: [ BrowserModule ],
  declarations: [ AppComponent ],
  bootstrap: [ AppComponent ],
  providers: [ DataService ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 11: Die providers-Eigenschaft teilt Angular mit, welche Service der Anwendung zur Verfügung stehen

Bis jetzt haben wir einen Service definiert und diesen mit dem Angular-Modul registriert, nun wollen wir den Service in unserer Komponente nutzen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { DataService } from './data.service';

@Component({
  selector: 'app-root',
  template: '<div>Hello World!</div>'
})
export class DemoAppComponent {
  constructor(dataService: DataService) {
    console.log(dataService.getData());
  }
}
```

__Erklärung__:

* Zeile 9: Hier definieren wir den "DataService" als Abhängigkeit unserer Komponente. Zur Laufzeit wird die Konstruktorfunktion eine Instanz des "DataService" erhalten
* Zeile 10: Hier nutzen wir die getData-Methode der dataService-Instanz

### Diskussion

Nach unserer kurzen Erklärung ist anzunehmen, dass zur Lösung noch einige Fragen offen sind.
Was genau sind "providers"?
Warum brauchen wir kein "new", um den DataService zu instantiieren?
Wir haben erwähnt, dass wir den Service als "Injectable" definieren.
Aber was heißt das?
Diese Fragen werden wir jetzt beantworten.

#### Dependency Injection

Angular nutzt Dependency Injection (DI), um Abhängigkeiten zu verwalten.
Alle Provider werden mit dem sogenannten "Injector" registriert.
Erst die Nutzung einer TypeScript-Klasse in einem Provider macht die Klasse zu einem Service.

Als Erstes wollen wir die Frage "Was genau sind 'providers'?" beantworten.
Kurz gesagt ist ein "Provider" ein Rezept, um für einen Konstruktorparameter einen Wert bereitzustellen.
So ein Rezept besteht aus zwei Zutaten, ein Token und die Information welcher Wert zur Laufzeit übergeben werden soll.
In unserem Beispiel sagt das Rezept dem Injector, dass ein Parameter vom Typ "DataService" (das Token) eine Instanz (der Wert) der DataService-Klasse braucht.
Wir haben die Kurzform für einen Provider benutzt und in diesem Fall wird immer für die Klasse (das Token), die der providers-Array übergeben wird, eine Instanz erzeugt.
Das beantwortet auch gleich die Frage "Warum brauchen wir kein 'new', um den "DataService" zu instantiieren?".
Der Injector tut das für uns.
Das hat den Vorteil, dass wir als Nutzer des Services nicht wissen müssen, wie wir diesen instantiieren müssen.
Ein weitere Vorteil ist, dass wir z. B. beim Testen für das "DataService"-Token einen anderen Wert übergeben können. Z. B. eine Klasse die ein "DataService"-Mock erzeugt.

Wie wir schon wissen, werden Typinformationen zur Compile-Zeit entfernt.
Damit der Injector trotzdem weiß was für ein Wert ein Konstruktorparameter erwartet, wird diese Information in den Metadaten der Komponente gespeichert.
Da Klassen keine Metadaten besitzen, müssen wir eine Klasse, die wir als Service benutzen wollen mit Hilfe des Injectable-Decorators als "Injectable" definieren.
Somit erhält auch unser Service-Klasse Metadaten und kann dann Abhängigkeiten haben, die in den Metadaten gespeichert werden.
Kurz gesagt ist ein "Injectable" Service ein Service, der Abhängigkeiten als Konstruktorparameter besitzen kann.
Eigentlich brauchen wir den Injectable-Decorator nur, wenn wir für einen Service Abhängigkeiten als Konstruktorparameter definieren wollen.
Obwohl unser Service keine Abhängigkeiten hat, haben wir den Decorator verwendet, damit zum Einen alle Services einheitlich sind und zum Anderen Fehler vermieden werden, falls wir später doch eine Abhängigkeit brauchen.
Wir wissen jetzt also, was es bedeutet, einen Service als "Injectable" zu definieren und warum wir das machen.

Wir haben unsere Diskussion möglichst kurz gehalten.
Eine ausführlichere Erklärung, wie Dependency Injection in Angular funktioniert und was passiert, wenn wir eine Klasse in mehrere providers-Array nutzen, würde den Rahmen eines Rezepts sprengen.
Eine vollständige Erklärung, wie Dependency Injection funktioniert und was wir alles damit machen können, gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) und [Hierarchical Dependency Injectors](https://angular.io/docs/ts/latest/guide/hierarchical-dependency-injection.html).
Dort wird auch beschrieben, wie wir komplexere Provider-Rezepte nutzen können und was wir außer Services noch als Abhängigkeiten definieren können.

### Code

Code auf Github: [02-Basic\_Recipes/04-Define\_Service](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

### Weitere Ressourcen

* Neue Services können wir auch mit Hilfe des generate-Kommandos von angular-cli generieren. Mehr Informationen gibt es in [Appendix-B: angular-cli](#appendix-b)

