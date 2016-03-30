## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten
* Leeres Verzeichnis für unsere Anwendung
* Unterverzeichnis für die TypeScript-Dateien. Wir werden das Verzeichnis "app" benennen
* index.html-Datei, um die nötigen Bibliotheken zu laden und die Anwendung zu starten
* app.component.ts-Datei mit der Komponentendefinition
* main.ts-Datei. Diese Datei initialisiert (bootstrap) die Angular 2 Anwendung
* Webserver, um die index.html-Datei und die Angular Anwendung zu laden

### Lösung

Als erstes werden wir uns die app.component.ts-Datei mit der Komponentendefinition anschauen. Diese Datei befindet sich im Unterverzeichnis "app".

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

@Component({
  selector: 'my-app'
})
@View({
  template: '<div>Hello World!</div>'
})
class MyApp {}

export default MyApp;
```

Erklärung:

Diese Datei definiert die Haupt- und in dem Fall einzige Komponente unserer Anwendung.
Sie ist ein ECMAScript-Modul (ESM).
Jede Datei die das Keyword __import__ bzw. das Keyword __export__ beinhaltet ist ein ESM.

* Zeile 1: Hier importieren wir die nötigen Abhängigkeiten aus dem angular2/core-Paket. Dafür nutzen wir eine ESM [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeile 3-5: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator) und sagen Angular, dass unser Komponente im my-app-Tag gerendert werden soll (selector-Eigenschaft der Komponente)
* Zeile 6-8: Definiert die View die zu der Komponente gehört. Das HTML der template-Eigenschaft wird später von Angular zwischen <my-tag> und </my-tag> hinzugefügt
* Zeile 9: Definiert eine TypeScript-Klasse, die die Logik für die Komponente beinhaltet. In diesem Fall ist die Klasse leer, da wir keine Logik benötigen
* Zeile 11: Hier exportieren wir die Komponente. Dafür nutzen wir eine ESM [export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)

Als nächstes werden wir uns die main.ts-Datei anschauen. Diese Datei befindet sich ebenfalls im Unterverzeichnis "app".

{title="main.ts", lang="js"}
```
import {bootstrap} from 'angular2/platform/browser';

import MyApp from './app.component';

bootstrap(MyApp);
```

Erklärung:

Zeile 1: Importiert die Initialisierungsfunktion die wir brauchen, um die Anwendung im Browser zu initialisieren
Zeile 3: Importiert unsere Hauptkomponente
Zeile 5: Die Hauptkomponente wird der Initialisierungsfunktion (bootstrap) übergeben und die Anwendung wird initialisiert. Die Hauptkomponente erkennt man dadurch, dass die der bootstrap-Funktion als Parameter übergeben wird

Als letztes schauen wir uns die index.html-Datei an. Diese Datei befindet sich im Hauptverzeichnis unserer Anwendung.

{title="index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Hello World</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/Rx.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/angular2-polyfills.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/angular2.dev.js"></script>
  <script>
    System.config({
      transpiler: 'typescript',
        typescriptOptions: {
        emitDecoratorMetadata: true
      }
      package: {app: {defaultExtension: 'ts'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <my-app>Loading...</my-app>
</body>
</html>
```

Erklärung:

In dieser Datei laden wir unsere Abhängigkeiten und laden mittels SystemJS das Hauptmodul unserer Anwendung (main.ts).

* Zeile 6: Lade SystemJS. Wird benötigt um das Hauptmodul und weitere Module wie z. B. Angular 2 zu laden.
* Zeile 7: Lade den TypeScript-Compiler. Der wird benötigt, um on-the-fly die main.ts-Datei in JavaScript umzuwandeln, so dass der Browser sie lesen kann
* Zeile 8-9: RxJS und angular2-polyfills sind Abhängigkeiten von Angular 2
* Zeile 10: Lade die Entwicklungsversion von Angular 2
* Zeile 11-20: Konfiguriere SystemJS, so dass es TypeScript-Dateien on-the-fly umwandeln kann
* Zeile 19: Die Hauptdatei unserer Anwendung laden. Diese Datei initialisiert unsere Anwendung (bootstrap)
* Zeile 23: Hier wird unsere Hauptkomponente gerendert. Initial wird "Loading..." angezeigt bis Angular initialisiert wird

