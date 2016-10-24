## TypeScript-Dateien vorkompilieren {#c01-precompile}

Wie schon erwähnt, ist das on-the-fly-Kompilieren von TypeScript-Dateien auf Dauer keine Lösung.
In diesem Abschnitt werden wir sehen, wie wir die TypeScript-Dateien vor dem Laden kompilieren können.
Als Erstes benötigen wir den TypeScript-Compiler.
Es gibt verschiedene Möglichkeiten, diesen herunterzuladen und zu installieren.
Wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind.
Wir können Node.js installieren, indem wir es von der [offiziellen Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js wird npm mit installiert.
Anschließend können wir den TypeScript-Compiler mit

```bash
npm install -g typescript
```

installieren.

Wir nehmen jetzt die Todo-Anwendung aus dem vorherigen Abschnitt und passen diese so an, dass die TypeScript-Dateien nicht mehr im Browser kompiliert werden.
Dazu müssen wir zwei Sachen machen: Erstens muss die index.html-Datei angepasst werden und zweitens müssen wir die TypeScript-Dateien kompilieren.
Der Code für die Anwendung mit angepasster index.html-Datei befindet sich in [01-TypeScript/02-Precompile](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/02-Precompile).

{title="Anpassungen an der index.html-Datei", lang=html}
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

__Erklärung__:

TypeScript wird jetzt nicht mehr in der index.html-Datei geladen. In der SystemJS-Konfiguration haben wir die transpiler-Eigenschaft und die Optionen für den Compiler entfernt. Einen weiteren Unterschied sehen wir in Zeile 9, wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts". Der Grund dafür ist, dass wir nun die kompilierten JavaScript-Dateien laden möchten. Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren. Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs app/main.ts
```

__Erklärung__:

tsc ist der TypeScript-Compiler. Die Optionen "emitDecoratorMetadata" und "experimentalDecorators" sind in unserem Beispiel optional.
Diese werden später für die Angular-Rezepte gebraucht.
Die Option "module" gibt an, dass die ESM, die wir nutzen, in CommonJS-Module umgewandelt werden sollen.
Die Option "target" gibt, welcher ECMAScript-Version unser JavaScript entsprechen soll.
Hier nutzen wir ECMAScript 5.
Als Letztes geben wir die main.ts-Datei an.
Die weiteren Module, die die main.ts-Datei importiert, werden automatisch mit kompiliert.
Wir müssen also nicht jede Datei einzeln kompilieren.
Der TypeScript-Compiler bietet noch mehr Optionen an, die wir nutzen können. Zwei davon werden wir gleich noch sehen. Weitere Optionen werden im [TypeScript-Wiki](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options) erläutert.

W> #### Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierenden JavaScript-Dateien werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

I> #### CommonJS
I>
I> CommonJS ist ein Modul-Standard, der hauptsächlich in Node.js verwendet wird. Wir nutzen CommonJS, weil dies die Zusammenarbeit von TypeScript mit externen Bibliotheken wie Angular 2 vereinfacht. Durch die Verwendung von CommonJS-Modulen ist der Compiler in der Lage, automatisch nach Typdefinitionen für externe Bibliotheken im node\_modules-Verzeichnis zu suchen, ohne dass wir ihm sagen müssen, wo die Typdefinitionen sind.

I> #### Die target-Option
I>
I> Standardmäßig nutzt der TypeScript-Compiler ECMAScript 3 als "target". Der generierte JavaScript-Code ist also ES3 kompatibel. ES3 zu nutzen ist nur sinnvoll, wenn wir alte Browser wie z. B. den Internet Explorer 8 unterstützen möchten. Da Angular 2 nur neuere Browser (ab Internet Explorer 9) unterstützt, können wir ruhig ES5 nutzen. Ein weiterer Grund, ES5 zu nutzen, ist, dass manche TypeScript-Features wie z. B. [getters/setters](https://www.typescriptlang.org/docs/handbook/classes.html#accessors) für Klassen in ES3 nicht unterstützt werden.

### Dateien automatisch kompilieren mit "watch"

Bei jeder Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Compiler eine einfache Lösung.
Es gibt eine Option namens "watch". Mit dieser Option werden die Dateien automatisch bei jeder Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --watch app/main.ts
```

__Erklärung__:

Mit der watch-Option werden unsere Dateien bei jeder Änderung automatisch neukompiliert. Das gilt nicht nur für die angegebene app/main.ts-Datei, sondern auch für alle Dateien, die importiert werden.

### Sourcemaps generieren

Nach dem Kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein.
Das kann das Debugging erschweren, wenn z. B. der Browser einen Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei finden und korrigieren möchten.
Für genau solche Fälle gibt es Sourcemaps, die uns die richtige Zeile in der TypeScript-Datei anzeigen.
Um Sourcemaps zu erzeugen, nutzen wir eine weitere Option des Compilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --sourceMap app/main.ts
```

__Erklärung__:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren, wenn wir das möchten.

### Konfigurationsdatei für den Compiler nutzen

Auf Dauer kann es nerven, die ewig lange Zeile einzutippen, um unser Projekt zu kompilieren.
Eine Alternative hierfür bietet die tsconfig.json-Datei. Darin können wir alle nötige Optionen angeben und dann den Compiler aufrufen, ohne selbst die Optionen angeben zu müssen.

{title="tsconfig.json", lang=json}
```
{
  "compilerOptions": {
    "module": "commonjs",
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "target": "ES5"
  }
}
```

Das Verzeichnis, in dem sich die tsconfig.json-Datei befindet, ist das Hauptverzeichnis unseres TypeScript-Projektes.
Nachdem wir die config-Datei erstellt haben, haben wir zwei Möglichkeiten, unsere Anwendung zu kompilieren.

Wir können

```bash
tsc
```

im Haupt- oder einem Unterverzeichnis unserer Anwendung aufrufen oder wir können

```bash
tsc -p Hauptverzeichnis
```

aufrufen, wobei __Hauptverzeichnis__ der Pfad zu dem Verzeichnis ist, in dem die tsconfig.json-Datei liegt.
Da unsere config-Datei die files-Eigenschaft nicht setzt, werden alle \*.ts-Dateien kompiliert, die sich im Haupt- und in den Unterverzeichnissen befinden. Das TypeScript-Handbuch bietet weitere Informationen über die [tsconfig.json-Datei](http://www.typescriptlang.org/docs/handbook/tsconfig.json.html) und die Eigenschaften, die diese enthalten kann.

