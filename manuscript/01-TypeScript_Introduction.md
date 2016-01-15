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

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. "string", "boolean" und "number", aber es erlaubt es uns auch eigenen Typen zu definieren mit Hilfe von Interfaces die wir im nächsten Abschnitt uns anschauen werden. Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 7 Typen die immer vorhanden sind:
* Boolean
* Number
* String
* Array
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem Doppelpunkt (:). Wenn wir nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen Doppelpunkt sehen, dann handelt es sich um eine Typdefinition. Der Wert nach dem Doppelpunkt gibt den Typ an. Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtige Werte zuweisen. Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr. Um schnell zu sehen wie der kompilierter Code aussieht, kann man den [TypeScript Playground](http://www.typescriptlang.org/Playground) nutzen.

### Boolean

Diese Typ ist für boolesche Werte gedacht und beinhaltet die Werte true und false. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in dem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string". Es ist dabei egal, ob wir dabei Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich. Backticks werden für ES6/ES2015 [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) benutzt und die werden auch von TypeScript unterstützt. Die unten gezeigte Beispiele, sind alle valide Werte vom Typ "string".

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

### Array

Der Typ "Array" wird für Listen verwendet. Damit die Typdefinition ein Sinn ergibt, müssen wir auch den Typ der Elemente der Liste angeben. Unten werden die zwei Möglichkeiten gezeigt die wir haben, um den Typ einer Liste zu definieren.

```js
var list1: number[] = [1, 2, 3];
var list2: Array<number> = [1, 2, 3];
```

Erklärung:

* Zeile 1: Eine Liste von Zahlen definieren. Als erstes haben wir gesagt, dass der Typ der Elementen "number" ist und mit den eckigen Klammern, haben wir TypeScript gesagt, dass es sich um ein Array handelt
* Zeile 2: Auch eine Liste von Zahlen, diesmal mit eine generische Typdefinition. Die kleiner (<) und größer (>) Zeichen geben an, dass es sich um ein generischen Typ handelt. Das TypeScript-Handbuch hat mehr Informationen über [generische Typen](http://www.typescriptlang.org/Handbook#generics)

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für nummerische Werte angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

Erklärung:

Beim Kompilieren werden die Werte DONE, IN\_PROGRESS und NEW in Zahlen von 0 bis 2 umgewandelt. Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren ob die Zahlen von 0 oder von 1 Anfangen. Mehr Informationen über [Enums gibt es im TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#basic-types-enum).

### Any

Hier reden wir nicht über ein echten Typ sondern, um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll wenn z. B. die Variable nicht den richtigen Typ hat.
Dank des "any"-Typs können wir existierendes JavaScript als TypeScript behandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.
Den "any"-Typ können wir auch benutzen wenn wir wie hier ein Array haben mit Elementen von unterschiedlichen Typen.

```js
var list: Array<any> = [1, true, 'false'];
```

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

Wir haben zwei Möglichkeiten ein Interface zu definieren. Einmal als anonymes Interface z. B. bei eine Variablendefinition oder als benanntes Interface mit dem Keyword "interface". In beiden Fällen wird der kompilierter JavaScript-Code, den Code für das Interface nicht beinhalten. Als erstes schauen wir uns anonyme Interfaces an.

{title="Typdefinition für ein Objekt mit ein anonymes Interface", lang=js}
```
var user: {name: string; age: number};
user = {
  name: 'Max',
  age: 23
};
```

Erklärung:

Hier wird erwartet, dass die "user"-Variable ein Objekt ist mit mindestens den Eigenschaften "name" und "age". Falls diese Eigenschaften nicht vorhanden sind, oder nicht den richtigen Typ haben, wird der Compiler uns warnen. User Objekt kann auch mehr als nur diese beiden Eigenschaften haben, aber das wird vom Compiler nicht überprüft.

Benannte Interfaces haben die gleiche Schreibweise, mit dem Unterschied, dass sie ein Namen haben und sie das Keyword "interface" brauchen. Sie sind auch nicht Teil der Variablendeclaration, sondern eine Anweisung für sich.

{title="Typdefinition für ein Objekt mit ein benanntes Interface", lang=js}
```
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

Erklärung:

Erst wird das Interface definiert (Zeile 1-4) und dann in Zeile 5 benutzt. Ansonsten gilt für den Typ das gleiche wie schon oben erklärt.

Wir haben hier die einfachste Form von Interfaces gezeigt. Aber TypeScript bietet uns da noch mehr Möglichkeiten wie Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr. Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#interfaces) nachschauen. Wir sehen im nächsten Abschnitt wie man Interfaces mit Klassen nutzen kann.

## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015 Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes). Beide bieten uns eine einfache Möglichkeit in JavaScript bzw. TypeScript Objekt-orientiert zu programmieren. Auch wenn wir hier das Keyword "class" nutzen werden, arbeiten wir hier nicht mit echten Klassen wie man die vielleicht aus Java oder andere Programmiersprachen kennt. Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp.

{title="ES6/ES2015 Klasse", lang=js}
```
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

Erklärung:

* Zeile 2: Nach dem "class"-Keyword kommt der Namen der Klasse, in unserem Fall "User"
* Zeile 3-5: Die Klasse hat eine optionale constructor-Funktion mit dem Parameter "name". Diese Funktion wird aufgerufen wenn wir wie in Zeile 12 "new" benutzen
* Zeile 6: Methode namens "print"

{title="Die User-Klasse in ES5 Schreibweise", lang=js}
```
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

Erklärung:

Zeile 2 definiert eine Konstruktorfunktion mit Namen "User". In ES6/ES2015/TypeScript wird diese Namen als Klassennamen benutzt. Der Rumpf dieser Funktion und ihre Parameter, werden in der constructor-Funktion benutzt. Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft der Konstruktorfunktion gehören.

{title="TypeScript Klasse", lang=js}
```
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

Erklärung:

In Zeile 2, sagen wir TypeScript, dass unsere Instanzen der Klasse User eine Eigenschaft namens "name" mit Typ "string" haben. Das ist ein von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen. Da wir hier mit TypeScript arbeiten, können wir natürlich auch Typinformationen in unsere Klassen hinterlegen. Wie immer ist die Typangabe optional, aber wir müssen den Namen der Eigenschaft angeben ansonsten wird der Compiler eine Warnung geben. Wir können also Zeile 2 auch so schreiben: "name;" ohne die Typangabe.

{title="Eine weitere Schreibweise von TypeScript Klassen", lang=js}
```
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

Erklärung:

Dieses mal haben wir in Zeile 2 direkt einen Wert an unsere Instanzvariable "name" zugewiesen. Diese Schreibweise ist vor allem nützlich wenn wir der Instanzvariable einen Standardwert geben möchten oder wenn man mit statischen Daten arbeitet. Auch das ist in ES6/ES2015 Klassen nicht erlaubt, es ist aber möglich, dass [ES7/ES2016 Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich ohne die Typinformation.

### Klassen mit Interfaces

Ein weiterer Vorteil von TypeScript-Klassen gegenüber ES6/ES2015 Klassen ist, dass TypeScript-Klassen ein Interface implementieren können. Dazu nutzt man das Keyword "implements" bei der Klassendefinition.

{title="TypeScript Klasse mit Interface", lang=js}
```
interface IUser {
  name: string;
  print(): void;
}

class User implements IUser {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

Erklärung:

* Zeile 1-4: Interfacedefinition
  * Zeile 3: Typdefinition für eine Methode. Der Namen der Methode ist "print", sie hat keine Parameter und der Rückgabetyp ist "void"
* Zeile 6-14: Klassendefinition
  * Zeile 6: Nutzung des Keywords "implements", heißt für uns, dass User-Instanzen vom Typ "IUser" sein müssen

Im allgemeinen können TypeScript Klassen noch mehr als hier beschrieben, aber das reicht uns um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript Klassen erfahren möchte, kann [hier](http://www.typescriptlang.org/Handbook#classes) nachlesen.

## Beispielanwendung

Um besser zu verstehen wie Typen, Interfaces und Klassen zusammen arbeiten, gibt es hier noch eine kleine TypeScript Todo-Anwendung. Die Anwendung kann vordefinierte Todos anzeigen und neue Todos in einer existierende Liste von Todos hinzufügen. Es ist zwar eine kleine Anwendung, ist aber trotzdem in mehrere Dateien aufgespaltet, um zu zeigen wie man in TypeScript mit Hilfe von ES6/ES2015 Modulen eine Anwendung modular gestalten kann. Der komplette Code für die Anwendung befindet sich im Github unter [01-TypeScript/01-Simple\_Todo\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/01-Simple_Todo_App).

Die Anwendung hat eine index.html-Datei in der wir die Anwendung laden und im Browser anzeigen und ein Verzeichnis namens "app" für unsere TypeScript-Dateien. Im app-Verzeichnis gibt es 3 Dateien namens "main.ts", "todo\_item.ts" und "todo\_list.ts".

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
  * Zeile 10: Hier sagen wir SystemJS, dass unsere TypeScript-Module on-the-fly kompiliert werden sollen, damit der Browser die nutzten kann
  * Zeile 11-13: Optionen für den TypeScript-Compiler. Die angegebene Option ist für die Beispiel-Anwendung nicht erforderlich, wird aber später bei unsere Rezepte gebraucht, um [Decorators]{#gl-decorator} richtig anwenden zu können
  * Zeile 14: Hier sagen wir SystemJS, dass alle Dateien im Verzeichnis "app" eine ".ts" Endung haben. Somit brauchen wir bei dem Importieren eines Moduls, nicht explizit die Endung anzugeben
  * Zeile 16: Laden der main.ts-Datei, das Hauptmodul unserer Anwendung

W> #### Achtung
W>
W> Wichtig zu beachten ist, dass wir hier TypeScript on-the-fly, sprich im Browser kompilieren. Für unsere kleine Anwendung ist das noch in Ordnung, wird aber für größere Anwendungen zu langsam sein. Wir werden in einem weiteren Abschnitt sehen wie wir die TypeScript-Dateien vorkompilieren können.

I> #### SystemJS
I>
I> SystemJS ist ein Modullader, der verschiedene Arten von Modulen wie z. B. CommonJS, AMD und ES6/ES2015 Module unterstützt. Strenggenommen müssen wir SystemJS nicht nutzen, es gibt auch andere Möglichkeiten, aber da es vom Angular-Team empfohlen wird, nutzen wir es hier. Wer mehr über SystemJS erfahren möchte kann [hier](https://github.com/systemjs/systemjs) darüber lesen.

{title="app/main.ts", lang=js}
```
import TodoList from './todo_list';
import TodoItem from './todo_item';

const todos: Array<TodoItem> = [new TodoItem('Todo 1'), new TodoItem('Todo 2')];

const inputElement: HTMLInputElement = document.getElementsByTagName('input').item(0);
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

Dies ist das Hauptmodul für unsere Anwendung. Instantiiert Todos und die Liste, hat Zugriff auf DOM-Elemente und ruft Methoden auf, um die Todos anzuzeigen und hinzuzufügen.

* Zeile 1-2: Importiere die Module TodoList und TodoItem mittels [ES6/ES2015 import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). Wir nutzen hier den Namen der Datei ohne Endung, da wir SystemJS schon gesagt haben, dass Dateien im app-Verzeichnis immer die Endung ".ts" haben (Zeile 14, index.html)
* Zeile 4: Todos für unsere Liste. Das Array ist vom Typ "TodoItem"
* Zeile 6-8: DOM-Elemente an Konstanten zuweisen. Wir nutzen dafür das [ES6/ES2015 Keyword "const"](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const). Die Typen "HTMLInputElement" und "HTMLElement" sind in TypeScript vordefiniert

I> #### TypeScript DOM-Typen
I>
I> Leider scheint es keine Liste von Typen zu geben die TypeScript bereitstellt, außer der Liste mit den Basistypen. Wer also mit dem Browser arbeitet und Typen für HTML-Elemente usw. sucht, muss in der [Typdefinitionsdatei für den DOM](https://github.com/Microsoft/TypeScript/blob/master/src/lib/dom.generated.d.ts) schauen.

{title="app/todo_item.ts", lang=js}
```
class TodoItem {
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

Modul und Klassendefinition für ein Todo-Element. Unsere Klasse erzeugt Instanzen vom Typ "TodoItem". In der letzte Zeile nutzen wir eine [ES6/ES2015 export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) um die Klasse zu exportieren, damit wir die in anderen Modulen importieren und nutzen kann.

{title="app/todo_list.ts", lang=js}
```
import TodoItem from './todo_item';

class TodoList {
  todos: Array<TodoItem>;
  constructor(todos: Array<TodoItem>) {
    this.todos = todos;
  }
  render(listElement: HTMLElement) {
    this.todos.forEach((todo: TodoItem) => {
      const listItem: HTMLLIElement = document.createElement('li');
      listElement.appendChild(todo.render(listItem));
    });
  }
  add(todo: TodoItem) {
    this.todos.push(todo);
  }
  clear(listElement: HTMLElement) {
    listElement.innerHTML = '';
  }
}

export default TodoList;
```

Erklärung:

Modul/Klasse für die Todo-Liste. Wir haben hier 3 Methoden, "render", "add" und "clear" und die Todo-Liste als Eigenschaft vom Typ "Array<TodoItem>" mit Namen "todos".

* Zeile 1: Hier importieren wir "TodoItem" um es als Typ zu verwenden und nicht mit "new". Dieser Import wird im kompilierten Code nicht vor kommen
* Zeile 9: Statt eine normale Funktion (Keyword "function") nutzen wir hier eine [ES6/ES2015 Arrow-Funktion](https://jsperts.de/blog/arrow-functions/). Arrow-Funktionen sind kürzer zu schreiben und sie haben die Eigenschaft, dass sie den this-Wert ihrer Umgebung nutzen und kein eigenen this-Wert definieren

Da SystemJS Ajax nutzt, um die einzelne Module zu laden brauchen wir eine Webserver, um unsere Todo-Anwendung zu testen. Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server) der automatisch die Seite bei Änderungen im Browser Neuladen kann. Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen. Beide Webserver sind über npm installierbar. Natürlich kann man auch andere Webserver nutzen wie z. B. Apache, nginx oder Webserver die in einem IDE integriert sind.

## TypeScript-Dateien vorkompilieren {#c01-precompile}

Wie schon angekündigt, ist das on-the-fly Kompilieren von TypeScript auf Dauer keine Lösung. In diesem Abschnitt werden wir sehen wie wir die TypeScript-Dateien vor dem Laden im Browser kompilieren können.
Als erstes brauchen wir den TypeScript-Compiler. Es gibt verschiedene Möglichkeiten, um den TypeScript-Compiler herunter zu laden. Wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind. Wir können Node.js installieren, in dem wir es von der [offizielle Webseite](https://nodejs.org/en/download/) herunter laden. Bei der Installation von Node.js, wird npm mit installiert.
Nachdem Node.js und npm installiert sind, können wir den Compiler mit

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

TypeScript wird jetzt nicht mehr in der index.html-Datei geladen und in der SystemJS-Konfiguration haben wir die transpiler-Eigenschaft und die Optionen für den Compiler entfernt. Einen weiteren Unterschied sehen wir in Zeile 9 wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts". Der Grund dafür ist, dass wir jetzt die kompilierte JavaScript-Dateien laden möchten. Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren. Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs app/main.ts
```

Erklärung:

tsc ist der TypeScript-Compiler. Die Optionen "--emitDecoratorMetadata" und "--experimentalDecorators" sind in unserem Beispiel optional, werden aber später für die Angular Rezepte gebraucht. Die Option "--module" gibt an, dass die ES6/ES2015 Module die wir nutzen in CommonJS-Module umgewandelt werden sollen. Die Option --target gibt an welchen ECMAScript-Version unser JavaScript entsprechen soll. Hier nutzen wir ECMAScript 5. Als letztes geben wir die main.ts-Datei an. Da die main.ts-Datei weitere Module importiert, werden diese automatisch kompiliert. Wir müssen also nicht jedes Modul einzeln kompilieren.
Der TypeScript-Compiler bietet noch mehr Optionen an die wir nutzen können. Zwei davon werden wir noch gleich sehen. Weitere Optionen gibt es im [TypeScript-Wiki](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options).

W> #### Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierende JavaScript-Dateien, werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

I> #### CommonJS
I>
I> CommonJS ist ein Modul-Standard der hauptsächlich in Node.js verwendet wird. Wir nutzen CommonJS, weil dies die Zusammenarbeit von TypeScript mit externen Bibliotheken wie Angular 2 vereinfacht. Durch die Verwendung von CommonJS-Modulen ist der Compiler in der Lage automatisch nach Typdefinitionen für externe Bibliotheken im "node\_modules" Verzeichnis zu suchen ohne, dass wir ihm sagen müssen wo die Typdefinitionen sind.

I> #### --target
I>
I> Standardmäßig nutzt der TypeScript-Compiler ECMAScript 3 als "target". ECMAScript 3 zu nutzen ist nur sinnvoll wenn wir alte Browser wie z. B. Internet Explorer 8 unterstützen möchten. Da Angular 2 nur neuere Browser (ab Internet Explorer 9) unterstützt, können wir ruhig ES5 nutzen. Ein weiterer Grund um ES5 zu nutzen ist, dass manche TypeScript-Features wie z. B. [getter/setters](http://www.typescriptlang.org/Handbook#classes-accessors) für Klassen, in ES3 nicht unterstützt werden.

### Dateien automatisch kompilieren mit "watch"

Bei jede Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Compiler eine einfache Lösung. Es gibt eine Option namens "--watch". Mit dieser Option werden die Dateien automatisch bei jede Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --watch app/main.ts
```

Erklärung:

Mit "--watch" werden unsere Dateien bei jede Änderung automatisch neukompiliert. Das gilt nicht nur für die angegebene "app/main.ts"-Datei, sondern auch alle Dateien die importiert werden.

### Sourcemaps generieren

Nach dem kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein. Das kann das Debugging erschweren wenn z. B. der Browser ein Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei korrigieren möchten. Für genau solche Fälle gibt es Sourcemaps die uns die richtige Zeile in der TypeScript-Datei anzeigen. Um Sourcemaps zu erzeugen, nutzen wir eine weiter Option des Compilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --sourceMap app/main.ts
```

Erklärung:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren wenn man das möchte.

### Konfigurationsdatei für den Compiler nutzen

Auf Dauer kann es nerven wenn man die ewig lange Zeile eintippen muss um unser Projekt zu kompilieren. Eine Alternative dafür bietet die tsconfig.json-Datei. Darin können wir alle nötige Optionen angeben und dann den Compiler aufrufen ohne selbst die Optionen angeben zu müssen.

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

Das Verzeichnis in dem sich die tsconfig.json-Datei befindet, ist das Hauptverzeichnis unseres TypeScript-Projektes. Nachdem wir die config-Datei erstellt haben, haben wir zwei Möglichkeiten um unsere Anwendung zu kompilieren.

Wir können

```bash
tsc
```

im Haupt- oder einem Unterverzeichnis unsere Anwendung aufrufen oder wir können

```bash
tsc -p Hauptverzeichnis
```

aufrufen wobei __Hauptverzeichnis__ der Pfad zu dem Verzeichnis ist, in dem die tsconfig.json-Datei liegt. Da unsere config-Datei die "files"-Eigenschaft nicht setzt, werden all \*.ts-Dateien kompiliert die sich im Haupt- und in den Unterverzeichnisse befinden. Das TypeScript-Wiki hat mehr Informationen über die [tsconfig.json-Datei](https://github.com/Microsoft/TypeScript/wiki/tsconfig.json) und die Eigenschaften die sie enthalten kann.

