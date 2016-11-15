# Basisrezepte

In diesem Kapitel befinden sich Basisrezepte, die in späteren Rezepten als Zutaten benötigt werden.
Der Code, der in den Lösungen gezeigt wird, kann kopiert und angepasst werden, um die Lösungen für weitere Rezepte zu implementieren.
Es wird empfohlen, dieses Kapitel als Erstes zu lesen, um einen Überblick zu bekommen und sich erst dann mit den weiteren Rezepten zu beschäftigen.
Das Ziel des Kapitels ist, einen schnellen Einstieg in die Grundlagen und die Hauptbauteile von Angular 2 Anwendungen zu ermöglichen.

## Entwicklungsprozess für Angular 2 Projekte {#c02-angular-cli}

### Problem

Ich möchte einen möglichst einfachen Weg haben, ein Angular 2 Projekt zu initialisieren, zu bauen und das Resultat im Browser anzuschauen.

### Zutaten

* Node.js
* npm
* angular-cli

### Lösung

Der derzeit einfachste Weg, ein Angular 2 Projekt zu starten, zu bauen und sich das Resultat im Browser anzuschauen, ist ein Tool namens "angular-cli".
Das Tool befindet sich noch im beta-Stadium. Nichtsdestotrotz werden wir es nutzen, da die Alternative (alles selbst einzurichten) sehr aufwändig ist.

