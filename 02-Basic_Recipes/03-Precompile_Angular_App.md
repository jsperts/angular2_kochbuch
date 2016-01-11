## Angular 2 Anwendung vorkompilieren {#c02-precompile-angular-app}

### Problem

Ich möchte meine Angular 2 Anwendung vorkompilieren, so dass die im Browser schneller lädt.
Zusätzlich sollen alle Abhängigkeiten lokal installiert sein.

### Zutaten
* Node.js, npm und TypeScript-Compiler muss installiert sein wie in [TypeScript-Dateien vorkompilieren](#c01-precompile) beschrieben
* [Angular 2 Anwendung](#c02-angular-app)
* Anpassungen an die index.html-Datei von der Angular 2 Anwendung
* package.json, um die Abhängigkeiten zu definieren

### Lösung

{title="package.json", lang=json}
```
{
  "name": "Angular2Kochbuch",
  "dependencies": {
    "angular2": "2.0.0-beta.1",
    "es6-shim": "0.33.3",
    "reflect-metadata": "0.1.2",
    "rxjs": "5.0.0-beta.0",
    "systemjs": "0.19.12",
    "zone.js": "0.5.10"
  },
  "private": true
}
```

Erklärung:

Wir haben hier eine minimale package.json-Datei die wir benutzen, um Abhängigkeiten für unser Anwendung zu definieren.

Zeile 2: Der Namen unserer Anwendung
Zeile 3-10: Abhängigkeiten die wir entweder direkt in unserer Anwendung brauchen oder die wir installieren damit der TypeScript-Compiler die Typen für die verschiedene Klassen, Methoden usw. finden kann
Zeile 11: Mit der Eigenschaft "private" verhindern wir, dass unser Anwendung aus Versehen in das npm-Register hoch geladen werden kann

Die Abhängigkeiten können jetzt mit

{lang=bash}
```
npm install
```

installiert werden.

{title="Anpassungen an der index.html-Datei", lang=js}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Precompiled</title>
  <script src="node_modules/systemjs/dist/system.js"></script>
  <script src="node_modules/rxjs/bundles/Rx.js"></script>
  <script src="node_modules/angular2/bundles/angular2-polyfills.js"></script>
  <script src="node_modules/angular2/bundles/angular2.dev.js"></script>
  <script>
    System.config({
      packages: {'app': {defaultExtension: 'js'}}
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

Zeile 6-9: SystemJS, Angular und Abhängigkeiten aus node\_modules laden statt online wie in der [Angular Anwendung](#c02-angular-app)
Zeile 8: angular2-polyfills.js beinhaltet die Abhängigkeiten reflect-metadata und zone.js

Nachdem wir die index.html-Datei angepasst und die Abhängigkeiten mittels npm installiert haben, können wir die Anwendung mit dem TypeScript-Compiler so wie in [TypeScript-Dateien vorkompilieren](#c01-precompile) kompilieren. Im Beispiel-Code auf Github befindet sich auch eine tsconfig.json-Datei, die das Kompilieren erleichtert.

### Diskussion

Statt der angular2-polyfills.js-Datei, hätten wir auch reflect-metadata und zone.js einzeln laden können. Ist aber einfacher die Abhängigkeiten direkt über angular2-polyfills.js zu laden. Es ist auch sicherer, dass die Versionen von reflect-metadata und zone.js kompatible zu der Version von Angular sind. Trotzdem müssen wir beide Module über npm laden, damit der TypeScript-Compiler keine Typ-Fehler meldet.

Die meisten Rezepte in diesem Buch nutzen die on-the-fly Kompilierung, wie die in [Angular 2 Anwendung](#c02-angular-app) zu sehen ist. Der Grund dafür, ist dass wir damit schneller starten können ohne erst Abhängigkeiten zu installieren und Dateien zu kompilieren. Natürlich funktionieren die Rezepte auch mit der index.html-Datei die hier zu sehen ist und mit der tsconfig.json-Datei die im Beispiel-Code für dieses Rezept zu finden ist.

### Code

Code auf Github: [02-Basic\_Recipes/03-Precompile\_Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Precompile_Angular_App)

### Weitere Ressourcen

* Weitere Eigenschaften der package.json-Datei werden in der [Online-Doku](https://docs.npmjs.com/files/package.json) erwähnt

