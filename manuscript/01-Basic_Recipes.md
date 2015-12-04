# Basisrezepte

In diesem Kapitel befinden sich Basisrezepte die in weitere Kapitel des Buches benötigt werden. Der Code von den Rezepten die hier gezeigt werden, kann später kopiert und angepasst werden, um weiter Rezepte zu implementieren. Ziel des Kapitels ist es dem Leser den schnellen Einstieg in die Basics von Angular 2 zu ermöglichen.

## Angular 2 Anwendung

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten
* Leeres Verzeichnis für unsere Anwendung
* index.html-Datei, um die nötige Bibliotheken zu laden und die Anwendung zu starten
* main.ts-Datei mit der Komponentendefinition
* Webserver, um die index.html-Datei und die Angular Anwendung zu laden

{#test}
### Lösung

main.ts
```typescript
import {bootstrap, Component, View} from 'angular2/angular2';

@Component({
  selector: 'my-app'
})
@View({
  template: '<div>Hello World!</div>'
})
class MyApp {}

bootstrap(MyApp);
```

Erklärungen zu main.ts:
Diese Datei definiert die Haupt- und in dem Fall einzige Komponente unserer Anwendung. Sie ist ein ES6 Modul.
Die Hauptkomponente erkennt man dadurch, dass die der bootstrap-Funktion als Parameter übergeben wird (Zeile 11).

* Zeile 1: Hier importieren wir die nötige Abhängigkeiten aus dem angular2-Paket. Dafür nutzen wir eine [ES6 import-Anweisungen](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeile 3-5: Hier definieren wir eine Komponente mittels TypeScript-Decorator und sagen Angular, dass unser Komponente im my-app-Tag gerendert werden soll
* Zeile 6-8: Definiert die View die zu der Komponente gehört. Das HTML im template-Attribut wird später zwischen <my-tag> und </my-tag> hinzugefügt
* Zeile 9: Ist die dazugehörige Klasse. In diesem Fall ist die Klasse leer da unsere Komponente keine Funktionalität hat
* Zeile 11: Die Anwendung wird initialisiert

index.html
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Starter</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script src="https://code.angularjs.org/2.0.0-alpha.46/angular2.dev.js"></script>
  <script>
    System.config({
      transpiler: 'typescript',
        typescriptOptions: {
        emitDecoratorMetadata: true
      }
    });
    System.import('./main.ts');
  </script>
</head>
<body>
  <my-app>Loading...</my-app>
</body>
</html>
```

Erklärungen zu index.html:
In dieser Datei laden wir unsere Abhängigkeiten und laden mittels SystemJS das Hauptmodul unserer Anwendung (main.ts).

* Zeile 6: Lade SystemJS. Wird benötigt um das Hauptmodul und weitere Module wie z. B. Angular 2 zu laden.
* Zeile 7: Lade den TypeScript-Compiler. Der wird benötigt, um on-the-fly die main.ts-Datei in JavaScript umzuwandeln, so dass der Browser sie lesen kann
* Zeile 8: Lade die Entwicklungsversion von Angular 2
* Zeile 10-15: Konfiguriere SystemJS, so dass es TypeScript-Dateien on-the-fly umwandeln kann
* Zeile 16: Lade unser Hauptmodul
* Zeile 20: Hier wird unsere Hauptkomponente gerendert. Initial wird "Loading..." angezeigt bis Angular initialisiert wird

Jetzt brauchen wir noch ein Webserver, um unsere Anwendung zu testen. Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server) der automatisch die Seite im Browser Neuladen kann bei Änderungen. Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen. Beide Webserver sind über npm installierbar.

Nach der Installation und Start des Webservers, können wir unsere Anwendung testen. Wenn im Browser Fenster "Hello World!" steht, ist alles gut gelaufen. Wenn das nicht der Fall ist, muss man wahrscheinlich noch das [es6-shim](https://www.npmjs.com/package/es6-shim) installieren und in der index.html-Datei laden. Angular 2 braucht gewisse ES6-Features die in ältere Browser, darunter auch IE 11, nicht vorhanden sind.

### Diskussion

TypeScript on-the-fly in JavaScript umzuwandeln ist auf Dauer keine Option, da mit wachsende Datei Anzahl der Kompiliervorgan langsamer wird. Wir werden in spätere Rezepte sehen wie wir die TypeScript-Dateien vor kompilieren können.

### Code

Code in Github: TODO: code links