Als Erstes müssen wir __Node.js__ und __npm__ installieren, damit wir im zweiten Schritt __angular-cli__ installieren können.
Am einfachsten können wir Node.js installieren, indem wir es von der [offiziellen Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js, wird npm mit installiert.
Jetzt können wir angular-cli installieren mit:

```bash
npm install -g angular-cli@1.0.0-beta.19
```

Wir installieren angular-cli global und können es daher in jedem Angular 2 Projekt nutzen.

I> #### Node.js/npm Versionen
I>
I> angular-cli braucht eine relativ neue Version von Node.js und npm. Laut der Dokumentation soll die Version von Node.js ≥ 4 sein. Für das Buch wurde angular-cli mit der Version 6.9.1 von Node.js und Version 3.10.8 von npm getestet.

I> #### Fehler bei der Installation/Projekt-Initialisierung
I>
I> Bei Fehlern hilft es, angular-cli zu löschen und neu zu installieren. Fehler können vor allem auftreten, wenn eine alte Version von angular-cli schon installiert ist. Die Github-Seite von angular-cli beinhaltet Informationen, wie angular-cli [aktualisiert](https://github.com/angular/angular-cli#updating-angular-cli) werden kann.

Jetzt können wir ein Projekt initialisieren.
Dafür gibt es die Kommandos "new" und "init".

```bash
ng new projektName --skip-git
```

Dieses Kommando wird ein Verzeichnis mit dem Namen "projektName" erzeugen. Darin wird das Tool die nötigen Verzeichnisse/Dateien anlegen und alle Abhängigkeiten mittels npm installieren.
Falls `--skip-git` nicht angegeben wird, wird angular-cli auch ein git-Repository anlegen, vorausgesetzt, dass wir nicht schon in einem git-Repository sind.

Das init-Kommando macht das gleiche wie das new-Kommando aber für ein existierendes Verzeichnis.

```bash
ng init --name projektName
```

Falls `--name projektName` nicht angegeben wird, wird der Name des Verzeichnisses als Projektname benutzt.

W> #### Namen von Projekten
W>
W> Derzeit wird nicht jeder beliebige Name als Projektname unterstützt. Z. B. ist "test" kein gültiger Projektname. Das Tool wird eine Fehlermeldung ausgeben, falls der Projektname nicht zulässig ist.

#### Anwendung starten

Nachdem alle Abhängigkeiten installiert worden sind, können wir die Anwendung starten.
Angular-cli hat einen eingebauten HTTP-Server, den wir dafür nutzen können.
Um den Server zu starten, müssen wir im Projekt-Verzeichnis (das mit der package.json-Datei) folgendes Kommando aufrufen:

```bash
ng serve
```

In der Konsole steht dann, zu welcher URL wir navigieren müssen, um die Demo-Anwendung von angular-cli zu sehen (Zeile: "Serving on http://...").
Das Nette an diesem Webserver ist der Live-Reload-Support.
Das heißt, wenn wir Änderungen im Code machen, werden diese sofort im Browser sichtbar, ohne dass wir das Projekt selbst erneut kompilieren müssen.

### Diskussion

Alle Rezepte in diesem Buch wurden mit `angular-cli` initialisiert.
Es ist also nicht nötig `ng init` oder `ng new` aufzurufen.
Es reicht, wenn `npm install` aufgerufen wird, um die Abhängigkeiten zu installieren.
Danach können wir, wie oben gezeigt, mit `ng serve` die Anwendung starten.

Da das Tool eine eigene Meinung hat, wie die Verzeichnisstruktur, eine Komponente usw. auszusehen hat, wurden aus den Code-Beispielen ein paar Verzeichnisse/Dateien, die nicht für das jeweilige Beispiel relevant sind, gelöscht bzw. angepasst.
Wir wollen nicht, dass überflüssige Verzeichnisse, Dateien und Code-Zeilen uns vom eigentlichen Thema eines Rezeptes ablenken.
Wir schauen uns also nur die relevanten Dateien für ein Rezept an und ignorieren den Rest.
Auch gewisse Abhängigkeiten wurden aus der package.json-Datei entfernt, um die Installationszeit zu verkürzen.
Es ist also möglich, dass nicht alle angular-cli Kommandos mit jedem Rezept funktionieren.
Für die meisten Rezepte ist das src-Verzeichnis am Wichtigsten.
Darin befindet sich der Code für eine Angular 2 Anwendung.
Mehr Informationen über die Verzeichnisstruktur gibt es in [Appendix-B: angular-cli](#appendix-b).

### Weitere Ressourcen

* Offizielle Webseite von [angular-cli](https://cli.angular.io/)
* Github von [angular-cli](https://github.com/angular/angular-cli)
* [Appendix-B: angular-cli](#appendix-b)

## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten

* [angular-cli](#c02-angular-cli)
* app.module.ts-Datei, die das [Hauptmodul](#gl-main-module) der Anwendung definiert
* NgModule-Decorator für die Moduldefinition (@NgModule)
* app.component.ts-Datei, die die [Hauptkomponente](#gl-main-component) der Anwendung definiert
* Component-Decorator für die Komponentendefinition (@Component)
* main.ts-Datei. Diese Datei initialisiert (bootstrap) die Angular 2 Anwendung
* index.html-Datei, um die nötigen Bibliotheken zu laden und die Anwendung zu starten

### Lösung

Als Erstes werden wir uns die app.component.ts-Datei anschauen. Diese Datei befindet sich im Unterverzeichnis "src/app".

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: '<div>Hello World!</div>'
})
export class AppComponent {}
```

__Erklärung__:

Diese Datei definiert die Haupt- und in diesem Fall einzige Komponente unserer Anwendung.
Sie ist ein ECMAScript-Modul (ESM).
Jede Datei, die das Keyword __import__ bzw. das Keyword __export__ beinhaltet ist ein ESM.

* Zeile 1: Hier importieren wir die nötigen Abhängigkeiten aus dem @angular/core-Paket. Dafür nutzen wir eine ESM [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeilen 3-6: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator)
  * Zeile 4: Die selector-Eigenschaft definiert das Tag in dem die Komponente gerendert werden soll. Hier wird die Komponente im Tag __<app-root>__ gerendert
  * Zeile 5: Der Wert der template-Eigenschaft ist ein Angular-Template. Es wird später von Angular kompiliert und zwischen __<app-root>__ und __</app-root>__ hinzugefügt. Das kompilierte Angular-Template wird als "View" der Komponente bezeichnet
* Zeile 7: Definiert eine TypeScript-Klasse, die die Logik für die Komponente beinhaltet. In diesem Fall ist die Klasse leer, da wir keine Logik benötigen
  * Gleichzeitig wird die Klasse (und somit die Komponente) mit einer ESM [export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) exportiert


Jetzt sehen wir uns unser Hauptmodul (app.module.ts) an. Diese Datei befindet sich auch im Unterverzeichnis "src/app".

{title="app.module.ts", lang=js}
```
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';

@NgModule({
  imports: [ BrowserModule ],
  declarations: [ AppComponent ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 1: Hier wird der NgModule-Decorator aus @angular/core importiert
* Zeile 2: Importiert das BrowserModule aus @angular/platform-browser. Dieses bietet uns Funktionaliät an, die wir benötigen, wenn wir Angular im Browser nutzen wollen
* Zeilen 6-10: Hier wird unser Modul mittels @NgModule definiert
  * Zeile 7: Damit wir funktionalität von anderen Angular-Module in unser Modul nutzen können, müssen diese im imports-Array stehen
  * Zeile 8: Hier wird unsere Komponente deklariert. Somit ist das Modul und Angular von ihre Existenz informiert
  * Zeile 9: Hier wird die Komponente definiert, die bei der Initialisierung der Anwendung als erstes initialisiert werden soll

Als nächstes werden wir uns die main.ts-Datei anschauen. Diese befindet sich im Unterverzeichnis "app".

{title="main.ts", lang="js"}
```
import './polyfills.ts';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app';

platformBrowserDynamic().bootstrapModule(AppModule);
```

__Erklärung__:

* Zeile 1: Hier importieren wir eine Datei mit verschiedenen Polyfills die von Angular gebraucht werden. Falls nötig, können in dieser Datei weitere Polyfills für unsere Anwendung definieren
* Zeile 5: Hier importieren wir unser Hauptmodul. Wenn wir aus einem Verzeichnis importieren (hier "./app"), wird automatisch in der index.ts-Datei nach dem passendem Namen (hier "AppModule") gesucht. Diese Datei ist ein sogenanntes [barrel](#gl-barrel) und wird von angular-cli automatisch angelegt
* Zeile 7: Das Hauptmodul wird der Initialisierungsfunktion (bootstrapModule) übergeben und die Anwendung wird initialisiert


Als Letztes schauen wir uns die index.html-Datei an. Diese befindet sich ebenfalls im Unterverzeichnis "app".

{title="index.html", lang=html}
```
...

<body>
  <app-root>Loading...</app-root>
</body>
```

__Erklärung__:

Wir schauen uns nur ein Ausschnitt aus der Datei an und zwar den Teil, in dem unsere Anwendung gerendert wird (Zeile 4).
Initial wird "Loading..." angezeigt bis Angular initialisiert wird.

Um den Beispiel-Code aus Github im Browser anzuzeigen, müssen wir mittels `npm install` die Abhängigkeiten installieren und dann mit `ng serve` den Server starten.

### Diskussion

Unser Code-Beispiel nutzt Angular im Entwicklungsmodus.
Darüber informiert uns auch Angular, wenn wir im Browser die Konsole offen haben.
Im Rezept "[Angular 2 in Produktion nutzen](#c02-prod-build)" wird beschrieben wie wir Angular 2 im Produktionsmodus nutzen können.

#### Angular-Plattformen

Angular definiert verschiedene sogenannte Plattformen, die eine Umgebung schaffen in der eine Angular-Anwendung laufen kann.
Diese Plattformen definieren z. B. wann die Angular-Templates kompiliert werden oder stellen z. B. DOM-Anbindungen zur Verfügung.
Je nach dem wo die Anwendung laufen soll, z. B. im Browser, Server usw. gibt es auch eine entsprechendes Plattform-ES-Modul/-npm-Paket.
Wir haben "platform-browser-dynamic" verwendet weil unsere Anwendung im Browser mit Just-In-Time (JIT) Kompilierung arbeiten soll.
In diesem Fall bedeutet JIT, dass die Templates im Browser kompiliert werden.
Angular bietet auch die Option, Templates Ahead-Of-Time (AOT) beim bauen der Anwendung zu kompilieren.
In so einem Fall würden wir in der main.ts "platform-browser" statt "platform-browser-dynamic" verwenden.

#### Bootstrap

Der/die eine oder andere Leser/Leserin mag sich jetzt fragen, warum wir nicht einfach eine TypeScript-Datei mit der Moduldefinition und der bootstrap-Funktion haben.
Natürlich hätten wir das auch machen können, aber die Aufspaltung in zwei Dateien bringt ein Vorteil mit sich.
Wir vermischen die Moduldefinition nicht mit der Initialisierung der Anwendung.
Die Moduldefinition ist allgemein und könnte auf unterschiedlichen Plattformen verwendet werden.
Die bootstrap-Funktion ist Plattformspezifisch.
Jede Plattform hat eine eigene bootstrap-Funktion, die genau weiß wie die Anwendung initialisiert werden soll, damit diese auch auf der Plattform laufen kann.
Das heißt, dass wir theoretisch mehrere Initialisierungsdateien haben könnten (z. B. eine für den Browser und eine für den Server), die das gleiche Hauptmodul verwenden.
Die Aufspaltung erhöht also die Wiederverwendbarkeit des Moduls.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Angular_App)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/02-Basic_Recipes/02-Angular_App/index.html)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Weitere Eigenschaften des Component-Decorators sind auf der Angular 2 Webseite beschrieben: [@Component](https://angular.io/docs/ts/latest/api/core/index/Component-decorator.html)
* Weitere Eigenschaften des NgModule-Decorators sind auf der Angular 2 Webseite beschrieben: [@NgModule](https://angular.io/docs/ts/latest/api/core/index/NgModule-interface.html)
* Weitere Informationen über Angular-Module gibt es [hier](https://angular.io/docs/ts/latest/guide/ngmodule.html)
* Mehr Informationen zu Decorators in TypeScript gibt es [hier](https://www.typescriptlang.org/docs/handbook/decorators.html)
* Weitere Informationen zu Angular-Templates gibt es in [Appendix A: Template-Syntax](#appendix-a)

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

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Define_Component)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/02-Basic_Recipes/03-Define_Component/index.html)

### Weitere Ressourcen

* Der [Angular Styleguide](https://angular.io/styleguide) gibt Hintergrundinformationen zu Namenskonventionen, zur Verzeichnisstruktur von Angular 2 Anwendungen und zu anderen Best Practices
* Neue Komponenten können wir auch mit Hilfe des generate-Kommandos von angular-cli generieren. Mehr Informationen gibt es in [Appendix-B: angular-cli](#appendix-b)

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
export class AppComponent {
  constructor(dataService: DataService) {
    console.log(dataService.getData());
  }
}
```

__Erklärung__:

* Zeile 9: Hier definieren wir den "DataService" als Abhängigkeit unserer Komponente. Zur Laufzeit wird die Konstruktorfunktion eine Instanz des "DataService" erhalten
* Zeile 10: Hier nutzen wir die getData-Methode der dataService-Instanz. Statt die Daten in der Konstruktorfunktion zu holen, ist es besser die Daten in der ngOnInit-Methode zu holen. Die ngOnInit-Methode wird im Rezept "[Code ausführen bei der Initialisierung einer Komponente](#c07-on-init)" gezeigt

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

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/02-Basic_Recipes/04-Define_Service/index.html)

### Weitere Ressourcen

* Neue Services können wir auch mit Hilfe des generate-Kommandos von angular-cli generieren. Mehr Informationen gibt es in [Appendix-B: angular-cli](#appendix-b)

## Angular 2 in Produktion nutzen {#c02-prod-build}

### Problem

Ich möchte meine Angular 2 Anwendung produktiv nutzen.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Anpassungen in der main.ts-Datei
* environment-Dateien

### Lösung

Mit angular-cli ist es sehr einfach eine produktiv-Version von unserer Anwendung zu bauen.
Tatsächlich hat ein neu initialisiertes Projekt schon den Code in der main.ts-Datei, den wir in diesem Rezept hinzufügen wollen.
Auch die nötige environment-Dateien ist da schon vorhanden.

Als Erstes schauen wir uns die environment.prod.ts-Datei an.
Diese befindet sich im Verzeichnis "src/environments".

{title="environment.prod.ts", lang=js}
```
export const environment = {
    production: true
};
```

__Erklärung__:

Bei einem angular-cli-Projekt befinden sich im Verzeichnis "src/environments" zwei Dateien.
Die eine mit Namen "environment.ts" und eine mit Namen "environment.prod.ts".
Eigentlich sind beide Dateien optional.
Diese werden nur gebraucht, wenn wir sie in unserem Code referenzieren.
Der Unterschied zwischen den zwei Dateien, ist der Wert für die production-Eigenschaft.
Dieser ist __true__ in der environment.prod.ts-Datei und __false__ in der environment.ts-Datei.

Jetzt sehen wir warum es sinnvoll sein kann die environment-Dateien zu referenzieren.

{title="main.ts", lang=js}
```
import './polyfills.ts';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { enableProdMode } from '@angular/core';
import { environment } from './environments/environment';
import { AppModule } from './app/';

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule);
```

__Erklärung__:

* Zeile 5: Importiert eine environment-Datei. Ob es die environment.ts- oder die environment.prod.ts-Datei ist, wird von angular-cli zur Bauzeit definiert
* Zeilen 8-10: Hier wird der Produktions-Modus von Angular aktiviert aber nur, wenn angular-cli die environment.prod.ts-Datei nutzt

Als letztes müssen wir unser Projekt mit der `--prod`-Option bauen.

```
ng build --prod
```

Sobald die `--prod`-Option benutzt wird, nutzt angular-cli die environment.prod.ts-Datei.
In allen anderen Fällen z. B. beim `ng serve` wird die environment.ts-Datei benutzt.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/05-Production_Build)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/02-Basic_Recipes/05-Production_Build/index.html)

