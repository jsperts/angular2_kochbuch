## Angular 2 Anwendung vorkompilieren {#c02-precompile-angular-app}

### Problem

Ich möchte meine Angular 2 Anwendung vorkompilieren, so dass die im Browser schneller lädt.
Zusätzlich sollen alle Abhängigkeiten lokal installiert sein.

### Zutaten
* Node.js, npm und TypeScript-Compiler. Siehe [TypeScript-Dateien vorkompilieren](#c01-precompile)
* [Angular 2 Anwendung](#c02-angular-app)
* package.json, um die Abhängigkeiten zu definieren
* Anpassungen an der main.ts-Datei von der Angular 2 Anwendung
* Anpassungen an der index.html-Datei von der Angular 2 Anwendung

### Lösung

{title="package.json", lang=json}
```
{
  "name": "Angular2Kochbuch",
  "dependencies": {
    "angular2": "2.0.0-beta.6",
    "es6-shim": "0.33.13",
    "reflect-metadata": "0.1.2",
    "rxjs": "5.0.0-beta.0",
    "systemjs": "0.19.21",
    "zone.js": "0.5.14"
  },
  "private": true
}
```

__Erklärung__:

Wir haben hier eine minimale package.json-Datei die wir benutzen, um Abhängigkeiten für unser Anwendung zu definieren.

* Zeile 2: Der Namen unserer Anwendung
* Zeilen 3-10: Abhängigkeiten die wir entweder direkt in unserer Anwendung brauchen oder die wir installieren damit der TypeScript-Compiler die Typen für die verschiedene Klassen, Methoden usw. finden kann
* Zeile 11: Mit der Eigenschaft "private" verhindern wir, dass unser Anwendung aus Versehen in das npm-Registery hoch geladen werden kann

Die Abhängigkeiten können jetzt installiert werden mit:

{lang=bash}
```
npm install
```

{title="Anpassungen an der main.ts-Datei", lang=js}
```
///<reference path="../node_modules/angular2/typings/browser.d.ts"/>

...
```

__Erklärung__:

Die hinzugefügte Zeile wird gebraucht, um dem TypeScript-Compiler zu sagen, wo er Typinformationen für gewisse Konstrukte wie z. B. Promise, Map und Set finden kann.
Wir können unseren Code auch ohne diese Zeile kompilieren aber der Compiler wird Warnungen ausgeben, da ihm Typinformationen fehlen.

{title="Anpassungen an der index.html-Datei", lang=html}
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

__Erklärung__:

* Zeilen 6-9: SystemJS, Angular und weitere Abhängigkeiten aus dem node\_modules-Verzeichnis laden

Nachdem wir die index.html-Datei angepasst und die Abhängigkeiten mittels npm installiert haben, können wir die Anwendung mit dem TypeScript-Compiler so wie im Rezept "[TypeScript-Dateien vorkompilieren](#c01-precompile)" kompilieren.
Im Beispiel-Code auf Github befindet sich auch eine tsconfig.json-Datei, die das Kompilieren erleichtert.

### Diskussion

Statt der angular2-polyfills.js-Datei (index.html-Datei Zeile 8), hätten wir auch "reflect-metadata" und "zone.js" (packege.json-Datei Zeilen 6 und 7) einzeln laden können.
Es ist aber einfacher die Abhängigkeiten direkt über die angular2-polyfills.js-Datei zu laden.
Es ist auch sicherer, dass die Versionen von "reflect-metadata" und "zone.js" kompatible zu der Version von Angular sind.
Trotzdem müssen wir beide Module über npm laden, damit der TypeScript-Compiler keine Typ-Fehler meldet.

I> #### On-the-fly Kompilierung
I>
I> Die meisten Rezepte in diesem Buch nutzen die on-the-fly Kompilierung wie diese im Rezept "[Angular 2 Anwendung](#c02-angular-app)" zu sehen ist. Der Grund dafür, ist dass wir damit schneller starten können ohne erst Abhängigkeiten zu installieren und Dateien zu kompilieren. Natürlich funktionieren alle Rezepte auch mit der index.html-Datei die hier zu sehen ist und mit der tsconfig.json-Datei die im Beispiel-Code für dieses Rezept zu finden ist. Damit der Compiler ohne Warnungen kompilieren kann, müssen wir in der main.ts-Datei jedes Rezeptes die Typinformationen hinzufügen wie wir es hier für in der main.ts-Datei getan haben.

### Code

Code auf Github: [02-Basic\_Recipes/03-Precompile\_Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Precompile_Angular_App)

### Weitere Ressourcen

* Weitere Eigenschaften der package.json-Datei werden in der [Online-Doku](https://docs.npmjs.com/files/package.json) erwähnt