Jetzt brauchen wir noch ein Webserver, um unsere Anwendung zu testen. Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server) der automatisch die Seite im Browser Neuladen kann bei Änderungen. Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen. Beide Webserver sind über npm installierbar.

Nach der Installation und Start des Webservers, können wir unsere Anwendung testen. Wenn im Browser Fenster "Hello World!" steht, ist alles gut gelaufen. Wenn das nicht der Fall ist, muss man wahrscheinlich noch das [es6-shim](https://www.npmjs.com/package/es6-shim) installieren und in der index.html-Datei laden. Angular 2 braucht gewisse ES6-Features die in ältere Browser, darunter auch Internet Explorer 11, nicht vorhanden sind.

### Diskussion

Wie schon im Abschnitt [TypeScript-Dateien vorkompilieren](#c01-precompile) erwähnt, ist TypeScript on-the-fly in JavaScript umzuwandeln auf Dauer keine Option.
Wir könnten die TypeScript-Dateien wie im Abschnitt "TypeScript-Dateien vorkompilieren" gezeigt kompilieren, aber der Compiler wird Warnungen anzeigen. Trotz Warnungen werden die Dateien kompiliert. Die Warnungen werden angezeigt weil TypeScript keine Typinformationen über Angular hat und auch nicht weiß wo sich das Modul "angular2/core" bzw. "angular2/platform/browser" befindet.
Im Abschnitt [Angular 2 Anwendung vorkompilieren](#c02-precompile-angular-app) werden wir sehen, wie wir dieses Problem überwinden können.
Um den schnellen Einstieg zu ermöglichen, ohne Abhängigkeiten installieren zu müssen, werden die meiste Code-Beispiele die on-the-fly Variante für das Kompilieren nutzen.

Bei der Definition einer Komponente, darf sich kein Code zwischen @Component(), @View() und class befinden. Da sind nur Kommentare und/oder Leerzeilen erlaubt. Falls sich da Code befindet, werden wir folgenden Fehler in der Konsole sehen:

{linenos=off}
```text
No Directive annotation found on MyApp
```

Wobei "MyApp" der Namen der Komponenten ist. Das gilt für alle Komponenten unabhängig davon, ob sie Haupt- oder normale Komponenten sind.

Der/die eine oder andere Leser/Lesering mag sich jetzt fragen, warum wir nicht einfach eine TypeScript-Datei mit der Komponentendefinition und die bootstrap-Funktion haben.
Natürlich hätten wir das auch machen können aber die Aufspaltung in zwei Datein bringt einige Vorteile mit sich.
Zum einen vermischen wir nicht die Komponentendefinition und die Initialisierung der Anwendung.
Die Komponentendefinition ist allgemein und könnte auf unterschiedlichen Plattformen verwendet werden.
Die bootstrap-Funktion ist Browser spezifisch, daher auch der Import von "angular2/platform/browser" und nicht "angular2/core" wie "Component" und "View".
Das heißt, dass wir theoretisch mehrere Initialisierungsdateien haben könnten z. B. eine für den Browser und eine für den Server, die die gleiche Hauptkomponente verwenden.
Die Aufspaltung erhöht also die Wiederverwendbarkeit unserer Hauptkomponente.
Ein weiterer Vorteil ist die Erhöhung der Testbarkeit unserer Hauptkomponente.
Wenn sich der bootstrap-Aufruf in der gleichen Datei befindet wie unsere Hauptkomponente, wird es bei einem Unit-Test Fehlermeldungen geben, da wir nicht nur die Komponente testen, sondern auch die Anwendung initialisieren.

### Code

Code auf Github: [02-Basic\_Recipes/01-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/01-Angular_App)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Decorators werden vermutlich als Teil einer späteren Version des ECMAScript-Standards spezifiziert. Mehr Informationen über Decorators in TypeScript und JavaScript gibt es [hier](https://github.com/wycats/javascript-decorators)

