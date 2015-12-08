# Einführung zu TypeScript

Vermutlich ist TypeScript für einige Leser Neuland, und aus diesem Grund haben wir uns entschieden, dass das Buch auch eine kurze Einführung zu TypeScript beinhalten soll.
TypeScript ist eine von Microsoft geschriebene Programmiersprache mit derer man Anwendungen schreiben kann, die dann später zu JavaScript kompiliert werden, damit sie z. B. im Browser funktionieren. Es ist eine typisierte Übermenge von JavaScript (ES5). Außer Typen unterstützt TypeScript auch gewisse Features aus ES6/ES2015 aber auch Features die vermutlich in ES7/ES2016 standardisiert werden. Da TypeScript eine Übermenge von JavaScript ist, ist auch jede JavaScript Anwendung zumindest Anwendungen die mit ES5 geschrieben wurden sind, auch eine valide TypeScript Anwendung.

Wir werden uns nicht die komplette TypeScript Funktionalität anschauen, sondern nur die Teile die wir auch in den verschiedenen Rezepten brauchen werden.
Der Grund dafür ist einfach, wir möchten uns auf Angular 2 konzentrieren und nicht zu viele Zeit mit TypeScript verbringen.
Um die komplette Funktionalität von TypeScript abzudecken, bräuchte man ein eigenes Buch dafür.
Der große Vorteile von TypeScript gegenüber von plain JavaScript, ist das Typ-System das uns TypeScript zur Verfügung stellt.
Dieses ermöglicht uns Typinformationen zu hinterlegen für Variablen, Funktionen, Objekten und mehr.
In kleineren Anwendungen ist dieser Vorteil vielleicht nicht so relevant, da wir dort relativ schnell ein Überblick bekommen kann, welche Datentypen wo verwendet werden.
Wer aber größere JavaScript Anwendungen geschrieben hat, weißt wie schwer es sein kann den Überblick zu bewahren und heraus zu finden z. B. welche Eigenschaften ein bestimmtes Objekt hat.
Mit Hilfe von Typinformationen können wir solche Probleme vermeiden.
Da Typen ein so wichtiger Aspekt von TypeScript sind, werden wir uns als erstes damit befassen.

## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. string, boolean und number aber es erlaubt es uns auch eigenen Typen zu definieren mit Hilfe von Interfaces die wir im nächsten Abschnitt uns anschauen werden. Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 7 Typen die immer vorhanden sind:
* Boolean
* Number
* String
* Array
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem doppelt Punkt (:). Wenn wir nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen doppelt Punkt sehen, dann handelt es sich um eine Typdefinition.

### Boolean

Diese Typ ist für boolesche Werte gedacht und beinhaltet die Werte true und false. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

Der unterschied zu plain JavaScript ist der Doppelpunkt nach dem Variablennamen. Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtige Werte zuweisen. Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr.

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in dem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string". Es ist dabei egal, ob wir dabei Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich. Backticks werden für ES6/ES2015 [template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) benutzt und die werden auch von TypeScript unterstützt.

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

Die oben gezeigte Beispiele sind all valide Werte vom Typ String.

### Array

Dieser Typ wird für Liste verwendet und es ist ein zusammen gesetzter Typ. Das bedeutet, dass wir auch noch den Typ der Elemente der Liste angeben müssen. Es gibt zwei Möglichkeiten dies zu tun.

```js
var list: number[] = [1, 2, 3];
```

Oben haben wir eine Liste von Zahlen definiert. Als erstes haben wir gesagt, dass der Typ der Elementen "number" ist und mit den eckigen Klammern, haben wir TypeScript gesagt, dass es sich um ein Array handelt.

Die zweite Möglichkeit um Array-Typen zu definieren nutzt ein generische Typdefinition.

```js
var list: Array<number> = [1, 2, 3];
```

