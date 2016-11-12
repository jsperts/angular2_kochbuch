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

Code auf Github: [02-Basic\_Recipes/02-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Angular_App)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Weitere Eigenschaften des Component-Decorators sind auf der Angular 2 Webseite beschrieben: [@Component](https://angular.io/docs/ts/latest/api/core/index/Component-decorator.html)
* Weitere Eigenschaften des NgModule-Decorators sind auf der Angular 2 Webseite beschrieben: [@NgModule](https://angular.io/docs/ts/latest/api/core/index/NgModule-interface.html)
* Weitere Informationen über Angular-Module gibt es [hier](https://angular.io/docs/ts/latest/guide/ngmodule.html)
* Mehr Informationen zu Decorators in TypeScript gibt es [hier](https://www.typescriptlang.org/docs/handbook/decorators.html)
* Weitere Informationen zu Angular-Templates gibt es in [Appendix A: Template-Syntax](#appendix-a)

