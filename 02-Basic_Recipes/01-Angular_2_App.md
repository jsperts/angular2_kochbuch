## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten
* Leeres Verzeichnis für unsere Anwendung
* index.html-Datei, um die nötige Bibliotheken zu laden und die Anwendung zu starten
* main.ts-Datei mit der Komponentendefinition in eine Unterverzeichnis namens "app"
* Webserver, um die index.html-Datei und die Angular Anwendung zu laden

### Lösung

{title="main.ts", lang=js}
```
import {bootstrap, Component, View} from 'angular2/core';
import {bootstrap} from 'angular2/platform/browser';

@Component({
  selector: 'my-app'
})
@View({
  template: '<div>Hello World!</div>'
})
class MyApp {}

bootstrap(MyApp);
```

Erklärung:

Diese Datei definiert die Haupt- und in dem Fall einzige Komponente unserer Anwendung. Sie ist ein ES6-Modul.
Die Hauptkomponente erkennt man dadurch, dass die der bootstrap-Funktion als Parameter übergeben wird (Zeile 12).

* Zeile 1-2: Hier importieren wir die nötige Abhängigkeiten aus dem angular2-Paket. Dafür nutzen wir eine ES6/ES2015 [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeile 4-6: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator) und sagen Angular, dass unser Komponente im my-app-Tag gerendert werden soll
* Zeile 7-9: Definiert die View die zu der Komponente gehört. Das HTML im template-Attribut wird später zwischen <my-tag> und </my-tag> hinzugefügt
* Zeile 10: Ist die dazugehörige Klasse. In diesem Fall ist die Klasse leer da unsere Komponente keine Logic und keine Daten hat
* Zeile 12: Die Anwendung wird initialisiert (bootstrap)

{title="index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Starter</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.0/Rx.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.0/angular2-polyfills.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.0/angular2.dev.js"></script>
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

* Zeile 6: Lade SystemJS. Wird benötigt um das Hauptmodul und weitere Module wie z. B. Angular 2 zu laden.
* Zeile 7: Lade den TypeScript-Compiler. Der wird benötigt, um on-the-fly die main.ts-Datei in JavaScript umzuwandeln, so dass der Browser sie lesen kann
* Zeile 8-9: RxJS und angular2-polyfills sind Abhängigkeiten von Angular 2
* Zeile 10: Lade die Entwicklungsversion von Angular 2
* Zeile 11-20: Konfiguriere SystemJS, so dass es TypeScript-Dateien on-the-fly umwandeln kann
* Zeile 19: Das Hauptmodul laden
* Zeile 23: Hier wird unsere Hauptkomponente gerendert. Initial wird "Loading..." angezeigt bis Angular initialisiert wird

Jetzt brauchen wir noch ein Webserver, um unsere Anwendung zu testen. Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server) der automatisch die Seite im Browser Neuladen kann bei Änderungen. Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen. Beide Webserver sind über npm installierbar.

Nach der Installation und Start des Webservers, können wir unsere Anwendung testen. Wenn im Browser Fenster "Hello World!" steht, ist alles gut gelaufen. Wenn das nicht der Fall ist, muss man wahrscheinlich noch das [es6-shim](https://www.npmjs.com/package/es6-shim) installieren und in der index.html-Datei laden. Angular 2 braucht gewisse ES6-Features die in ältere Browser, darunter auch Internet Explorer 11, nicht vorhanden sind.

### Diskussion

Wie schon im Abschnitt [TypeScript-Dateien vorkompilieren](#c01-precompile) erwähnt, ist TypeScript on-the-fly in JavaScript umzuwandeln auf Dauer keine Option.
Wir könnten die TypeScript-Dateien wie im Abschnitt "TypeScript-Dateien vorkompilieren" gezeigt kompilieren, aber der Compiler wird Warnungen anzeigen. Aber trotz Warnungen werden die Dateien kompiliert. Die Warnungen werden angezeigt weil TypeScript keine Typinformationen über Angular hat und auch nicht weißt wo sich das Modul "angular2/core" bzw. "angular2/platform/browser" befindet.
Im Abschnitt [Angular 2 Anwendung vorkompilieren](#c02-precompile-angular-app) werden wir sehen, wie man dieses Problem überwinden kann.
Um den schnellen Einstieg zu ermöglichen, ohne Abhängigkeiten installieren zu müssen, werden die meiste Code-Beispiele die on-the-fly Variante für das Kompilieren nutzen.

Bei der Definition einer Komponente, darf sich kein Code zwischen @Component(), @View() und class befinden. Da sind nur Kommentare und/oder Leerzeilen erlaubt. Falls sich da Code befindet, werden wir folgenden Fehler in der Konsole sehen:

{linenos=off}
```text
No Directive annotation found on MyApp
```

Wobei "MyApp" der Namen der Komponenten ist. Das gilt für alle Komponenten unabhängig davon, ob sie Haupt- oder normale Komponenten sind.

### Code

Code auf Github: [02-Basic\_Recipes/01-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/01-Angular_App)

### Weitere Ressourcen

* Informationen über ES6/ES2015 [Module](http://exploringjs.com/es6/ch_modules.html)
* Mehr Informationen über Decorators in TypeScript und JavaScript (wahrscheinlich in ES7/ES2016) gibt es [hier](https://github.com/wycats/javascript-decorators)