Die kleiner (<) und größer (>) Zeichen geben an das es sich um ein generischen Typ handelt. Das TypeScript-Handbuch hat mehr Informationen über [generische Typen](http://www.typescriptlang.org/Handbook#generics). Wir werden uns hier nicht weiter damit befassen.

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für nummerische Werte angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

Beim Kompilieren werden die Werte DONE, IN\_PROGRESS und NEW in Zahlen von 0 bis 2 umgewandelt. Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren ob die Zahlen von 0 oder von 1 Anfangen. Mehr Informationen über [Enums gibt es im TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#basic-types-enum).

### Any

Hier reden wir nicht über ein echten Typ sondern, um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll wenn z. B. die Variable nicht den richtigen Typ hat.
Den "any"-Typ können wir auch benutzen wenn wir wie hier ein Array haben mit Elementen von unterschiedlichen Typen.

```js
var list: Array<any> = [1, true, 'false'];
```

Dank des "any"-Typs können wir existierendes JavaScript als TypeScript behandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.

### Void

Void ist so zusagen der leerer Typ oder einfach die Abwesenheit eines Typs. Werte vom Typ "void" sind "null" und "undefined". Dieser Typ wird oft benutzt bei Funktionen die kein Rückgabewert haben.

```js
function test(): void {
  console.log('test');
}
```

## Interfaces

Nachdem wir uns die Basistypen von TypeScript angeschaut haben werden wir jetzt sehen wie wir eigene Typen mit Hilfe von Interfaces definieren können.
Es ist vielleicht dem einen oder dem anderen aufgefallen, dass wir kein Basistyp für Objekte, ausgenommen von Arrays, gesehen haben.
Mit Interfaces können wir genau dies tun, wir können den Typ von Objekten definieren.

Wir haben zwei Möglichkeiten ein Interface zu definieren. Einmal anonyme Interfaces z. B. bei eine Variablendefinition oder benannte Interfaces mit dem Keyword "interface". In beiden Fällen wird der kompilierter JavaScript-Code, den Code für das Interface nicht beinhalten. Als erstes schauen wir uns anonyme Interfaces an.

```js
var user: {name: string; age: number};
user = {
  name: 'Max',
  age: 23
};
```

Hier wird erwartet, dass die "user"-Variable ein Objekt ist mit mindestens den Eigenschaften "name" und "age". Falls diese Eigenschaften nicht vorhanden sind, oder nicht den richtigen Typ haben, wird der Kompiler uns warnen. User Objekt kann auch mehr als nur diese beiden Eigenschaften haben, aber das wird vom Kompiler nicht überprüft.

Benannte Interfaces haben die gleiche Schreibweise, mit dem Unterschied, dass sie ein Namen haben und sie das Keyword "interface" brauchen.

```js
interface User {
  name: string;
  age: number;
}
var user: User;
user = {
  name: 'Max',
  age: 23
}
```

Wir haben hier die einfachste Form von Interfaces gezeigt. Aber TypeScript bietet uns da noch mehr Möglichkeiten wie Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr. Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#interfaces) nachschauen.

## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015 Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes). Beide bieten uns eine einfachere Möglichkeit an in JavaScript bzw. TypeScript Objekt-orientiert zu programmieren. Auch wenn wir hier das Keyword "class" nutzen werden, arbeiten wir hier nicht mit echten Klassen wie man die vielleicht aus Java oder andere Programmiersprachen kennt. Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp. So sieht eine Klasse in TypeScript aus:

```js
// Klassendefinition
class User {
  constructor(name) {
    this.name = name;
  }
  print() {
    console.log(this.name);
  }
}

// Nutzung
var user = new User('Max');
```

Nach dem "class"-Keyword kommt der Name der Klasse, in unserem Fall "User" und in der Klasse gibt es eine optional Konstruktorfunktion (constructor) mit dem Parameter "name" und eine "print"-Methode. In ES5 würde unsere Klasse so aussehen:

```js
// Konstruktorfunktion
function User(name) {
  this.name = name;
}
// Prototypmethoden
User.prototype.print = function() {
  console.log(this.name);
}

var user = new User('Max');
```

Der Namen der Konstruktorfunktion wird in TypeScript als Klassennamen benutzt und der Rumpf der Konstruktorfunktion und ihre Parameter, werden der constructor-Eigenschaft übergeben. Die restliche Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft gehören. Da wir hier mit TypeScript arbeiten, können wir natürlich auch Typinformationen in unsere Klassen hinterlegen. So könnte die Klasse von oben aussehen mit Typinformationen:

```js
class User {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

In Zeile 2, sagen wir TypeScript, dass unsere Instanzen der Klasse User eine Instanzvariable namens "name" mit Typ "string" haben. Das hier ist ein von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen. In ES6/ES2015 Klassen haben wir keine Typinformationen und wir geben auch nicht an was für Instanzvariablen unsere Instanzen haben. Ein weiteren Unterschied sehen wir hier:

```js
class User {
  name: string = '';
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

Dieses mal haben wir in Zeile 2 direkt einen Wert an unsere Instanzvariable "name" zugewiesen. Diese Schreibweise ist vor allem nützlich wenn wir der Instanzvariable einen Standardwert geben möchten oder wenn man mit statischen Daten arbeitet. Auch das ist in ES6/ES2015 Klassen nicht erlaubt, aber es ist möglich, dass [ES7/ES2016 Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich aber ohne die Typinformation. Im allgemeinen können TypeScript Klassen noch viel mehr als hier beschrieben, aber das reicht uns um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript Klassen erfahren möchte, kann [hier](http://www.typescriptlang.org/Handbook#classes) nachlesen.

## Beispielanwendung

Um besser zu verstehen wie Typen, Interfaces und Klassen zusammen arbeiten, gibt es hier noch eine kleine TypeScript Todo-Anwendung. Die Anwendung kann vordefinierte Todos anzeigen und neue Todos in einer existierende Liste von Todos hinzufügen. Es ist zwar eine kleine Anwendung, ist aber trotzdem in mehrere Dateien aufgespaltet, um zu zeigen wie man in TypeScript mit Hilfe von ES6/ES2015 Modulen eine Anwendung modular gestalten kann. Der komplette Code für die Anwendung befindet sich im Github unter [01-TypeScript/01-Simple\_Todo\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/01-Simple_Todo_App).

Die Anwendung hat 2 Verzeichnisse, ein Verzeichnis für den Anwendungscode und eins für Interfaces. Natürlich gibt es auch eine index.html-Datei, in der wir die Anwendung laden und im Browser anzeigen. Das Verzeichnis für den Anwendungscode heißt "app" und das für die Interfaces "interfaces". Im app-Verzeichnis gibt es 3 Dateien namens "main.ts", "todo\_item.ts" und "todo\_list.ts". Den Inhalt diese Dateien werden wir gleich sehen. Im interfaces-Verzeichnis gibt es die itodo.ts-Datei, die ein Todo repräsentiert.

{title="index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>TypeScript - Todo App</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script>
    System.config({
      transpiler: 'typescript',
      typescriptOptions: {
        emitDecoratorMetadata: true
      },
      packages: {'app': {defaultExtension: 'ts'}}
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

* Zeile 6: Laden von SystemJS
* Zeile 7: Laden vom TypeScript-Compiler
* Zeile 8-17: Konfiguration für SystemJS und Laden der Anwendung
  * Zeile 10: Hier sagen wir SystemJS, dass unsere Module mit TypeScript geschrieben sind, und dass die on-the-fly kompiliert werden sollen, vor der Browser die nutzten kann
  * Zeile 11-13: Optionen für den TypeScript-Compiler. Die angegebene Option ist für die Beispiel-Anwendung nicht erforderlich, wird aber später bei unsere Rezepte gebraucht, um [Decorators]{#gl-decorator} richtig anwenden zu können
  * Zeile 14: Hier sagen wir SystemJS, dass alle Dateien im Verzeichnis "app" eine ".ts" Endung haben. Somit brauchen wir bei imports nicht explizit die Endung anzugeben
  * Zeile 16: Laden der main.ts-Datei, das Hauptmodul unserer Anwendung

W> ## Achtung
W>
W> Wichtig zu beachten ist, dass wir hier TypeScript on-the-fly, sprich im Browser kompilieren. Für unsere kleine Anwendung ist das noch in Ordnung, wird aber für größere Anwendungen zu langsam sein. Wir werden in einem weiteren Abschnitt sehen wie wir die TypeScript-Dateien vorkompilieren können.

I> ## SystemJS
I>
I> SystemJS ist ein Modullader, der verschiedene Arten von Modulen wie z. B. CommonJS, AMD und ES6/ES2015 Module unterstützt. Strenggenommen müssen wir SystemJS nicht nutzen, es gibt auch andere Möglichkeiten, aber da es vom Angular-Team empfohlen wird, nutzen wir es hier. Wer mehr über SystemJS erfahren möchte kann [hier](https://github.com/systemjs/systemjs) darüber lesen.

{title="interfaces/itodo.ts", lang=js}
```
interface ITodo {
  title: string;
  checked: boolean;
  render: (listElement: HTMLElement) => HTMLElement;
}
```

Erklärung:

Interface für eine Todo-Element. Beschreibt eine Todo-Item Instanz (todo\_item.ts).

* Zeile 1: Der Namen des Interfaces ist "ITodo"
* Zeile 2: Ein Element vom Typ "ITodo" hat eine Eigenschaft "title" vom Typ "string"
* Zeile 3: Ein Element vom Typ "ITodo" hat eine Eigenschaft "checked" vom Typ "boolean"
* Zeile 4: Ein Element vom Type "ITodo" hat eine Methode namens "render". Diese Methode hat ein Parameter vom Typ "HTMLElement" und gibt zurück ein Element vom Typ "HTMLElement". Der Rückgabetyp kommt nach dem größer, gleich Zeichen (=>)

{title="app/main.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>
import TodoList from './todo_list';
import TodoItem from './todo_item';

const todos: Array<ITodo> = [new TodoItem('Todo 1'), new TodoItem('Todo 2')];

const inputElement: HTMLInputElement = document.getElementsByTagName('todoTitle').item(0);
const button: HTMLElement = document.getElementById('addTodo');
const todosList: HTMLElement = document.getElementById('todosList');

const todoList = new TodoList(todos);

todoList.render(todosList);

button.addEventListener('click', function(event) {
  event.preventDefault();
  const todoTitle: string = inputElement.value;
  todoList.add(new TodoItem(todoTitle));
  todoList.clear(todosList);
  todoList.render(todosList);
});
```

Erklärung:

Das Hauptmodul für unsere Anwendung. Instanziert Todos und die Liste, hat Zugriff auf DOM-Elemente und ruft Methoden auf, um die Todos anzuzeigen und um eine Todo hinzuzufügen.

* Zeile 1: Importiere die Typdefinition für den Typ "ITodo". Ohne diese Zeile, kann TypeScript nicht wissen wie ein Element vom Typ "ITodo" aussieht
* Zeile 2-3: Importiere die Module TodoList und TodoItem mittels [ES6/ES2015 import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). Wir nutzen hier den Namen der Datei ohne Endung, da wir SystemJS schon gesagt haben, dass Dateien im app-Verzeichnis immer die Endung ".ts" haben
* Zeile 5: Todos für unsere Liste. Das Array ist vom Typ "ITodo"
* Zeile 7-9: DOM-Elemente an Konstanten zuweisen. Wir nutzen dafür das [ES6/ES2015 Keyword "const"](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const). Die Typen "HTMLInputElement" und "HTMLElement" sind in TypeScript vordefiniert

I> ## TypeScript DOM-Typen
I>
I> Leider scheint es keine Liste von Typen zu geben die TypeScript bereitstellt außer die Liste mit den Basistypen. Wer also mit dem Browser arbeitet und Typen für HTML-Elemente usw. sucht, muss in der [Typdefinitionsdatei für den DOM](https://github.com/Microsoft/TypeScript/blob/master/src/lib/dom.generated.d.ts) schauen.

{title="app/todo_item.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>

class TodoItem implements ITodo {
  title: string;
  checked: boolean;
  constructor(title: string) {
    this.title = title;
    this.checked = false;
  }
  render(listItem: HTMLElement): HTMLElement {
    const checkbox: HTMLInputElement = document.createElement('input');
    const label: HTMLLabelElement = document.createElement('label');

    checkbox.type = 'checkbox';
    checkbox.checked = this.checked;

    label.textContent = this.title;

    listItem.appendChild(checkbox);
    listItem.appendChild(label);

    return listItem;
  }
}

export default TodoItem;
```

Erklärung:

Modul und Klassendefinition für ein Todo-Element. In der letzte Zeile nutzen wir eine [ES6/ES2015 export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) um die Klasse zu exportieren, damit wir die in andere Modulen importieren und nutzen kann. Das besondere zur Vergleich zu den Klassen die wir in im [vorherigen Abschnitt](#c01-classes) gesehen haben, ist dass diese Klasse das "ITodo"-Interface implementiert. Mit dem Keyword "implements", können wir TypeScript sagen, dass unsere Klasse mindestens die Eigenschaften und Methoden vom angegebenen Interface haben muss.

{title="app/todo_list.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>

class TodoList {
  todos: Array<ITodo>;
  constructor(todos: Array<ITodo>) {
    this.todos = todos;
  }
  render(listElement: HTMLElement) {
    this.todos.forEach((todo: ITodo) => {
      const listItem: HTMLLIElement = document.createElement('li');
      listElement.appendChild(todo.render(listItem));
    });
  }
  add(todo: ITodo) {
    this.todos.push(todo);
  }
  clear(listElement: HTMLElement) {
    listElement.innerHTML = '';
  }
}

export default TodoList;
```

Erklärung:

Modul/Klasse für die gesamte Todo-Liste. Das meiste sollte uns schon bekannt sein, nur Zeile 9 hat eine Besonderheit. Statt eine normale Funktion (Keyword "function") nutzen wir hier eine [ES6/ES2015 Arrow-Funktion](https://jsperts.de/blog/arrow-functions/). Arrow-Funktionen sind kürzer zu schreiben und sie haben die Eigenschaft, dass sie den this-Wert ihrer Umgebung nutzen und kein eigenen this-Wert definieren.

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

