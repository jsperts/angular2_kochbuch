## TypeScript-Dateien vorkompilieren

Wie schon angekündigt, ist das on-the-fly Kompilieren von TypeScript auf Dauer keine Lösung. In diesem Abschnitt werden wir sehen wie wir die TypeScript-Dateien vor dem Laden im Browser kompilieren können.

Es gibt verschiedene Möglichkeiten, um den TypeScript-Kompiler herunter zu laden, aber wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind. Eine Möglichkeit um Node.js zu installieren ist es von der [offizielle Webseite](https://nodejs.org/en/download/) herunter zu laden. Bei der Installation von Node.js, wird npm mit installiert.
Nachdem Node.js und npm installiert ist, können wir den Kompiler mit _npm install -g typescript_ installieren.

Wir nehmen jetzt die Todo-Anwendung vom vorherigen Abschnitt und passen die so an, damit TypeScript-Dateien nicht mehr im Browser kompiliert werden. Dazu müssen wir zwei Sachen machen. Erstens muss die index.html-Datei angepasst werden und zweitens müssen wir die TypeScript-Dateien kompilieren.

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

TypeScript wird jetzt nicht mehr in der index.html-Datei geladen und in der SystemJS-Konfiguration haben wir den Transpiler und seine Optionen entfernt. Einen weiteren Unterschied sehen wir in Zeile 9 wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts". Der Grund dafür ist, dass wir jetzt die kompilierte JavaScript-Dateien laden möchten. Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren. Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module system app/main.ts
```

Erklärung:

tsc ist der TypeScript-Kompiler. Die Flags "--emitDecoratorMetadata" und "--experimentalDecorators" sind in unserem Beispiel optional, werden aber für die Angular Rezepte gebraucht. Der Flag "--module" gibt an, dass die ES6/ES2015 Module die wir nutzen in SystemJS-Module umgewandelt werden soll. Als letztes geben wir die main.ts-Datei an. Da die main.ts-Datei weiter Module importiert, werden diese Module auch automatisch kompiliert.

W> ## Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierende JavaScript-Dateien, werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

Der TypeScript-Kompiler bietet noch mehr Optionen an die wir nutzen können. Zwei davon werden wir noch gleich sehen. Die restliche befinden sich [hier](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options).

### Dateien automatisch kompilieren mit "watch"

Bei jede Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Kompiler eine einfache Lösung. Es gibt ein speziellen Flag namens "--watch". Mit diesem Flag werden die Dateien automatisch bei jede Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module system --watch app/main.ts
```

### Sourcemaps generieren

Nach dem kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein. Das kann das debugging erschweren wenn z. B. der Browser ein Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei korrigieren möchten. Für genau solche Fälle gibt es Sourcemaps die uns die richtige Zeile in der TypeScript-Datei anzeigen. Um Sourcemaps zu erzeugen, nutzen wir eine weiter Option des Kompilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --module system --sourceMap app/main.ts
```

Erklärung:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren wenn man das möchte.

