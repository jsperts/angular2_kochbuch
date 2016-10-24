## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von null auf eine Angular 2 Anwendung implementieren.

### Zutaten

* [angular-cli](#c02-angular-cli)
* demo.component.ts-Datei, die die Haupt-[Komponente](#gl-component) der Anwendung definiert
* Component-Decorator für die Komponentendefinition (@Component)
* main.ts-Datei. Diese Datei initialisiert (bootstrap) die Angular 2 Anwendung
* index.html-Datei, um die nötigen Bibliotheken zu laden und die Anwendung zu starten

### Lösung

Als Erstes werden wir uns die demo.component.ts-Datei anschauen. Diese Datei befindet sich im Unterverzeichnis "src/app".

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: '<div>Hello World!</div>'
})
export class DemoAppComponent {}
```

__Erklärung__:

Diese Datei definiert die Haupt- und in diesem Fall einzige Komponente unserer Anwendung.
Sie ist ein ECMAScript-Modul (ESM).
Jede Datei, die das Keyword __import__ bzw. das Keyword __export__ beinhaltet ist ein ESM.

* Zeile 1: Hier importieren wir die nötigen Abhängigkeiten aus dem @angular/core-Paket. Dafür nutzen wir eine ESM [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeilen 3-6: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator)
  * Zeile 4: Die selector-Eigenschaft definiert das Tag in dem die Komponente gerendert werden soll. Hier wird die Komponente im Tag __<demo-app>__ gerendert
  * Zeile 5: Der Wert der template-Eigenschaft ist ein Angular-Template. Es wird später von Angular kompiliert und zwischen __<demo-app>__ und __</demo-app>__ hinzugefügt. Das kompilierte Angular-Template wird als "View" der Komponente bezeichnet
* Zeile 7: Definiert eine TypeScript-Klasse, die die Logik für die Komponente beinhaltet. In diesem Fall ist die Klasse leer, da wir keine Logik benötigen
  * Gleichzeitig wird die Klasse (und somit die Komponente) mit einer ESM [export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) exportiert


Als nächstes werden wir uns die main.ts-Datei anschauen. Diese befindet sich im Unterverzeichnis "app".

{title="main.ts", lang="js"}
```
import { bootstrap } from '@angular/platform-browser-dynamic';
import { DemoAppComponent } from './app/index';

bootstrap(DemoAppComponent);
```

__Erklärung__:

* Zeile 1: Importiert die Initialisierungsfunktion, die wir brauchen, um die Anwendung im Browser zu initialisieren
* Zeile 2: Importiert unsere Hauptkomponente. Die index.ts-Datei ist ein sogenanntes [barrel](#gl-barrel). Die Datei wurde von angular-cli automatisch angelegt
* Zeile 4: Die Hauptkomponente wird der Initialisierungsfunktion (bootstrap) übergeben und die Anwendung wird initialisiert. Die Hauptkomponente erkennt man dadurch, dass diese der bootstrap-Funktion als Parameter übergeben wird


Als Letztes schauen wir uns die index.html-Datei an. Diese befindet sich ebenfalls im Unterverzeichnis "app".

{title="index.html", lang=html}
```
...

<body>
  <demo-app>Loading...</demo-app>

  ...

</body>
```

__Erklärung__:

Wir schauen uns nur ein Ausschnitt aus der Datei an und zwar den Teil, in dem unsere Anwendung gerendert wird (Zeile 4).
Initial wird "Loading..." angezeigt bis Angular initialisiert wird.
Der restliche Inhalt befasst sich größtenteils mit dem Laden der Abhängigkeiten, dem Laden unserer Hauptdatei (main.ts) und dem Definieren des HTML-head-Tags.
Die Abhängigkeiten werden von [SystemJS](https://github.com/systemjs/systemjs) geladen.

Um den Beispiel-Code aus Github im Browser anzuzeigen, müssen wir mittels `npm install` die Abhängigkeiten installieren und dann mit `ng serve` den Server starten.

### Diskussion

Unser Code-Beispiel nutzt Angular im Entwicklungsmodus.
Darüber informiert uns auch Angular, wenn wir im Browser die Konsole offen haben.
Wir werden in einem weiteren Rezept sehen, wie wir Angular 2 in Produktion nutzen können.

#### Komponentendefinition

Bei der Definition einer Komponente darf sich kein Code zwischen @Component() und der Klasse befinden.
Dort sind nur Kommentare und/oder Leerzeilen erlaubt.
Falls sich dort Code befindet, führt der Aufruf von `ng serve` zu einem Fehler.

{linenos=off}
```text
Decorators are not valid here
```

#### Bootstrap

Der/die eine oder andere Leser/Leserin mag sich jetzt fragen, warum wir nicht einfach eine TypeScript-Datei mit der Komponentendefinition und der bootstrap-Funktion haben.
Natürlich hätten wir das auch machen können, aber die Aufspaltung in zwei Dateien bringt ein paar Vorteile mit sich.
Zum Einen vermischen wir die Komponentendefinition nicht mit der Initialisierung der Anwendung.
Die Komponentendefinition ist allgemein und könnte auf unterschiedlichen Plattformen verwendet werden.
Die bootstrap-Funktion ist browserspezifisch, daher auch der Import von "@angular/platform-browser-dynamic" anstelle von "@angular/core".
Das heißt, dass wir theoretisch mehrere Initialisierungsdateien haben könnten (z. B. eine für den Browser und eine für den Server), die die gleiche Hauptkomponente verwenden.
Die Aufspaltung erhöht also die Wiederverwendbarkeit unserer Hauptkomponente.
Zum Anderen erhöhen wir die Testbarkeit unserer Hauptkomponente.
Wenn sich der bootstrap-Aufruf in der gleichen Datei wie unsere Hauptkomponente befindet, gibt es bei einem Unit-Test Fehlermeldungen, da wir nicht nur die Komponente testen, sondern auch die Anwendung initialisieren.

### Code

Code auf Github: [02-Basic\_Recipes/02-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Angular_App)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Weitere Eigenschaften des Component-Decorators sind auf der Angular 2 Webseite beschrieben: [ComponentMetadata](https://angular.io/docs/ts/latest/api/core/ComponentMetadata-class.html)
* Decorators werden vermutlich als Teil einer späteren Version des ECMAScript-Standards spezifiziert. Mehr Informationen zu Decorators in TypeScript und JavaScript gibt es [hier](https://github.com/wycats/javascript-decorators)
* Weitere Informationen zu Angular-Templates gibt es in [Appendix A: Template-Syntax](#appendix-a)

