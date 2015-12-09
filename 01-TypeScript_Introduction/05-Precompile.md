## TypeScript-Dateien vorkompilieren {#c01-precompile}

Wie schon angekündigt, ist das on-the-fly Kompilieren von TypeScript auf Dauer keine Lösung. In diesem Abschnitt werden wir sehen wie wir die TypeScript-Dateien vor dem Laden im Browser kompilieren können.
Als erstes brauchen wir den TypeScript-Kompiler. Es gibt verschiedene Möglichkeiten, um den TypeScript-Kompiler herunter zu laden. Wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind. Wir können Node.js installieren, in dem wir es von der [offizielle Webseite](https://nodejs.org/en/download/) herunter laden. Bei der Installation von Node.js, wird npm mit installiert.
Nachdem Node.js und npm installiert sind, können wir den Kompiler mit

```bash
npm install -g typescript
```

installieren.

Wir nehmen jetzt die Todo-Anwendung vom vorherigen Abschnitt und passen die so an, dass TypeScript-Dateien nicht mehr im Browser kompiliert werden. Dazu müssen wir zwei Sachen machen. Erstens muss die index.html-Datei angepasst werden und zweitens müssen wir die TypeScript-Dateien kompilieren. Der Code für die Anwendung mit angepasste index.html-Datei befindet sich in [01-TypeScript/02-Precompile](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/02-Precompile).

{title="Anpassungen in index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>TypeScript - Todo App</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script>
    System.config({
      packages: {'app': {defaultExtension: 'js'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <form>
    <input id="todoTitle"/>
    <button type="submit" id="addTodo">Add</button>
  </form>
  <ul id="todosList"></ul>
</body>
</html>
```

Erklärung:

TypeScript wird jetzt nicht mehr in der index.html-Datei geladen und in der SystemJS-Konfiguration haben wir die transpiler-Eigenschaft und die Optionen für den Kompiler entfernt. Einen weiteren Unterschied sehen wir in Zeile 9 wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts". Der Grund dafür ist, dass wir jetzt die kompilierte JavaScript-Dateien laden möchten. Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren. Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module commonjs app/main.ts
```

Erklärung:

tsc ist der TypeScript-Kompiler. Die Optionen "--emitDecoratorMetadata" und "--experimentalDecorators" sind in unserem Beispiel optional, werden aber später für die Angular Rezepte gebraucht. Die Option "--module" gibt an, dass die ES6/ES2015 Module die wir nutzen in CommonJS-Module umgewandelt werden sollen. Als letztes geben wir die main.ts-Datei an. Da die main.ts-Datei weitere Module importiert, werden diese automatisch kompiliert. Wir müssen also nicht jedes Modul einzeln kompilieren.
Der TypeScript-Kompiler bietet noch mehr Optionen an die wir nutzen können. Zwei davon werden wir noch gleich sehen. Weitere Optionen gibt es im [TypeScript-Wiki](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options).

W> ## Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierende JavaScript-Dateien, werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

I> ## CommonJS
I>
I> CommonJS ist ein Modul-Standard der hauptsächlich in Node.js verwendet wird. Wir nutzen CommonJS, weil dies die Zusammenarbeit von TypeScript mit externen Bibliotheken wie Angular 2 vereinfacht. Durch die Verwendung von CommonJS-Modulen ist der Kompiler in der Lage automatisch nach Typdefinitionen für externe Bibliotheken im "node\_modules" Verzeichnis zu suchen ohne, dass wir ihm sagen müssen wo die Typdefinitionen sind.

### Dateien automatisch kompilieren mit "watch"

Bei jede Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Kompiler eine einfache Lösung. Es gibt eine Option namens "--watch". Mit dieser Option werden die Dateien automatisch bei jede Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module commonjs --watch app/main.ts
```

Erklärung:

Mit "--watch" werden unsere Dateien bei jede Änderung automatisch neukompiliert. Das gilt nicht nur für die angegebene "app/main.ts"-Datei, sondern auch alle Dateien die importiert werden.

### Sourcemaps generieren

Nach dem kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein. Das kann das Debugging erschweren wenn z. B. der Browser ein Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei korrigieren möchten. Für genau solche Fälle gibt es Sourcemaps die uns die richtige Zeile in der TypeScript-Datei anzeigen. Um Sourcemaps zu erzeugen, nutzen wir eine weiter Option des Kompilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module commonjs --sourceMap app/main.ts
```

Erklärung:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren wenn man das möchte.

### Konfigurationsdatei für den Kompiler nutzen

TODO
